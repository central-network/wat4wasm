// lib/processApply.js

const APPLY_IMPORTS = new Map();
let TableManager, InjectManager, ScopeManager;

export function setManagers(tableManager, injectManager, scopeManager) {
    TableManager = tableManager;
    InjectManager = injectManager;
    ScopeManager = scopeManager;
}

export function processApply(source) {
    let result = "";
    let i = 0;

    while (i < source.length) {
        if (source.substring(i).match(/^\(apply[\s(]/)) {
            const { block, endPointer } = extractBalancedBlock(source, i);
            const innerContent = block.slice(6, -1).trim();
            const expressions = parseSExpressions(innerContent);

            let startIndex = 0;
            const signatureRegex = /^\((type|param|result)\b/;

            // Varsayılan Tipler
            let paramTypes = ["externref", "externref", "externref"];

            // DEĞİŞİKLİK 1: Varsayılan dönüş tipi artık BOŞ (Void)
            let resultType = "";

            // Signature tarama
            while (startIndex < expressions.length && signatureRegex.test(expressions[startIndex])) {
                const expr = expressions[startIndex];

                if (expr.startsWith("(param")) {
                    const content = expr.slice(7, -1).trim();
                    if (content.length > 0) paramTypes = content.split(/\s+/);
                }

                if (expr.startsWith("(result")) {
                    const content = expr.slice(8, -1).trim();
                    // result boş olabilir veya bir tip içerebilir
                    if (content.length > 0) resultType = content.split(/\s+/)[0];
                }

                startIndex++;
            }

            if ((expressions.length - startIndex) < 3) {
                console.warn(`⚠️ Uyarı: (apply ...) eksik argüman.`);
                result += block;
            } else {
                const target = expressions[startIndex];
                const thisArg = expressions[startIndex + 1];
                const args = expressions[startIndex + 2];

                // Import üret
                const funcName = generateApplyImport(paramTypes, resultType);

                const newCall = `(call ${funcName} 
                ${target} 
                ${thisArg} 
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

function generateApplyImport(paramTypes, resultType) {
    const mapType = (t) => {
        if (t === 'externref') return 'ref';
        if (t === 'funcref') return 'fun';
        return t;
    };

    const paramSuffix = paramTypes.map(mapType).join('.');

    // DÜZELTME: Artık 'void' yok. Varsa tipin kısaltması, yoksa boş string.
    const resultSuffix = resultType ? mapType(resultType) : '';

    // Fonksiyon İsmi Oluşturma
    // Eğer sonuç varsa: $self.Reflect.apply<ref.ref>f32
    // Eğer sonuç yoksa: $self.Reflect.apply<ref.ref>
    let funcName = `$self.Reflect.apply<${paramSuffix}>`;
    if (resultSuffix) {
        funcName += resultSuffix;
    }

    // Import Tanımı (Eğer yoksa ekle)
    if (!APPLY_IMPORTS.has(funcName)) {
        const paramsStr = paramTypes.join(' ');

        // Eğer resultType boşsa, (result ...) kısmını hiç yazma.
        const resultStr = resultType ? `(result ${resultType})` : "";

        const importDef = `(import "Reflect" "apply" (func ${funcName} (param ${paramsStr}) ${resultStr}))`;
        APPLY_IMPORTS.set(funcName, importDef);
    }

    return funcName;
}

export function generateApplyImports() {
    return Array.from(APPLY_IMPORTS.values()).join("\n");
}

export function resetApplyImports() {
    APPLY_IMPORTS.clear();
}

// ... extractBalancedBlock ve parseSExpressions AYNI ...
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