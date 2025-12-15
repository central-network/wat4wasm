import { validateImports } from "./validateImports.js";
// lib/injector.js
let TableManager, InjectManager, ScopeManager;

export function setManagers(tableManager, injectManager, scopeManager) {
    TableManager = tableManager;
    InjectManager = injectManager;
    ScopeManager = scopeManager;
}


/**
 * @param {string} bootstrapLocals - Start fonksiyonu içinde tanımlanacak değişkenler (local $x type)
 */
export function injectRuntimeLogic(source, dataBlock, initBlock, tableDef, extraImports, extraFuncs, bootstrapLocals = "") {
    let finalSource = source;
    let originalStartFunc = null;

    // 1. Orijinal Start'ı bul ve sil
    const startRegex = /\(start\s+([$a-zA-Z0-9_.\-]+)\)/;
    const match = finalSource.match(startRegex);
    if (match) {
        originalStartFunc = match[1];
        finalSource = finalSource.replace(match[0], "");
    }

    // 2. Bootstrap Fonksiyonunu Oluştur
    // Burada bootstrapLocals'ı (local ...) fonksiyonun en başına koyuyoruz.
    let bootstrapFunc = `;; --- Wat4Wasm Bootstrap Start ---
    (func $__wat4wasm_bootstrap
        ${bootstrapLocals} 
        ${initBlock}
    `;

    if (originalStartFunc) {
        bootstrapFunc += `(call ${originalStartFunc})\n`;
    }
    bootstrapFunc += `)
    
    (start $__wat4wasm_bootstrap)`;

    // 3. Modül İçine Yerleştir
    if (extraImports) {
        finalSource = finalSource.replace(/(\(module)/, `$1\n${extraImports}`);
    }

    const insertionBlock = `
    ;; --- Wat4Wasm Injected Blocks ---
    ${tableDef}
    ${dataBlock}
    ${extraFuncs || ""}
    ${bootstrapFunc}`;

    const lastParenIndex = finalSource.lastIndexOf(')');
    if (lastParenIndex === -1) throw new Error("Modül sonu bulunamadı!");

    return validateImports(`
    ${finalSource.slice(0, lastParenIndex).trimEnd()}
    ${insertionBlock}
    ${finalSource.slice(lastParenIndex)}
    `);
}