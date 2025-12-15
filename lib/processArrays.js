// lib/processArrays.js

// Üretilen importları saklamak için (Deduplication)
const ARRAY_IMPORTS = new Map();
let TableManager, InjectManager, ScopeManager;

export function setManagers(tableManager, injectManager, scopeManager) {
    TableManager = tableManager;
    InjectManager = injectManager;
    ScopeManager = scopeManager;
}

/**
 * (array (param i32 f32) ...) yapılarını (call ...) yapısına dönüştürür.
 */
export function processArrays(watSource) {
    // Regex: (array (param ...) ARGS...)
    // Grup 1: Parametrelerin iç kısmı (i32 f32 externref gibi)
    // Grup 2: Argümanların geri kalanı (değerler)
    // Not: Bu regex basit yapılar içindir. İç içe karmaşık parantezlerde dikkatli olunmalı.
    // Ancak pipeline'da en son çalıştığı için stringler ve tipler temizlenmiş olacak.
    const arrayRegex = /\(array\s+\(param\s+([^)]+)\)\s+((?:.|\n)*?)\)/g;

    return watSource.replace(arrayRegex, (match, paramTypesStr, argsContent) => {
        // 1. Parametre tiplerini diziye çevir: ["i32", "f32", "externref"]
        const types = paramTypesStr.trim().split(/\s+/);

        // 2. Fonksiyon Soneki Oluştur (Naming Convention)
        // i32 -> i32, externref -> ref, funcref -> funcref, f32 -> f32
        const suffixParts = types.map(t => {
            if (t === 'externref') return 'ref';
            return t;
        });
        const suffix = suffixParts.join('.'); // i32.f32.ref

        // 3. Fonksiyon İsmi: $wat4wasm/Array.of<i32.f32.ref>ref
        const funcName = `$self.Array.of<${suffix}>ref`;

        // 4. Import Tanımını Oluştur (Eğer yoksa)
        if (!ARRAY_IMPORTS.has(funcName)) {
            // (import "Array" "of" (func ... (param i32 f32 externref) (result externref)))
            const importDef = `(import "Array" "of" (func ${funcName} (param ${paramTypesStr}) (result externref)))`;
            ARRAY_IMPORTS.set(funcName, importDef);
        }

        // 5. Çağrı Kodunu Döndür
        // (array ...) yerine (call $func ...) koyuyoruz.
        // argsContent, parametre değerlerini (i32.const 1) (local.get $x) içerir.
        return `(call ${funcName} 
            ${argsContent})`;
    });
}

/**
 * Module Importlarını Döndür
 */
export function generateArrayImports() {
    return Array.from(ARRAY_IMPORTS.values()).join("\n");
}

export function resetArrayImports() {
    ARRAY_IMPORTS.clear();
}