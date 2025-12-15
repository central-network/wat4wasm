// lib/validateImports.js

/**
 * Kodun son halini tarar, importları analiz eder, doğrular ve tekilleştirir.
 * @param {string} source - Tüm WAT kodu
 * @returns {object} { cleanSource, validatedImportBlock }
 */
export function validateImports(source) {
    console.log("👮 Import Validasyonu ve Temizliği Başlıyor...");

    const UNIQUE_IMPORTS = new Map(); // Key: $funcName, Value: Full Import String
    let cleanSource = source;

    // 1. Tüm (import ...) bloklarını bul ve koddan çıkar
    // Not: Sondan başa doğru gitmek, string indekslerini kaydırmamak için daha güvenlidir.
    let cursor = cleanSource.length;

    while (true) {
        const startIndex = cleanSource.lastIndexOf("(import", cursor);
        if (startIndex === -1) break;

        const { block, endPointer } = extractBalancedBlock(cleanSource, startIndex);

        // Bloğu analiz et
        processImportBlock(block, UNIQUE_IMPORTS);

        // Bloğu koddan sil (Daha sonra toplu halde en başa ekleyeceğiz)
        const before = cleanSource.substring(0, startIndex);
        const after = cleanSource.substring(endPointer);
        cleanSource = before + after; // Import'u sildik, yerine boşluk kaldı

        cursor = startIndex - 1;
    }

    // 2. Importları Birleştir
    const validatedImportBlock = Array.from(UNIQUE_IMPORTS.values()).sort().join("\n");

    return cleanSource.replace("(module", `(module
        (import "self" "self" (global $self externref))
        ${validatedImportBlock}    
        (import "String" "fromCharcode" (global $self.String.fromCharCode externref))
    `);
}

/**
 * Tek bir import bloğunu işler, doğrular ve Map'e ekler.
 */
function processImportBlock(importBlock, map) {
    // Örnek: (import "Math" "random" (func $Math.random<i32> (param i32) (result f32)))

    // 1. Fonksiyon İmzasını ve İsmini Çıkar
    // (func $name (param ...) (result ...)) kısmını bulmamız lazım.
    const funcMatch = importBlock.match(/\(func\s+(\$[\w\d_.\-<>]+)(.*)\)/s);

    if (!funcMatch) {
        // Fonksiyon olmayan importlar (global, memory vs.) olduğu gibi saklanır.
        // Ancak biz şimdilik sadece fonksiyonlara odaklanıyoruz.
        // Eğer isim yoksa (anonim import) bu validasyon çalışmaz, ama bizim sistemde hepsi isimlidir.
        return;
    }

    const currentName = funcMatch[1]; // $Math.random<i32>
    const signatureContent = funcMatch[2]; // (param i32) (result f32)

    // 2. Parametre ve Result Tiplerini Analiz Et
    const expressions = parseSExpressions(signatureContent);
    let paramTypes = [];
    let resultType = "";

    expressions.forEach(expr => {
        if (expr.startsWith("(param")) {
            const types = expr.slice(7, -1).trim().split(/\s+/);
            paramTypes = paramTypes.concat(types);
        } else if (expr.startsWith("(result")) {
            const types = expr.slice(8, -1).trim().split(/\s+/);
            if (types.length > 0) resultType = types[0];
        }
    });

    // 3. Beklenen Soneki (Suffix) Oluştur
    const mapType = (t) => {
        if (t === 'externref') return 'ref';
        if (t === 'funcref') return 'fun';
        return t;
    };

    const paramSuffix = paramTypes.map(mapType).join('.');
    const resultSuffix = resultType ? mapType(resultType) : '';

    const expectedSuffix = `<${paramSuffix}>${resultSuffix}`;

    // 4. Doğrulama (Validation)
    // İsim, beklenen sonek ile bitiyor mu?
    if (!currentName.endsWith(expectedSuffix)) {
        console.warn(`⚠️ UYARI: Import ismi imza ile uyuşmuyor!`);
        console.warn(`   Fonksiyon: ${currentName}`);
        console.warn(`   İmza     : (param ${paramTypes}) (result ${resultType})`);
        console.warn(`   Beklenen : ...${expectedSuffix}`);
        // Burada hata fırlatabiliriz veya sadece uyarabiliriz.
        // Otomatik düzeltme yaparsak, kod içindeki (call $eskiIsim) yerleri patlar.
        // O yüzden sadece uyarıyoruz, çünkü önceki makrolarımız doğru üretmeliydi.
    }

    // 5. Tekilleştirme (Deduplication)
    // Eğer aynı isimde bir fonksiyon zaten varsa, üzerine yaz (veya atla, aynısıdır).
    if (!map.has(currentName)) {
        map.set(currentName, importBlock);
    }
}


// --- YARDIMCILAR (Diğer dosyalardan import edilebilir veya buraya kopyalanabilir) ---
function extractBalancedBlock(source, startIndex) {
    let depth = 0;
    let endIndex = startIndex;
    let started = false;
    for (let i = startIndex; i < source.length; i++) {
        const char = source[i];
        if (char === '(') { depth++; started = true; }
        else if (char === ')') { depth--; }
        if (started && depth === 0) { endIndex = i + 1; break; }
    }
    return { block: source.substring(startIndex, endIndex), endPointer: endIndex };
}

function parseSExpressions(content) {
    const expressions = [];
    let depth = 0;
    let currentExpr = "";
    let inExpr = false;
    const clean = content.trim();
    for (let i = 0; i < clean.length; i++) {
        const char = clean[i];
        if (depth === 0 && /\s/.test(char)) continue;
        if (char === '(') { depth++; if (depth === 1) inExpr = true; }
        if (inExpr) currentExpr += char;
        if (char === ')') { depth--; if (depth === 0) { expressions.push(currentExpr); currentExpr = ""; inExpr = false; } }
    }
    return expressions;
}