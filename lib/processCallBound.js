// lib/processCallBound.js

const BOUND_IMPORTS = new Map();
const BOUND_INIT_CODES = []; // Start bloğuna eklenecek kodlar

let TableManager, InjectManager, ScopeManager;

export function setManagers(tableManager, injectManager, scopeManager) {
    TableManager = tableManager;
    InjectManager = injectManager;
    ScopeManager = scopeManager;
}

/**
 * (call_bound ...) yapısını işler.
 */
export function processCallBound(source, extractRefExtern) {
    let result = source;
    let cursorIndex = result.length;

    while (true) {
        const startIndex = result.lastIndexOf("(call_bound", cursorIndex);
        if (startIndex === -1) break;

        const { block, endPointer } = extractBalancedBlock(result, startIndex);
        const innerContent = block.slice(11, -1).trim();
        const expressions = parseSExpressions(innerContent);

        const rawFuncName = expressions[0];

        // --- ANALİZ ---
        let paramTypes = [];
        let resultType = "";
        let argStartIndex = 1;

        while (argStartIndex < expressions.length) {
            const expr = expressions[argStartIndex];
            if (expr.startsWith("(param")) {
                paramTypes = paramTypes.concat(expr.slice(7, -1).trim().split(/\s+/));
                argStartIndex++;
            } else if (expr.startsWith("(result")) {
                resultType = expr.slice(8, -1).trim().split(/\s+/)[0];
                argStartIndex++;
            } else {
                break;
            }
        }

        // --- İŞLEMLER ---
        const currentTableIndex = TableManager.reserveIndex();
        const initCode = generateInitCode(rawFuncName, currentTableIndex, extractRefExtern);
        BOUND_INIT_CODES.push(initCode);

        const reflectFuncName = generateBoundImport(paramTypes, resultType);

        const args = expressions.slice(argStartIndex).join("\n");
        const argsStr = args.length > 0 ? "\n" + args + "\n" : "";

        // DÜZELTME BURADA AŞKIM: (table.get (i32.const ID))
        const newCall = `(call ${reflectFuncName} 
            ${TableManager.generateGetter(currentTableIndex)} 
            (global.get $self) 
            (global.get $self) 
            ${argsStr}
            )`;

        const before = result.substring(0, startIndex);
        const after = result.substring(startIndex + block.length);
        result = before + newCall + after;

        cursorIndex = startIndex - 1;
    }

    return result;
}

/**
 * Start Bloğu için Init Kodu Üretir
 * Örn: table.set(100, bindMethod(performance, "now"))
 */
function generateInitCode(rawName, tableIndex, extractRefExtern) {
    if (rawName.startsWith("$") === true) {
        rawName = rawName.substring(1);
    }

    if (rawName.startsWith("self.") === false) {
        rawName = `self.${rawName}`
    }

    const parts = rawName.split(".");

    // Parent ve Key ayrımı
    // $self.performance.now -> Parent: self.performance, Key: "now"
    const key = parts.pop();
    let parentPath = parts.join(".");

    // Parent'ı bulmak için basit bir yol lazım. 
    // Şimdilik varsayım: Parent global scope'tan erişilebilir.
    // Init kodunu basit tutmak için "wat4wasm/bindMethod" helper'ını kullanacağız.
    // Bu helper JS tarafında: (path, key) => get(path)[key].bind(get(path)) yapar.

    // "self.performance" stringini JS'e gönderip orada çözmek en kolayı.
    return extractRefExtern(
        TableManager.generateSetter(
            tableIndex,
            `
            (block (result externref)
                (call $self.Reflect.set<ref.i32.ref> 
                    (local.get $_this_argument_) 
                    (i32.const 0)
                    (ref.extern $${parentPath})
                )
                
                (call $self.Reflect.apply<ref.ref.ref>ref 
                    (local.get $_bind_function_) 
                    (ref.extern $${rawName})
                    (local.get $_this_argument_)
                )
            )
            `,
            true
        ),
        TableManager
    );
}

/**
 * Import Üretici (Reflect.apply)
 */
function generateBoundImport(paramTypes, resultType) {
    const mapType = (t) => t.replace(/externref/, "ref").replace(/funcref/, "fun");
    const paramSuffix = paramTypes.map(mapType).join('.');
    const resultSuffix = resultType ? mapType(resultType) : 'externref';

    // İsimde VOID YOK! 
    let funcName = `$self.Reflect.apply<${paramSuffix}>`;
    if (resultSuffix) funcName += resultSuffix;

    if (!BOUND_IMPORTS.has(funcName)) {
        // İmza: (param externref externref externref ...UserParams)
        // 3 Zorunlu parametre: Target, This, ArgsList
        const userParams = paramTypes.length > 0 ? " " + paramTypes.join(' ') : "externref externref externref";
        const resultStr = resultType ? `(result ${resultType})` : "";

        const importDef = `(import "Reflect" "apply" (func ${funcName} (param ${userParams}) ${resultStr}))`;
        BOUND_IMPORTS.set(funcName, importDef);
    }
    return funcName;
}

/**
 * Start bloğuna eklenecek kodları döndürür
 */
export function generateBoundInitCodes() {

    InjectManager.addLocal("$_this_argument_", "externref");
    InjectManager.addLocal("$_bind_function_", "externref");

    InjectManager.addInstruction(`(local.set $_this_argument_ (call $self.Array<>ref))`)
    InjectManager.addInstruction(`
    (local.set $_bind_function_
        (call $self.Reflect.get<ref.ref>ref
            (global.get $String.fromCharCode)
            (text "bind")
        )
    )    
    `);

    BOUND_INIT_CODES.forEach(init =>
        InjectManager.addInstruction(init)
    );
}

/**
 * Özel Bind Helper Importunu döndürür
 */
export function generateBoundImports() {
    let imports = Array.from(BOUND_IMPORTS.values()).join("\n");
    // Helper fonksiyon importunu ekle
    imports += `
    (import "Reflect" "get" (func $self.Reflect.get<ref.ref>ref (param externref externref) (result externref)))
    (import "Reflect" "set" (func $self.Reflect.set<ref.i32.ref> (param externref i32 externref) (result)))
    `;
    return imports;
}

export function resetCallBound() {
    BOUND_IMPORTS.clear();
    BOUND_INIT_CODES.length = 0;
    // tableIndexCounter resetlemiyoruz, global yönetilmeli ama şimdilik kalsın
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
    // ... (Call Direct'teki güncel parser ile aynı) ...
    // Hız için buraya kopyalamadım ama aynısı kullanılmalı
    const expressions = [];
    let depth = 0;
    let currentExpr = "";
    const cleanContent = content.trim();
    for (let i = 0; i < cleanContent.length; i++) {
        const char = cleanContent[i];
        if (depth === 0 && /\s/.test(char)) {
            if (currentExpr) { expressions.push(currentExpr); currentExpr = ""; }
            continue;
        }
        if (char === '(') depth++;
        currentExpr += char;
        if (char === ')') { depth--; if (depth === 0) { expressions.push(currentExpr); currentExpr = ""; } }
    }
    if (currentExpr.trim()) expressions.push(currentExpr.trim());
    return expressions;
}