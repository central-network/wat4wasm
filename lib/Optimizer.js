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
    const globalSets = new Map();


    const globalSetRegex = /\(global\.set\s+(\$self\.(.*))\s+\(local\.get\s+([\$\w\.\/\:\-]+(?<!>))\)\)/g;
    Array.from(oldFuncBody.matchAll(globalSetRegex)).map(gsMatch => {
        const idl = gsMatch[1];
        const varName = gsMatch[3];
        if (!globalSets.has(varName)) globalSets.set(varName, []);
        globalSets.get(varName).push(idl);
    });

    // Regex: (table.set $wat4wasm (i32.const 123) (local.get $ismi_bul))
    const tableSetRegex = /\(table\.set\s+\$wat4wasm\s+\(i32\.const\s+(\d+)\)\s+\(local\.get\s+([\$\w\.\/\:\-]+(?<!>))\)\)/g;
    Array.from(oldFuncBody.matchAll(tableSetRegex)).map(tsMatch => {
        const idx = tsMatch[1];
        const varName = tsMatch[2];
        if (!tableSets.has(varName)) tableSets.set(varName, []);
        tableSets.get(varName).push(idx);
    })

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
        let blockEnd = oldFuncBody.indexOf(")", blockStart) + 1;
        let rawBlock = oldFuncBody.substring(blockStart, blockEnd);

        while (rawBlock.split("(").length !== rawBlock.split(")").length) {
            blockEnd = oldFuncBody.indexOf(")", blockEnd) + 1;
            rawBlock = oldFuncBody.substring(blockStart, blockEnd);
        }

        pointer = blockEnd;


        // İsim Analizi
        const nameMatch = rawBlock.match(/^\(block\s+([\$\w\.\/\:\-<>\d]+)/);
        if (nameMatch) {
            const blockName = nameMatch[1];
            if (blockName.startsWith("$text")) {
                // Text Bloğu: Olduğu gibi sakla (Table set varsa içine gömülebilir ama şimdilik raw alıyoruz)
                // Eğer text bloklarının içinde local.set yoksa table logic çalışmaz, sorun yok.
                textBlocks.push(rawBlock);
            } else
                if (blockName.startsWith("$self")) {
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
    const calculateLevel = (name) => name.replace("self.", "").split(/\.|\/|\[|\]/).filter(Boolean).length;
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

        groupBlocks.filter((b, i, t) => {
            return t.findLastIndex(d => d.name === b.name) === i;
        }).forEach((block, i, t) => {

            let newContent = block.content;
            const oldName = block.name;

            const level = calculateLevel(oldName);
            if (level > maxLevelUsed) maxLevelUsed = level;

            const currentVar = `$level/${level}`;
            const parentVar = `$level/${level - 1}`;

            // Register Değişimi
            newContent = newContent.replace(`local.set ${oldName}`, `local.set ${currentVar}`);
            newContent = newContent.replaceAll(`(global.get $self)`, `(local.get $level/0)`);

            const parentName = getParentName(oldName);


            if (parentName !== "$self") {
                newContent = newContent.replace(`local.get ${parentName}`, `local.get ${parentVar}`);
            }

            if (tableSets.has(oldName)) {
                const t_indices = tableSets.get(oldName) || [];
                const t_setters = t_indices.map(idx => {
                    newContent = newContent.replace(`(table.set $wat4wasm (i32.const ${idx}) (local.get ${oldName}))`, ``)
                    return `(table.set $wat4wasm (i32.const ${idx}) (local.get ${currentVar}))`;
                }).join("\n");

                const lastParen = newContent.lastIndexOf(")");
                newContent = newContent.substring(0, lastParen) + "\n" + t_setters + "\n)";
            }

            if (globalSets.has(oldName)) {
                globalSets.get(oldName).map(idx => {
                    newContent = newContent.replace(
                        `(local.get ${idx})`,
                        `(local.get ${currentVar})`
                    )
                });
            }


            groupLines.push(`      ${newContent}`);
        });

        groupLines.push(`)`);
        optimizedSelfCode.push(groupLines.filter(Boolean).join("\n\n"));
    });

    // 5. Yeni Fonksiyon Gövdesini İnşa Et

    // A. Değişken Tanımları
    let localsDef = extraLocals; // Dışarıdan gelen ($TextDecoder vs.)
    for (let i = 0; i <= maxLevelUsed; i++) {
        localsDef += `
        (local $level/${i}      externref)`;
    }

    // B. Start Çağrısını Koru (Eğer varsa)
    const starterMatch = sourceCode.match(/\(start\s+(\$[\w\.]*)\)/);
    let starterCode = "(nop)";
    if (starterMatch) {
        starterCode = `(call ${starterMatch[1]})`;

    }

    // C. Ana Gövde Birleşimi
    const newFuncBody = `
    (func   $wat4wasm ;; @tokbuga 💚 
        ${localsDef}

        ${prepareCode}

        (block $text
            (local.set $arguments (call $self.Array.of<ext>ext (local.get $buffer)))
        ${textBlocks.join("\n").trim()}
        )

        (block $self
            ${optimizedSelfCode.join("\n").trim()}
        )

        ${starterCode})`.trim();

    sourceCode = sourceCode.replace(oldFuncBody, newFuncBody);

    if (starterMatch) {
        sourceCode = sourceCode.replace(starterMatch[0], "");
    }

    return sourceCode;
}