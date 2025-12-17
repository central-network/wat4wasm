/**
 * WAT Kodunu Optimize Eder, Blokları Gruplar ve Boot Sırasına Koyar.
 * * @param {string} sourceCode - Ham WAT kodu
 * @param {string} extraLocals - (block $prepare) için gereken özel local tanımları
 * @param {string} prepareCode - TextDecoder vb. hazırlayan başlangıç bloğu
 */
export function optimizeWat(sourceCode, extraLocals = "", prepareCode = "") {
    // 1. $wat4wasm Fonksiyonunu Bul ve İzole Et
    const startRegex = /\(func\s+\$wat4wasm/;
    const match = startRegex.exec(sourceCode);
    if (!match) return sourceCode;

    const startIndex = match.index;
    let depth = 0;
    let endIndex = -1;

    // Fonksiyon gövdesini hatasız çıkarma
    for (let i = startIndex; i < sourceCode.length; i++) {
        if (sourceCode[i] === '(') depth++;
        else if (sourceCode[i] === ')') {
            depth--;
            if (depth === 0) {
                endIndex = i + 1;
                break;
            }
        }
    }
    if (endIndex === -1) return sourceCode;

    const oldFuncBody = sourceCode.substring(startIndex, endIndex);

    // 2. Veri Madenciliği: Table Set'leri Topla
    const tableSets = new Map();
    // Regex: (table.set $wat4wasm (i32.const 123) (local.get $ismi_bul))
    const tableSetRegex = /\(table\.set\s+\$wat4wasm\s+\(i32\.const\s+(\d+)\)\s+\(local\.get\s+([\$\w\.\/\:\-]+(?<!>))\)\)/g;
    let tsMatch;
    while ((tsMatch = tableSetRegex.exec(oldFuncBody)) !== null) {
        const index = tsMatch[1];
        const varName = tsMatch[2];
        if (!tableSets.has(varName)) tableSets.set(varName, []);
        tableSets.get(varName).push(index);
    }

    // 3. Blokları Tara ve Kategorize Et ($text ve $self)
    const selfBlocks = [];
    const textBlocks = [];
    let pointer = 0;

    const bodyStart = oldFuncBody.indexOf(";;", oldFuncBody.indexOf("$wat4wasm")) + 2;

    while (true) {
        // Genel blok arayıcı (Hem $self hem $text yakalar)
        const blockStart = oldFuncBody.indexOf("(block $", pointer);
        if (blockStart === -1) break;

        // Bloğun sonunu bul
        let d = 0;
        let blockEnd = -1;
        for (let k = blockStart; k < oldFuncBody.length; k++) {
            if (oldFuncBody[k] === '(') d++;
            else if (oldFuncBody[k] === ')') {
                d--;
                if (d === 0) {
                    blockEnd = k + 1;
                    break;
                }
            }
        }

        pointer = blockEnd;
        const rawBlock = oldFuncBody.substring(blockStart, blockEnd);

        // İsim Analizi
        const nameMatch = rawBlock.match(/^\(block\s+([\$\w\.\/\:\-<>\d]+)/);
        if (nameMatch) {
            const blockName = nameMatch[1];

            if (blockName.startsWith("$text")) {
                // Text Bloğu: Olduğu gibi sakla (Table set varsa içine gömülebilir ama şimdilik raw alıyoruz)
                // Eğer text bloklarının içinde local.set yoksa table logic çalışmaz, sorun yok.
                textBlocks.push(rawBlock);
            } else if (blockName.startsWith("$self")) {
                // Self Bloğu: Optimize edilecek
                selfBlocks.push({
                    name: blockName,
                    content: rawBlock
                });
            }
        }
    }

    // 4. $self Bloklarını Gruplandır ve Optimize Et (Eski Mantık)
    const selfGroups = new Map();
    selfBlocks.forEach(block => {
        const cleanName = block.name.replace("$self.", "").replace("$self", "");
        if (!cleanName) return;
        const root = cleanName.split(/[\.\/]/)[0];
        if (!selfGroups.has(root)) selfGroups.set(root, []);
        selfGroups.get(root).push(block);
    });

    let maxLevelUsed = 0;
    const optimizedSelfCode = []; // $self bloğunun içi

    // Helper: Level Hesaplama
    const calculateLevel = (name) => name.replace("$self", "").split(/[\.\/]/).filter(p => p).length;
    const getParentName = (name) => {
        const lastDot = name.lastIndexOf(".");
        const lastSlash = name.lastIndexOf("/");
        const splitIndex = Math.max(lastDot, lastSlash);
        if (splitIndex === -1) return "$self";
        return name.substring(0, splitIndex);
    };

    selfGroups.forEach((groupBlocks, rootName) => {
        // Alfabetik Sıralama (Baba-Çocuk ilişkisi için kritik)
        groupBlocks.sort((a, b) => a.name.localeCompare(b.name));

        const groupLines = [];
        groupLines.push(`
        (block $self.${rootName}`);

        groupBlocks.forEach(block => {
            const oldName = block.name;
            const level = calculateLevel(oldName);
            if (level > maxLevelUsed) maxLevelUsed = level;

            const currentVar = `$level/${level}`;
            const parentVar = `$level/${level - 1}`;

            let newContent = block.content;

            // Register Değişimi
            newContent = newContent.replace(`local.set ${oldName}`, `local.set ${currentVar}`);
            newContent = newContent.replaceAll(`(global.get $self)`, `(local.get $level/0)`);
            newContent = newContent.replaceAll(`(local.get $self)`, `(local.get $level/0)`);

            const parentName = getParentName(oldName);
            if (parentName !== "$self") {
                newContent = newContent.replaceAll(`(local.get ${parentName})`, `(local.get ${parentVar})`);
            }

            // Table Set Enjeksiyonu
            if (tableSets.has(oldName)) {
                const indices = tableSets.get(oldName);
                const setters = indices.map(idx => {
                    return `        (table.set $wat4wasm (i32.const ${idx}) (local.get ${currentVar}))`;
                }).join("\n");

                const lastParen = newContent.lastIndexOf(")");
                newContent = newContent.substring(0, lastParen) + "\n" + setters + "\n      )";
            }

            groupLines.push(`      ${newContent}`);
        });

        groupLines.push(`)`);
        optimizedSelfCode.push(groupLines.join("\n\n"));
    });

    // 5. Yeni Fonksiyon Gövdesini İnşa Et

    // A. Değişken Tanımları
    let localsDef = extraLocals + "\n"; // Dışarıdan gelen ($TextDecoder vs.)
    for (let i = 0; i <= maxLevelUsed; i++) {
        localsDef += `    (local $level/${i}      externref)\n`;
    }

    // B. Start Çağrısını Koru (Eğer varsa)
    const starterMatch = oldFuncBody.match(/\(call\s+(\$starter[\w\.]*)\)/);
    const starterCode = starterMatch ? `\n    (nop)\n    ${starterMatch[0]}` : "";

    // C. Ana Gövde Birleşimi
    const newFuncBody = `
    (func  $wat4wasm
        ${localsDef}
        ${prepareCode}

        (block $text
            (local.set $arguments (call $self.Array.of<ext>ext (local.get $buffer)))
        ${textBlocks.join("\n").trim()}
        )

        (block $self
            ${optimizedSelfCode.join("\n").trim()}
        )
        ${starterCode}
    )`.trim();

    return sourceCode.replace(oldFuncBody, newFuncBody);
}