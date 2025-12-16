// lib/processRefFunc.js
let TableManager, InjectManager, ScopeManager;

export function setManagers(tableManager, injectManager, scopeManager) {
    TableManager = tableManager;
    InjectManager = injectManager;
    ScopeManager = scopeManager;
}

/**
 * (ref.func ...) kullanımlarını tarar ve eksik olanları (elem) bloğuna ekler.
 * Dönüş: { source: string, elemBlock: string }
 */
export function processRefFunc(source) {
    // 1. Kullanılan tüm referansları topla
    // Regex: (ref.func $funcName)
    const refFuncRegex = /\(ref\.func\s+(\$[\w\d_.\-]+)\)/g;
    const referencedFuncs = new Set();
    let match;

    while ((match = refFuncRegex.exec(source)) !== null) {
        referencedFuncs.add(match[1]);
    }

    // Eğer hiç ref.func yoksa erken çık
    if (referencedFuncs.size === 0) {
        return { source, elemBlock: "" };
    }

    // 2. Mevcut (elem ...) bloklarını tara ve içindekileri kaydet
    const declaredFuncs = new Set();
    let cursor = 0;

    while (true) {
        const startIndex = source.indexOf("(elem", cursor);
        if (startIndex === -1) break;

        const { block, endPointer } = extractBalancedBlock(source, startIndex);

        // Bloğun içindeki tüm $isim formatındaki kelimeleri bul
        // Örn: (elem (i32.const 0) $func1 $func2) -> $func1, $func2
        const funcMatches = block.match(/(\$[\w\d_.\-]+)/g);
        if (funcMatches) {
            funcMatches.forEach(f => declaredFuncs.add(f));
        }

        cursor = endPointer;
    }

    // 3. Eksikleri Belirle (Referenced - Declared)
    const missingFuncs = [...referencedFuncs].filter(f => !declaredFuncs.has(f));

    if (missingFuncs.length === 0) {
        return { source, elemBlock: "" };
    }

    // 4. Otomatik Elem Bloğu Oluştur
    // "declare func" kullanarak tabloyu başlatmadan sadece referans alınabilir yaparız.
    // Bu sayede Table boyutunu veya offsetleri bozmayız.
    console.log(`🛡️ Otomatik Element Bloğu oluşturuluyor: ${missingFuncs.length} fonksiyon eklendi.`);

    const elemBlock = `
    (elem $wat4wasm declare func ${missingFuncs.join(" ")})`;

    ScopeManager.add(elemBlock);

    return source;
}

// --- YARDIMCI ---
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