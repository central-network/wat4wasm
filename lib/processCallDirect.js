// lib/processCallDirect.js

const DIRECT_IMPORTS = new Map();
let TableManager, InjectManager, ScopeManager;

export function setManagers(tableManager, injectManager, scopeManager) {
    TableManager = tableManager;
    InjectManager = injectManager;
    ScopeManager = scopeManager;
}

/**
 * (call_direct ...) yapısını işler.
 * * STRATEJİ: Sondan başa doğru (Reverse) çalışır (Nested support).
 * * KURAL: İlk argüman MUTLAKA fonksiyon ismi olmalıdır.
 * Örn: (call_direct $Math.random (result f32))
 */
export function processCallDirect(source) {
    let result = source;
    // İmleci dosyanın sonuna koyuyoruz
    let cursorIndex = result.length;

    while (true) {
        // Sondan geriye doğru (call_direct ara
        const startIndex = result.lastIndexOf("(call_direct", cursorIndex);

        // Bulamazsak bitti
        if (startIndex === -1) break;

        // Bloğu çıkar
        const { block, endPointer } = extractBalancedBlock(result, startIndex);

        // İçeriği al: "(call_direct " (12 harf) atılır
        const innerContent = block.slice(12, -1).trim();

        // Parçalarına ayır
        const expressions = parseSExpressions(innerContent);

        if (expressions.length === 0) {
            // Boş blok hatası, geçiyoruz
            cursorIndex = startIndex - 1;
            continue;
        }

        // --- KURAL 1: İLK ELEMAN İSİMDİR ---
        const rawFuncName = expressions[0];

        // Basit bir doğrulama: İsim $ ile başlamalı veya harf içermeli, 
        // ama (param) veya (result) olmamalı.
        if (rawFuncName.startsWith("(") || rawFuncName.startsWith("(param") || rawFuncName.startsWith("(result")) {
            console.warn(`⚠️ UYARI: (call_direct) bloğunda ilk eleman fonksiyon ismi olmalı! Bulunan: ${rawFuncName}`);
            // Yine de devam edip patlamasını önleyelim, cursor'ı kaydır
            cursorIndex = startIndex - 1;
            continue;
        }

        // --- ANALİZ ---
        let paramTypes = [];
        let resultType = "";

        // 1. indexten itibaren tara (0. index isimdi)
        let argStartIndex = 1;

        // Param ve Result bloklarını süpür
        while (argStartIndex < expressions.length) {
            const expr = expressions[argStartIndex];

            if (expr.startsWith("(param")) {
                const content = expr.slice(7, -1).trim();
                if (content.length > 0) paramTypes = paramTypes.concat(content.split(/\s+/));
                argStartIndex++;
            } else if (expr.startsWith("(result")) {
                const content = expr.slice(8, -1).trim();
                if (content.length > 0) resultType = content.split(/\s+/)[0];
                argStartIndex++;
            } else {
                // Param veya Result değilse, argümanlar başlamış demektir.
                break;
            }
        }

        // --- DÖNÜŞTÜRME ---
        const { internalName } = generateDirectImport(rawFuncName, paramTypes, resultType);

        // Geriye kalanlar argümandır (local.get, i32.const, veya daha önce dönüşmüş call komutları)
        const args = expressions.slice(argStartIndex).join("\n");
        const argsStr = args.length > 0 ? "\n" + args + "\n" : "";

        // Yeni çağrı: (call $internalName ...)
        const newCall = `(call ${internalName}${argsStr})`;

        // Metni değiştir (Replace)
        const before = result.substring(0, startIndex);
        const after = result.substring(startIndex + block.length);

        result = before + newCall + after;

        // Cursor'ı güncelle: İşlem yaptığımız yerin başına çek
        cursorIndex = startIndex - 1;
    }

    return result;
}

/**
 * Helper: Import Üretici
 */
function generateDirectImport(rawName, paramTypes, resultType) {
    const cleanName = rawName.replace(/^\$/, "");
    const parts = cleanName.split(".");

    if (parts.length < 2) {
        // Tek kelime gelirse başına self ekleyip kurtaralım
        if (!rawName.includes(".")) {
            return generateDirectImport("self." + cleanName, paramTypes, resultType);
        }
        // Hala hatalıysa
        throw new Error(`(call_direct) İsim Hatası: En az 'Modül.Fonksiyon' formatı bekleniyor. Gelen: ${rawName}`);
    }

    const importName = parts[parts.length - 1];
    const importModule = parts[parts.length - 2];

    const mapType = (t) => t.replace(/externref/, "ref").replace(/funcref/, "fun");
    const paramSuffix = paramTypes.map(mapType).join('.');
    const resultSuffix = resultType ? mapType(resultType) : '';

    // Hizalama için self kontrolü
    let baseName = parts.join('.');
    if (!baseName.startsWith("self.") && parts[0] !== "self") {
        baseName = "self." + baseName;
    }

    let internalName = `$${baseName}<${paramSuffix}>`;
    if (resultSuffix) {
        internalName += resultSuffix;
    }

    if (!DIRECT_IMPORTS.has(internalName)) {
        const paramsStr = paramTypes.join(' ');
        const resultStr = resultType ? `(result ${resultType})` : "";

        const importDef = `(import "${importModule}" "${importName}" (func ${internalName} (param ${paramsStr}) ${resultStr}))`;
        DIRECT_IMPORTS.set(internalName, importDef);
    }

    return { internalName };
}

export function generateDirectImports() {
    return Array.from(DIRECT_IMPORTS.values()).join("\n");
}

export function resetDirectImports() {
    DIRECT_IMPORTS.clear();
}

// --- PARSER YARDIMCILARI ---
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
    let inExpr = false; // Parantez bloğu içinde miyiz?

    // İçerik boşlukla başlayabilir, temizle
    const cleanContent = content.trim();

    for (let i = 0; i < cleanContent.length; i++) {
        const char = cleanContent[i];

        // Eğer parantez dışında bir boşluksa ve elimizde birikmiş bir ifade varsa
        if (depth === 0 && /\s/.test(char)) {
            if (currentExpr) {
                expressions.push(currentExpr);
                currentExpr = "";
            }
            continue;
        }

        if (char === '(') {
            depth++;
            if (depth === 1) inExpr = true;
        }

        currentExpr += char;

        if (char === ')') {
            depth--;
            if (depth === 0) {
                // Bloğu kapat ve ekle
                expressions.push(currentExpr);
                currentExpr = "";
                inExpr = false;
            }
        }
    }
    // Döngü bittiğinde tamponda kalan son parça (örn: parantezsiz bir değişken adı) varsa ekle
    if (currentExpr.trim()) {
        expressions.push(currentExpr.trim());
    }

    return expressions;
}