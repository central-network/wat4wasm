// lib/processSet.js

const SET_IMPORTS = new Map();

/**
 * (set ...) yapısını işler.
 * Format: (set (Signature?) (Target) (Key) (Value))
 * Örn: (set (param externref i32 i32) ... )
 * Dönüşüm: (call $self.Reflect.set<ref.i32.i32> (Target) (Key) (Value))
 */
export function processSet(source) {
    let result = "";
    let i = 0;

    while (i < source.length) {
        if (source.substring(i).match(/^\(set[\s(]/)) {
            const { block, endPointer } = extractBalancedBlock(source, i);
            const innerContent = block.slice(5, -1).trim(); // "(set " atılır
            const expressions = parseSExpressions(innerContent);

            // 1. Signature Analizi
            let startIndex = 0;
            const signatureRegex = /^\((type|param|result)\b/;

            // Varsayılan Tipler: Target(ref), Key(ref), Value(ref)
            let paramTypes = ["externref", "externref", "externref"];
            let resultType = ""; // Varsayılan VOID

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

            // Reflect.set en az 3 argüman ister (Target, Key, Value)
            if ((expressions.length - startIndex) < 3) {
                console.warn(`⚠️ Uyarı: (set ...) bloğu eksik argüman içeriyor.`);
                result += block;
            } else {
                // Argümanları topla
                const args = expressions.slice(startIndex).join("\n");

                // Import üret
                const funcName = generateSetImport(paramTypes, resultType);

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
 * Örn: Params: [externref, i32, i32], Result: Void
 * Çıktı: $self.Reflect.set<ref.i32.i32>
 */
function generateSetImport(paramTypes, resultType) {
    const mapType = (t) => {
        if (t === 'externref') return 'ref';
        if (t === 'funcref') return 'fun';
        return t;
    };

    const paramSuffix = paramTypes.map(mapType).join('.');
    const resultSuffix = resultType ? mapType(resultType) : '';

    let funcName = `$self.Reflect.set<${paramSuffix}>`;
    if (resultSuffix) {
        funcName += resultSuffix;
    }

    if (!SET_IMPORTS.has(funcName)) {
        const paramsStr = paramTypes.join(' ');
        const resultStr = resultType ? `(result ${resultType})` : "";

        const importDef = `(import "Reflect" "set" (func ${funcName} (param ${paramsStr}) ${resultStr}))`;
        SET_IMPORTS.set(funcName, importDef);
    }

    return funcName;
}

export function generateSetImports() {
    return Array.from(SET_IMPORTS.values()).join("\n");
}

export function resetSetImports() {
    SET_IMPORTS.clear();
}

// --- ORTAK YARDIMCILAR ---
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