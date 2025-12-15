// lib/processCustomTypes.js

const TYPE_DEFINITIONS = new Map();

let TableManager, InjectManager, ScopeManager;

export function setManagers(tableManager, injectManager, scopeManager) {
    TableManager = tableManager;
    InjectManager = injectManager;
    ScopeManager = scopeManager;
}

export function processCustomTypes(watSource) {
    // Regex Açıklaması:
    // \(type\s+(\$[\w\d_.\-]+)\s+ -> (type $isim ...
    // (                           -> GRUP 2 (İçerik)
    //   (?:                       -> Non-capturing group (tekrar için)
    //     \((?:param|result)      -> (param veya (result ile başla
    //     \s+[^)]+                -> içerik
    //     \)                      -> parantezi kapat
    //     \s* -> boşlukları yut
    //   )+                        -> En az bir kere veya daha fazla tekrar et
    // )
    // \)                          -> type bloğunu kapat

    const definitionRegex = /\(type\s+(\$[\w\d_.\-]+)\s+((?:\((?:param|result)\s+[^)]+\)\s*)+)\)/g;

    let cleanSource = watSource;
    let match;

    // 1. Tanımları Bul
    while ((match = definitionRegex.exec(watSource)) !== null) {
        const typeName = match[1];
        const contentBlock = match[2].trim(); // (param ...) (result ...) bloklarının tamamı

        TYPE_DEFINITIONS.set(typeName, contentBlock);
    }

    // 2. Tanımları Sil
    cleanSource = cleanSource.replaceAll(definitionRegex, "");

    // 3. Kullanımları Değiştir
    TYPE_DEFINITIONS.forEach((contentBlock, typeName) => {
        // (type $isim) -> (param ...) (result ...)
        const usageKey = `(type ${typeName})`;
        cleanSource = cleanSource.replaceAll(usageKey, contentBlock);
    });

    return cleanSource;
}

export function resetCustomTypes() {
    TYPE_DEFINITIONS.clear();
}