// lib/processGet.js

// Üretilen importları saklamak için
const GET_IMPORTS = new Map();

/**
 * (get ...) yapısını işler.
 * Format: (get (Signature?) (Target) (Key))
 * Örn: (get (param externref i32) (result externref) ... )
 * Dönüşüm: (call $self.Reflect.get<ref.i32>ref (Target) (Key))
 */
export function processGet(source) {
    let result = "";
    let i = 0;

    while (i < source.length) {
        if (source.substring(i).match(/^\(get[\s(]/)) {
            const { block, endPointer } = extractBalancedBlock(source, i);
            const innerContent = block.slice(5, -1).trim(); // "(get " (5 harf) atılır
            const expressions = parseSExpressions(innerContent);

            // 1. Signature Analizi
            let startIndex = 0;
            const signatureRegex = /^\((type|param|result)\b/;

            // Varsayılan Tipler (Reflect.get genelde obje ve string key alır)
            let paramTypes = ["externref", "externref"];
            let resultType = "externref"; // Varsayılan dönüş

            while (startIndex < expressions.length && signatureRegex.test(expressions[startIndex])) {
                const expr = expressions[startIndex];

                if (expr.startsWith("(param")) {
                    const content = expr.slice(7, -1).trim();
                    if (content.length > 0) paramTypes = content.split(/\s+/);
                }

                if (expr.startsWith("(result")) {
                    const content = expr.slice(8, -1).trim();
                    if (content.length > 0) resultType = content.split(/\s+/)[0];
                }

                startIndex++;
            }

            // Reflect.get en az 2 argüman ister (Target, Key)
            if ((expressions.length - startIndex) < 2) {
                console.warn(`⚠️ Uyarı: (get ...) bloğu eksik argüman içeriyor.`);
                result += block;
            } else {
                // Argümanları topla (Target, Key, ve varsa Receiver)
                // Slice ile kalan tüm ifadeleri alıyoruz
                const args = expressions.slice(startIndex).join("\n");

                // Import üret
                const funcName = generateGetImport(paramTypes, resultType);

                // Çağrıyı oluştur
                const newCall = `(call ${funcName} 
                ${args}
                )`;
                result += newCall;
            }

            i = endPointer;
        } else {
            result += source[i];
            i++;
        }
    }

    return result;
}

/**
 * Helper: Import Üretici
 * Örn: Params: [externref, i32], Result: externref
 * Çıktı: $self.Reflect.get<ref.i32>ref
 */
function generateGetImport(paramTypes, resultType) {
    const mapType = (t) => {
        if (t === 'externref') return 'ref';
        if (t === 'funcref') return 'fun';
        return t;
    };

    const paramSuffix = paramTypes.map(mapType).join('.');
    const resultSuffix = resultType ? mapType(resultType) : '';

    let funcName = `$self.Reflect.get<${paramSuffix}>`;
    if (resultSuffix) {
        funcName += resultSuffix;
    }

    if (!GET_IMPORTS.has(funcName)) {
        const paramsStr = paramTypes.join(' ');
        const resultStr = resultType ? `(result ${resultType})` : "";

        const importDef = `(import "Reflect" "get" (func ${funcName} (param ${paramsStr}) ${resultStr}))`;
        GET_IMPORTS.set(funcName, importDef);
    }

    return funcName;
}

export function generateGetImports() {
    return Array.from(GET_IMPORTS.values()).join("\n");
}

export function resetGetImports() {
    GET_IMPORTS.clear();
}

// --- ORTAK YARDIMCILAR (Apply modülünden kopyalanabilir veya utils'e taşınabilir) ---
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
    for (let i = 0; i < content.length; i++) {
        const char = content[i];
        if (!inExpr && /\s/.test(char)) continue;
        if (char === '(') { if (depth === 0) inExpr = true; depth++; }
        if (inExpr) { currentExpr += char; }
        if (char === ')') { depth--; if (depth === 0) { expressions.push(currentExpr); currentExpr = ""; inExpr = false; } }
    }
    return expressions;
}