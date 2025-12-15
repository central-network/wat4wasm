// lib/processNew.js

const NEW_IMPORTS = new Map();
let TableManager, InjectManager, ScopeManager;

export function setManagers(tableManager, injectManager, scopeManager) {
    TableManager = tableManager;
    InjectManager = injectManager;
    ScopeManager = scopeManager;
}

/**
 * (new ...) yapısını işler.
 * Format: (new (Signature?) (Target) (ArgsArray))
 * Örn: (new (param externref externref) (result externref) ... )
 * Dönüşüm: (call $self.Reflect.construct<ref.ref>ref (Target) (ArgsArray))
 */
export function processNew(source) {
    let result = "";
    let i = 0;

    while (i < source.length) {
        if (source.substring(i).match(/^\(new[\s(]/)) {
            const { block, endPointer } = extractBalancedBlock(source, i);
            const innerContent = block.slice(5, -1).trim(); // "(new " atılır
            const expressions = parseSExpressions(innerContent);

            // 1. Signature Analizi
            let startIndex = 0;
            const signatureRegex = /^\((type|param|result)\b/;

            // Varsayılan Tipler: Target(ref), Args(ref) -> Result(ref)
            let paramTypes = ["externref", "externref"];
            let resultType = "externref"; // Constructor her zaman instance döner

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

            // Reflect.construct en az 2 argüman ister (Target, ArgsList)
            if ((expressions.length - startIndex) < 2) {
                console.warn(`⚠️ Uyarı: (new ...) bloğu eksik argüman içeriyor.`);
                result += block;
            } else {
                // Argümanları topla
                const args = expressions.slice(startIndex).join("\n");

                // Import üret
                const funcName = generateNewImport(paramTypes, resultType);

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
 * Örn: Params: [externref, externref], Result: externref
 * Çıktı: $self.Reflect.construct<ref.ref>ref
 */
function generateNewImport(paramTypes, resultType) {
    const mapType = (t) => {
        if (t === 'externref') return 'ref';
        if (t === 'funcref') return 'fun';
        return t;
    };

    const paramSuffix = paramTypes.map(mapType).join('.');
    const resultSuffix = resultType ? mapType(resultType) : 'ref';

    let funcName = `$self.Reflect.construct<${paramSuffix}>${resultSuffix}`;

    if (!NEW_IMPORTS.has(funcName)) {
        const paramsStr = paramTypes.join(' ');
        const resultStr = resultType ? `(result ${resultType})` : "";

        const importDef = `(import "Reflect" "construct" (func ${funcName} (param ${paramsStr}) ${resultStr}))`;
        NEW_IMPORTS.set(funcName, importDef);
    }

    return funcName;
}

export function generateNewImports() {
    return Array.from(NEW_IMPORTS.values()).join("\n");
}

export function resetNewImports() {
    NEW_IMPORTS.clear();
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