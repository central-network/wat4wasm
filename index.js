import wat4beauty from "wat4beauty"
import fs, { watch } from "fs";

import { TableManager } from "./lib/TableManager.js";
import { InjectManager } from "./lib/InjectManager.js";
import { ScopeManager } from "./lib/ScopeManager.js";

import { setManagers as setManagers_resolveIncludes, resolveIncludes } from "./lib/resolveIncludes.js";
import { setManagers as setManagers_cleanComments, cleanComments } from "./lib/cleanComments.js";
import { setManagers as setManagers_standardLibrary, processSimpleMacros, getStandardImports } from "./lib/standardLibrary.js";
import { setManagers as setManagers_extractRefExtern, extractRefExtern, generateRefExternInfrastructure, resetRefExternPool } from "./lib/extractRefExtern.js";
import { setManagers as setManagers_extractTextBlocks, extractTextBlocks, generateTextSections, resetTextPool } from "./lib/extractTextBlocks.js";
import { setManagers as setManagers_extractStringBlocks, extractStringBlocks, generateStringInfrastructure, resetStringPool } from "./lib/extractStringBlocks.js";
import { setManagers as setManagers_injector, injectRuntimeLogic } from "./lib/injector.js";
import { setManagers as setManagers_processCustomTypes, processCustomTypes, resetCustomTypes } from "./lib/processCustomTypes.js";
import { setManagers as setManagers_processArrays, processArrays, generateArrayImports, resetArrayImports } from "./lib/processArrays.js";
import { setManagers as setManagers_processCallDirect, processCallDirect, generateDirectImports, resetDirectImports } from "./lib/processCallDirect.js";
import { setManagers as setManagers_processApply, processApply, generateApplyImports, resetApplyImports } from "./lib/processApply.js";
import { setManagers as setManagers_processGet, processGet, generateGetImports, resetGetImports } from "./lib/processGet.js";
import { setManagers as setManagers_processSet, processSet, generateSetImports, resetSetImports } from "./lib/processSet.js";
import { setManagers as setManagers_processNew, processNew, generateNewImports, resetNewImports } from "./lib/processNew.js";
import { setManagers as setManagers_processCallBound, processCallBound, generateBoundImports, generateBoundInitCodes, resetCallBound } from "./lib/processCallBound.js";
import { setManagers as setManagers_processRefFunc, processRefFunc } from "./lib/processRefFunc.js";

const ENTRY_FILE = "test.wat";
const OUTPUT_FILE = "output.wat";

const w4 = {
    include: function (match) {
        let path = match.valueOf();
        path = path.substring(path.startsWith("/"));
        return fs.readFileSync(path, "utf8");
    },

    longType: new Proxy({
        ext: "externref",
        fun: "funcref"
    }, { get: (t, p) => t[p] ?? p }),

    shortType: new Proxy({
        externref: "ext",
        funcref: "fun"
    }, { get: (t, p) => t[p] ?? p }),

    encodeText: TextEncoder.prototype.encode.bind(new TextEncoder),
    dataOffset: 0,
    externref: new Map,
    textExtern: new Array,

    NAME_REGEXP: /[a-zA-Z0-9\@\:\*\!\=\?\#\^\&\`<>\|\%\$\.\+-_\/\\]/,

    text: function (match) {
        let text = match.valueOf();

        if (false === this.externref.has(text)) {
            const view = this.encodeText(text);
            const offset = this.dataOffset;
            const index = TableManager.reserveIndex();

            this.externref.set(text, {
                view, offset, index
            });

            this.textExtern.push({ view, offset })
            this.dataOffset += view.length;
        }

        return TableManager.generateGetter(
            this.externref.get(text).index
        ).concat(` ;; "${text}"`);
    },

    call_direct: function (match) {
        const ref_func = w4.block(match.input, "self.fun ");
        const signature = {
            param: w4.block(match.input, "param") || { value: "", input: "(param)" },
            result: w4.block(match.input, "result") || { value: "", input: "(result)" },
        };

        let blockName = ref_func.blockName;

        let [funcName, rootName = "self"] = blockName.split(".").reverse();
        if (blockName.startsWith("self") === false) {
            blockName = `self.${blockName}`
        }

        const params = signature.param.value.split(" ").map(p => w4.shortType[p]).join(".");;
        const result = signature.result.value.split(" ").map(p => w4.shortType[p]).join(".");;

        const signedFuncName = `$${blockName}<${params}>${result}`;
        const callerArguments = match.value
            .replace(ref_func.input, "")
            .replace(signature.param.input, "")
            .replace(signature.result.input, "")
            .trim();

        console.log({ callerArguments })

        const caller = `
        (call ${signedFuncName} ${callerArguments})`.replaceAll(/\s+\)/g, ")");

        const needed = `
        (needed "${rootName}" "${funcName}"
            (func ${signedFuncName} 
                ${signature.param.input} 
                ${signature.result.input}
            )
        )`;

        return `
            ${caller}
            ${needed}
        `;
    },

    self: function (match) {
        const path = match.blockName;
        let realpath = path;

        if (realpath.includes(":") === true) realpath = realpath.replaceAll(":", ".prototype.");
        if (realpath.startsWith("self") === false) realpath = `self.${realpath}`;


        const isGetter = realpath.endsWith("/get");
        const isSetter = realpath.endsWith("/set");

        let descriptorKey = "value";

        if (isGetter || isSetter) {
            realpath = realpath.substring(0, realpath.length - 4);
            if (isGetter) descriptorKey = "get";
            if (isSetter) descriptorKey = "set";
        }

        const type = w4.longType[match.tagSubType];
        const parts = realpath.split(".");
        const [name, root = "self"] = parts.slice().reverse();

        if (type.match(/i32|f32|i64|f64/)) {
            if ((parts.length <= 3)) {
                return String(`
                    (global.get $${path})
                    
                    (needed "${root}" "${name}" 
                        (global $${path} ${type})
                    )
                `);
            }

            throw new Error(
                `\x1b[33m${match.input}\x1b[0m
                Deeper level then 3 numeric self values can NOT be imported and
                can NOT be stored in externref table neither.`
            )
        }

        if (isGetter || isSetter || !type.match(/(i32|f32|i64|f64)/) || (parts.length > 2)) {

            if (false === this.externref.has(path)) {
                const index = TableManager.reserveIndex();
                const pathKeys = realpath.split(".");
                const realpaths = pathKeys.map((p, i, t) => t.slice(0, i).join(".")).slice(1);

                const needed = [];
                let valueGetter, descriptorSetter = "";

                if (isGetter || isSetter) {
                    valueGetter = `(local.get $${realpath}/${descriptorKey})`;

                    descriptorSetter = `
                    (oninit
                        (local $${realpath} externref)
                        (local $${realpath}/${descriptorKey} externref)

                        (block $${realpath}
                            (local.set $${realpath}
                                (call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
                                    (local.get $${realpaths.at(-1)})
                                    (text "${pathKeys.at(-1)}")
                                )
                            )
                        )
                        
                        (block $${realpath}/${descriptorKey}
                            (local.set $${realpath}/${descriptorKey}
                                (call $self.Reflect.get<ext.ext>ext
                                    (local.get $${realpath})
                                    (text "${descriptorKey}")
                                )
                            )
                        )
                    )
                    `

                    needed.push(`
                    (needed "Reflect" "get" 
                        (func $self.Reflect.get<ext.ext>ext 
                            (param externref externref) 
                            (result externref)
                        )
                    )

                    (needed "Reflect" "getOwnPropertyDescriptor" 
                        (func $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
                            (param externref externref) 
                            (result externref)
                        )
                    )
                    `);
                }
                else {
                    realpaths.push(realpath);
                    valueGetter = `(local.get $${realpath})`;

                    needed.push(`
                    (needed "Reflect" "get" 
                        (func $self.Reflect.get<ext.ext>ext 
                            (param externref externref) 
                            (result externref)
                        )
                    )
                    `);
                }

                const initCode = String()
                    .concat(`
                    (oninit
                        (local $self externref)
                        ${needed.join("\n")}
                    )
                    `)
                    .concat(realpaths.map((p, i, t) => `
                    (oninit
                        (local $${p} externref)
                        (block $${p}
                            (local.set $${p}
                                (call $self.Reflect.get<ext.ext>ext 
                                    (local.get $${t.at(i - 1)})
                                    (text "${pathKeys[i]}")
                                )
                            )
                        )
                    )    
                    `).slice(1).join("\n")
                    )
                    .concat(descriptorSetter)
                    .concat(`
                    (oninit
                        ${TableManager.generateSetter(index, valueGetter)}
                    )
                `);

                this.externref.set(path, {
                    index, realpath, initCode
                });
            }

            const externref = this.externref.get(path);

            return String(`
                ${externref.initCode}
                ${TableManager.generateGetter(externref.index).concat(` ;; ${path}`)}
            `);
        }
        else {
            return String(`
                (needed "${root}" "${name}" 
                    (global $${path} ${type})
                )
                
                (global.get $${path})
            `);
        }
    },

    block: function (raw = "(module)", tag = "include") {
        const regex = new RegExp(`\\(${tag.replaceAll(/\./g, "\\\.")}`);
        const block = String(raw).match(regex);

        if (block) {
            let { index, input } = block;
            let end;
            let maxEnd = input.length;
            let substring;

            end = input.indexOf(")", index);
            substring = input.substring(index, ++end);

            while (substring.split("(").length !== substring.split(")").length) {
                end = input.indexOf(")", end);
                substring = input.substring(index, ++end);
                if (end > maxEnd) throw "max end reached!";
            }

            block.input = substring;
            block.end = end;

            let value = substring.substring(
                substring.indexOf(" "),
                substring.lastIndexOf(")")
            ).trim();

            const charMatch = value.charAt(0).match(/["'`]/);
            if (charMatch && value.charAt(value.length - 1) === charMatch.at(0)) {
                value = value.substring(1, value.length - 1);
            }

            const replace = str => String().concat(
                raw.substring(0, index)
            ).concat(str || "").concat(
                raw.substring(end)
            );

            const [
                tagType, tagSubType = ""
            ] = substring.substring(
                1, substring.indexOf(" ")
            ).trim().split(".");

            let blockName = "";
            if (value.startsWith("$")) {
                let nameEnd = 0;
                let nameLen = value.length;

                while (value.charAt(++nameEnd).match(w4.NAME_REGEXP)) {
                    if (nameEnd === nameLen) break;
                }

                blockName = value.substring(1, nameEnd);
            }

            if (blockName) {
                value = value.substring(
                    value.indexOf(blockName) + blockName.length
                ).trim() || value;

                if (false === isNaN(value)) {
                    value = parseFloat(value);
                }
            }

            Reflect.defineProperty(block, "tagType", { value: tagType, enumerable: true });
            Reflect.defineProperty(block, "tagSubType", { value: tagSubType, enumerable: true });
            Reflect.defineProperty(block, "blockName", { value: blockName, enumerable: true });
            Reflect.defineProperty(block, "value", { value: value, enumerable: true });
            Reflect.defineProperty(block, "remove", { value: replace.bind(block, "") });
            Reflect.defineProperty(block, "replace", { value: replace });
            Reflect.defineProperty(block, "valueOf", { value: () => value });

            delete block.groups;
        }

        return block;
    },

    needed: function (raw, match) {
        raw = match.remove();

        const imports = Array.from(raw.matchAll(/\(import\s/g));

        if (imports.length) {
            const needed = match.value.substring(
                match.value.indexOf("("),
                match.value.lastIndexOf(")"),
            );
            const tagName = needed.split(" ").at(0).substring(1);
            const blockName = w4.block(match.value, tagName).blockName;

            if (imports.map(i => w4.block(raw.substring(i.index), "import")).some(b => b.input.includes(blockName))) {
                return raw;
            }
        }

        return raw.replace(/\(module\s/, `(module 
            (import ${match.value.replaceAll(/\s+/g, " ")})`.replaceAll(/\s+\)/g, ")")
        );
    },

    oninit: function (raw, match) {
        raw = match.remove();

        let init = w4.block(raw, "init") || { value: "" };

        if (init.value) {
            raw = init.remove()
        }

        init = `
            (init
                ${init.value}
                ${match.value}
            )
        `;

        return raw.substring(
            0, raw.lastIndexOf(")")
        ).concat(init).concat(")");
    },

    bootstrap: function (raw) {
        let match, init = "";

        raw = raw.replace("(func $wat4wasm", "(init");

        if (match = w4.block(raw, "init")) {
            raw = match.remove();
            init = match.value;
        }

        let initFuncBodyParts = {
            head: new Set(),
            blocks: new Set(),
            table_set: new Set()
        }, part, code;

        while (part = w4.block(init, "local ")) {
            code = part.input;
            init = part.remove();

            if (part.blockName !== "self") {
                if (initFuncBodyParts.head.has(code) === false) {
                    initFuncBodyParts.head.add(code, code);
                }
            }
        }


        while (part = w4.block(init, "block")) {
            code = part.input.replaceAll(
                `(local.get $self)`, `(global.get $self)`
            );
            init = part.remove();

            if (initFuncBodyParts.blocks.has(code) === false) {
                initFuncBodyParts.blocks.add(code, code);
            }
        }

        while (part = w4.block(init, "table.set")) {
            code = part.input;
            init = part.remove();

            if (initFuncBodyParts.table_set.has(code) === false) {
                initFuncBodyParts.table_set.add(code, code);
            }
        }

        const sorter = (a, b) => {
            let a$name = a.split("$").at(1).split(" ").at(0) + ".";
            let b$name = b.split("$").at(1).split(" ").at(0);

            if (a$name.startsWith(b$name)) {
                return -1;
            }

            let aLen = a.split(".").length;
            let bLen = b.split(".").length;

            if (aLen === bLen) {
                aLen = a.length;
                bLen = b.length;
            }

            return bLen > aLen;
        };

        let starter = w4.block(raw, "start") || "";
        if (starter) {
            raw = starter.remove();
            starter = `
            
            (call $${starter.blockName})`;
        }

        let textDataHex = new Uint8Array(this.dataOffset);

        this.textExtern.forEach(t => {
            textDataHex.set(t.view, t.offset)
        });

        textDataHex = Array.from(
            textDataHex
        ).map(c => c.toString(16).padStart(2, 0)).join("\\");

        let funcrefs = "$wat4wasm";

        return raw.substring(0, raw.lastIndexOf(")")).concat(String(`
            (data  $wat4wasm "\\${textDataHex}")
            (elem  $wat4wasm declare func ${funcrefs})
            (func  $wat4wasm ;; stack limit exceed ;;
                ${Array.from(initFuncBodyParts.head).sort(sorter).reverse().join("\n")}\n
                ${Array.from(initFuncBodyParts.blocks).join("\n\n")}\n
                ${Array.from(initFuncBodyParts.table_set).sort(sorter).reverse().join("\n\n")}
                
                (nop)${starter}) 
            ${TableManager.generateTableDefinition()}
            (start $wat4wasm)
        `)).concat(")").replace(/\n\s*\n\s*\n/g, '\n\n').split("\n").filter((l, i, p) => {
            if (l.trim()) return true
            return !p[i - 1].trim().match(/\((global|table|local)\./);
        }).join("\n");
    }
}


let iteration = 0;
function wat4wasm(wat) {
    let match = true;

    while (match) {
        console.log(`\n✅ cursing! iterated: ${++iteration}`);

        if (match = w4.block(wat, "include")) {
            console.log(`📚 match at: ${match.index} -> ${match.input}`);
            wat = match.replace(w4.include(match));
            continue;
        }

        if (match = w4.block(wat, "text")) {
            console.log(`📑 match at: ${match.index} -> ${match.input}`);
            wat = match.replace(w4.text(match));
            continue;
        }

        if (match = w4.block(wat, "call_direct")) {
            console.log(`📑 match at: ${match.index} -> ${match.input}`);
            wat = match.replace(w4.call_direct(match));
            continue;
        }

        if (match = w4.block(wat, "self.")) {
            console.log(`📑 match at: ${match.index} -> ${match.input}`);
            wat = match.replace(w4.self(match));
            continue;
        }

        if (match = w4.block(wat, "needed")) {
            console.log(`📑 match at: ${match.index} -> ${match.input}`);
            wat = w4.needed(wat, match);
            continue;
        }

        if (match = w4.block(wat, "oninit")) {
            console.log(`📑 match at: ${match.index} -> ${match.input}`);
            wat = w4.oninit(wat, match);
            continue;
        }
    }

    return w4.bootstrap(wat);
}

function main() {
    try {
        console.log("🚀 Wat4Wasm: Derleme Başladı (Recursive Processing Mode)...\n");
        if (!fs.existsSync(ENTRY_FILE)) throw new Error("Dosya yok!");
        else {
            const rawCode = fs.readFileSync(ENTRY_FILE, "utf8");
            fs.writeFileSync(OUTPUT_FILE, wat4beauty(wat4wasm(rawCode)));
        }
        return;

        // --- 1. RESET ---
        // Her şeyi sıfırla ki üst üste binmesin (Idempotency)
        TableManager.reset();
        InjectManager.reset();

        resetTextPool();
        resetStringPool();
        resetRefExternPool();
        resetCustomTypes();
        resetArrayImports();
        resetDirectImports();
        resetApplyImports();
        resetGetImports();
        resetSetImports();
        resetNewImports();
        resetCallBound();

        TableManager.setManagers(InjectManager, ScopeManager);
        InjectManager.setManagers(TableManager, ScopeManager);
        ScopeManager.setManagers(TableManager, InjectManager);

        setManagers_resolveIncludes(TableManager, InjectManager, ScopeManager);
        setManagers_cleanComments(TableManager, InjectManager, ScopeManager);
        setManagers_standardLibrary(TableManager, InjectManager, ScopeManager);
        setManagers_extractRefExtern(TableManager, InjectManager, ScopeManager);
        setManagers_extractTextBlocks(TableManager, InjectManager, ScopeManager);
        setManagers_extractStringBlocks(TableManager, InjectManager, ScopeManager);
        setManagers_injector(TableManager, InjectManager, ScopeManager);
        setManagers_processCustomTypes(TableManager, InjectManager, ScopeManager);
        setManagers_processArrays(TableManager, InjectManager, ScopeManager);
        setManagers_processCallDirect(TableManager, InjectManager, ScopeManager);
        setManagers_processApply(TableManager, InjectManager, ScopeManager);
        setManagers_processGet(TableManager, InjectManager, ScopeManager);
        setManagers_processSet(TableManager, InjectManager, ScopeManager);
        setManagers_processNew(TableManager, InjectManager, ScopeManager);
        setManagers_processCallBound(TableManager, InjectManager, ScopeManager);
        setManagers_processRefFunc(TableManager, InjectManager, ScopeManager);

        let processedCode = rawCode;

        processedCode = resolveIncludes(processedCode);
        processedCode = processSimpleMacros(processedCode);
        processedCode = cleanComments(processedCode);
        processedCode = processCustomTypes(processedCode);
        processedCode = processCallBound(processedCode, extractRefExtern);
        processedCode = extractRefExtern(processedCode);
        processedCode = processCallDirect(processedCode);
        processedCode = processApply(processedCode);
        processedCode = processGet(processedCode);
        processedCode = processSet(processedCode);
        processedCode = processNew(processedCode);
        processedCode = processArrays(processedCode);
        processedCode = extractTextBlocks(processedCode);
        processedCode = extractStringBlocks(processedCode);
        processedCode = extractTextBlocks(processedCode);
        processedCode = processRefFunc(processedCode);

        generateRefExternInfrastructure();
        generateBoundInitCodes();
        generateTextSections();

        processedCode = TableManager.updateWAT(processedCode);
        processedCode = InjectManager.updateWAT(processedCode);
        processedCode = ScopeManager.updateWAT(processedCode);

        // --- 5. ÇIKTI BİRLEŞTİRME ---
        // Text/Data bölümünü oluştur (Artık hem ana koddan hem init kodlarından gelenler burada)

        const stringInfrastructure = generateStringInfrastructure();
        const tableDef = TableManager.generateTableDefinition();

        // Tüm Importları Topla
        const allImports = `
        ${getStandardImports()}
        ${stringInfrastructure.imports}
        ${generateArrayImports()}
        ${generateDirectImports()}
        ${generateApplyImports()}
        ${generateGetImports()}
        ${generateSetImports()}
        ${generateNewImports()}
        ${generateBoundImports()}
        `;

        // Trick: allImports değişkeninin sonuna ekleyebiliriz, çünkü WAT formatında importlar ve elemler top-leveldir.
        const topLevelDefinitions = `
        ${allImports}
        ${tableDef} 
        `;

        // Init Bloklarını Birleştir
        // Sıralama: Assetler -> Ref Extern (Ağaç) -> Call Bound -> ...
        const combinedInitBlock = `
        ${stringInfrastructure.initBlock}
        `;

        const extrafuncs = ``;

        // --- 6. ENJEKSİYON ---
        console.log("💉 Final kod enjekte ediliyor...");
        const finalWat = injectRuntimeLogic(
            processedCode,
            combinedInitBlock,
            "", // tableDef'i yukarıda topLevelDefinitions içine aldık veya burada birleştirebiliriz
            topLevelDefinitions, // Import parametresini "Top Level Definitions" olarak kullanıyoruz
            extrafuncs,
            `
                ${stringInfrastructure.bootstrapLocals}
            `.trim()// Injector bu değişkenleri fonksiyonun başına ekleyecek
        );


    } catch (err) {
        console.error(`\n 💥 HATA:\n`, err);
    }
}

main();