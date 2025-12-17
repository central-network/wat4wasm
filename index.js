import fs from "fs";
import wat4beauty from "wat4beauty"
import { TableManager } from "./lib/TableManager.js";
import { optimizeWat } from "./lib/Optimizer.js";

const ENTRY_FILE = "test.wat";
const OUTPUT_FILE = "output.wat";

const w4 = {
    include: function (match) {
        let path = match.blockContent;
        path = path.substring(path.startsWith("/"));
        return fs.readFileSync(path, "utf8");
    },

    longType: new Proxy({
        ext: "externref",
        ref: "externref",
        extern: "externref",
        fun: "funcref"
    }, { get: (t, p) => t[p] ?? p }),

    defaultValue: new Proxy({
        i32: "i32.const 0",
        i64: "i64.const 0",
        f32: "f32.const 0",
        f64: "f64.const 0",
        fun: "ref.null func",
        v128: "v128.const i32x4 0 0 0 0",
    }, { get: (t, p) => t[p] ?? "ref.null extern" }),

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
        let text = match.blockContent;
        let firstTimeSetterInitTickets = ``, index;

        if (false === this.externref.has(text)) {
            index = TableManager.reserveIndex();

            const view = this.encodeText(text);
            const offset = this.dataOffset;
            const length = view.length;

            this.externref.set(text, {
                view, offset, index
            });

            this.textExtern.push({ view, offset, length })
            this.dataOffset += length;

            if (text.length > 20) {
                text = text.substring(0, 20) + ".."
            }

            firstTimeSetterInitTickets = `
            (needed "Reflect" "construct" (func $self.Reflect.construct<ext.ext>ext (param externref externref) (result externref)))
            (needed "Reflect" "set" (func $self.Reflect.set<ext.i32.i32> (param externref i32 i32) (result)))
            (needed "Reflect" "set" (func $self.Reflect.set<ext.i32.ext> (param externref i32 externref) (result)))
            (needed "Reflect" "get" (func $self.Reflect.get<ext.ext>ext (param externref externref) (result externref)))
            (needed "Reflect" "apply" (func $self.Reflect.apply<ext.ext.ext>ext (param externref externref externref) (result externref)))
            (needed "Array" "of" (func $self.Array.of<ext>ext (param externref) (result externref)))
            (needed "String" "fromCharCode" (global $self.String.fromCharCode externref))

            (oninit
                (block $text<${offset}:${length}> ;; "${text}"
                    (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const ${offset}))
                    (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const ${length}))

                    (local.set $decodedText
                        (call $self.Reflect.apply<ext.ext.ext>ext
                            (local.get $decode)
                            (local.get $TextDecoder)
                            (call $self.Array.of<ext>ext 
                                (call $self.Reflect.construct<ext.ext>ext 
                                    (local.get $Uint8Array) 
                                    (local.get $arguments)
                                )
                            )
                        )
                    )

                    ${TableManager.generateSetter(index, `(local.get $decodedText)`)}
                )
            )   
            `
        }
        else {
            index = this.externref.get(text).index
        }

        if (text.length > 20) {
            text = text.substring(0, 20) + ".."
        }

        return `
        ${firstTimeSetterInitTickets}
        ${TableManager.generateGetter(index)} ;; "${text}"
        `;
    },

    call_direct: function (match) {
        const ref_func = w4.block(match.block, "self.fun ");
        const signature = {
            param: w4.block(match.block, "param") || { blockContent: "", block: "(param)" },
            result: w4.block(match.block, "result") || { blockContent: "", block: "(result)" },
        };

        let blockName = ref_func.blockName;

        let [funcName, rootName = "self"] = blockName.split(".").reverse();
        if (blockName.startsWith("self") === false) {
            blockName = `self.${blockName}`
        }

        const params = signature.param.blockContent.split(" ").map(p => w4.shortType[p]).join(".");;
        const result = signature.result.blockContent.split(" ").map(p => w4.shortType[p]).join(".");;

        const signedFuncName = `$${blockName}<${params}>${result}`;
        const callerArguments = match.blockContent
            .replace(ref_func.block, "")
            .replace(signature.param.block, "")
            .replace(signature.result.block, "")
            .trim();

        const caller = `
        (call ${signedFuncName} ${callerArguments})`.replaceAll(/\s+\)/g, ")");

        const needed = `
        (needed "${rootName}" "${funcName}"
            (func ${signedFuncName} 
                ${signature.param.block} 
                ${signature.result.block}
            )
        )`;

        return `
            ${caller}
            ${needed}
        `;
    },

    self: function (match) {
        const path = match.blockName; // Örn: navigator.gpu
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

        // Tip Analizi
        const isGlobalRef = (match.tagSubType === "ref") || match.tagSubType.match(/^(i32|f32|i64|f64)$/); // Kullanıcı 'ref' dediyse Global yapalım
        const parts = realpath.split(".");

        // Eğer basit primitive (i32 vb.) ve sığ derinlikse (self.length) IMPORT kullanmaya devam edebiliriz.
        // Ancak 'ref' (externref) ise ve derinlik ne olursa olsun, artık Global Fetch yapacağız.

        if (match.tagSubType.match(/^(i32|f32|i64|f64)$/) && parts.length < 1) {
            // Primitif ve sığ importlar (Import Object ile gelenler)
            const [name, root = "self"] = parts.slice().reverse();
            return String(`
            (needed "${root}" "${name}" (global $${path} ${w4.longType[match.tagSubType]}))
            (global.get $${path})
        `);
        }

        // --- GLOBAL FETCH veya TABLE FETCH ---

        if (false === this.externref.has(path)) {
            let index = -1; // Global ise index yok

            // Eğer Table kullanacaksak (ext) indeks ayırt
            if (!isGlobalRef) {
                index = TableManager.reserveIndex();
            }

            const pathKeys = realpath.split(".");
            const realpaths = pathKeys.map((p, i, t) => t.slice(0, i).join(".")).slice(1);
            const resultType = String(this.longType[match.tagSubType]).substring(0, 3);

            let valueGetter, descriptorSetter = "";
            const needed = [`(needed "self" "self" (global $self externref))`];

            // Getter/Setter Descriptor Mantığı (Reflect.getOwnPropertyDescriptor...)
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
                        (call $self.Reflect.get<ext.ext>${resultType}
                            (local.get $${realpath})
                            (text "${descriptorKey}")
                        )
                    )
                )
            )`;

                // Reflect importlarını ekle
                needed.push(`(needed "Reflect" "get" (func $self.Reflect.get<ext.ext>${resultType} (param externref externref) (result externref)))`);
                needed.push(`(needed "Reflect" "getOwnPropertyDescriptor" (func $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext (param externref externref) (result externref)))`);
            }
            else {
                // Standart Zincirleme
                realpaths.push(realpath);
                valueGetter = `(local.get $${realpath})`;
                needed.push(`(needed "Reflect" "get" (func $self.Reflect.get<ext.ext>ext (param externref externref) (result externref)))`);
            }

            // Init Kodunu İnşa Et
            let finalSetter = "";

            if (isGlobalRef) {
                // --- GLOBAL STRATEJİSİ ---
                // 1. init kodu çalışır, değeri bulur.
                // 2. global.set ile global değişkene yazar.
                finalSetter = `(global.set $${path} ${valueGetter})`;
            } else {
                // --- TABLE STRATEJİSİ ---
                finalSetter = TableManager.generateSetter(index, valueGetter);
            }

            const initCode = String()
                .concat(
                    `(oninit 
                (local $self externref) 
                ${needed.join("\n")}
            )`)
                .concat(
                    realpaths.map((p, i, t) => `
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
            )`).join("\n"))
                .concat(descriptorSetter)
                .concat(`(oninit 
                    ${finalSetter}
                )`);

            // Kayıt
            this.externref.set(path, {
                index,
                realpath,
                initCode,
                isGlobalRef // Bunu kaydediyoruz ki sonradan definition üretelim
            });
        }

        const refData = this.externref.get(path);

        if (isGlobalRef) {
            // Global Definition (Bunu main/boot sırasında header'a eklemelisin)
            // (needed_global ...) gibi bir tag ile dışarı fırlatabiliriz veya initCode içine yorum ekleriz.
            // Ama en temizi: 'needed' mekanizmanı kullanarak global tanımı enjekte etmek.

            return String(`
            ${refData.initCode}
            (globalized $${path} (mut ${this.longType[match.tagSubType]}) (${this.defaultValue[match.tagSubType]}))
            (global.get $${path}) ;; ${path}
        `);
        } else {
            // Table Getter
            return String(`
            ${refData.initCode}
            ${TableManager.generateGetter(refData.index)} ;; ${path}
        `);
        }
    },

    block: function (raw = "(module)", tag = "include") {
        const regex = new RegExp(`\\(${tag.replaceAll(/\./g, "\\\.")}`);
        const match = String(raw).match(regex);

        if (match) {
            let { index, input } = match;
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

            match.block = substring;
            match.end = end;

            let blockContent = substring.substring(
                substring.indexOf(" "),
                substring.lastIndexOf(")")
            ).trim();

            const charMatch = blockContent.charAt(0).match(/["'`]/);
            if (charMatch && blockContent.charAt(blockContent.length - 1) === charMatch.at(0)) {
                blockContent = blockContent.substring(1, blockContent.length - 1);
            }
            const [
                tagType, tagSubType = ""
            ] = substring.substring(
                1, substring.indexOf(" ")
            ).trim().split(".");

            let blockName = "";
            if (blockContent.startsWith("$")) {
                let nameEnd = 0;
                let nameLen = blockContent.length;

                while (blockContent.charAt(++nameEnd).match(w4.NAME_REGEXP)) {
                    if (nameEnd === nameLen) break;
                }

                blockName = blockContent.substring(1, nameEnd);
            }

            if (blockName) {
                blockContent = blockContent.substring(
                    blockContent.indexOf(blockName) + blockName.length
                ).trim() || blockContent;
            }

            Reflect.defineProperty(match, "tagType", { value: tagType, enumerable: true });
            Reflect.defineProperty(match, "tagSubType", { value: tagSubType, enumerable: true });
            Reflect.defineProperty(match, "blockName", { value: blockName, enumerable: true });
            Reflect.defineProperty(match, "blockContent", { value: blockContent, enumerable: true });
            Reflect.defineProperty(match, "raw", { value: substring, enumerable: true });
            Reflect.defineProperty(match, "input", { value: match.input, enumerable: false });

            delete match.groups;
        }

        return match;
    },

    needed: function (raw, match) {
        raw = w4.remove(raw, match);

        const imports = Array.from(raw.matchAll(/\(import\s/g));

        if (imports.length) {
            const needed = match.blockContent.substring(
                match.blockContent.indexOf("("),
                match.blockContent.lastIndexOf(")"),
            );
            const tagName = needed.split(" ").at(0).substring(1);
            const blockName = w4.block(match.blockContent, tagName).blockName;

            if (imports.map(i => w4.block(raw.substring(i.index), "import")).some(b => b.block.includes(`$${blockName} `))) {
                return raw;
            }
        }

        return raw.replace(/\(module\s/, `(module 
            (import ${match.blockContent.replaceAll(/\s+/g, " ")})
        `);
    },

    globalized: function (raw, match) {
        raw = w4.remove(raw, match);

        const globals = Array.from(raw.matchAll(/\(global\s\$(.[^\s]*)\s/g)).map(g => g[1]);

        console.log({ globals });

        if (globals.some(g => g === match.blockName)) {
            return raw;
        }

        return raw.substring(0, raw.lastIndexOf(")")).concat(
            match.raw.replace("(globalized ", "\n(global ")
        ).concat(")");
    },

    oninit: function (raw, match) {
        raw = w4.remove(raw, match);

        let init = w4.block(raw, "init") || { blockContent: "" };

        if (init.blockContent) {
            raw = w4.remove(raw, init)
        }

        init = `
            (init
                ${init.blockContent}
                ${match.blockContent}
            )
        `;

        return raw.substring(
            0, raw.lastIndexOf(")")
        ).concat(init).concat(")");
    },

    boot: function (raw) {
        let match, init = "";

        raw = raw.replace("(func $wat4wasm", "(init");

        if (match = w4.block(raw, "init")) {
            raw = w4.remove(raw, match);
            init = match.blockContent;
        }

        let initFuncBodyParts = {
            head: new Set(),
            blocks: new Set(),
            table_set: new Set()
        }, part, code;

        while (part = w4.block(init, "local ")) {
            code = part.block;
            init = w4.remove(init, part);

            if (part.blockName !== "self") {
                if (initFuncBodyParts.head.has(code) === false) {
                    initFuncBodyParts.head.add(code, code);
                }
            }
        }


        while (part = w4.block(init, "block")) {
            code = part.block.replaceAll(
                `(local.get $self)`, `(global.get $self)`
            );

            init = w4.remove(init, part);

            if (initFuncBodyParts.blocks.has(code) === false) {
                initFuncBodyParts.blocks.add(code, code);
            }
        }

        while (part = w4.block(init, "table.set")) {
            code = part.block;
            init = w4.remove(init, part);

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
            raw = w4.remove(raw, starter);
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
            (elem  $wat4wasm declare func ${funcrefs})
            (func  $wat4wasm ;; stack limit exceed ;;
                ${Array.from(initFuncBodyParts.head).sort(sorter).reverse().join("\n")}\n
                ${Array.from(initFuncBodyParts.blocks).join("\n\n")}\n
                ${Array.from(initFuncBodyParts.table_set).sort(sorter).reverse().join("\n\n")}
                
                (nop)${starter}) 
            (data  $wat4wasm "\\${textDataHex}")
            ${TableManager.generateTableDefinition()}
            (start $wat4wasm)
        `)).concat(")").replace(/\n\s*\n\s*\n/g, '\n\n').split("\n").filter((l, i, p) => {
            if (l.trim()) return true
            return !p[i - 1].trim().match(/\(((global|table|local)\.)|(import)/);
        }).join("\n");
    },

    replace: function (raw, match, replaceWith = "") {
        if (!match || (match.end - match.index) < 1) {
            return raw
        }

        return String().concat(
            raw.substring(0, match.index)
        ).concat(replaceWith).concat(
            raw.substring(match.end)
        );
    },

    remove: function (raw, match) {
        return w4.replace(raw, match, "");
    },

    generateFinalArgs: function () {
        const byteLength = this.dataOffset;

        const textLocals = `
            (local $TextDecoder  externref)
            (local $decode       externref)
            (local $arguments    externref)
            (local $Uint8Array   externref)
            (local $view         externref)
            (local $buffer       externref)
            (local $byteLength   i32)
            (local $decodedText  externref)
        `.trimStart();

        const prepareBlock = `
        (block $init
            (local.set $byteLength (i32.const ${byteLength}))
            (local.set $level/0 (global.get $self))

            (block $TextDecoder
                (local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))
                
                ${"TextDecoder".split("").map(c => c.charCodeAt()).map((c, i) => `
                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const ${i}) (i32.const ${c.toString().padStart(3, " ")}))`).join("")}

                (local.set $TextDecoder
                    (call $self.Reflect.construct<ext.ext>ext
                        (call $self.Reflect.get<ext.ext>ext
                            (global.get $self)
                            (call $self.Reflect.apply<ext.ext.ext>ext
                                (global.get $self.String.fromCharCode)
                                (ref.null extern)
                                (local.get $arguments)
                            )
                        )
                        (global.get $self)
                    )
                )
            )

            (block $TextDecoder:decode
                (local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))

                ${"decode".split("").map(c => c.charCodeAt()).map((c, i) => `
                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const ${i}) (i32.const ${c.toString().padStart(3, " ")}))`).join("")}

                (local.set $decode
                    (call $self.Reflect.get<ext.ext>ext
                        (local.get $TextDecoder)
                        (call $self.Reflect.apply<ext.ext.ext>ext
                            (global.get $self.String.fromCharCode)
                            (ref.null extern)
                            (local.get $arguments)
                        )
                    )
                )
            )

            (block $Uint8Array
                (local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))

                ${"Uint8Array".split("").map(c => c.charCodeAt()).map((c, i) => `
                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const ${i}) (i32.const ${c.toString().padStart(3, " ")}))`).join("")}

                (local.set $Uint8Array
                    (call $self.Reflect.get<ext.ext>ext
                        (global.get $self)
                        (call $self.Reflect.apply<ext.ext.ext>ext
                            (global.get $self.String.fromCharCode)
                            (ref.null extern)
                            (local.get $arguments)
                        )
                    )
                )
            )

            (block $view
                (local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))
                
                (call $self.Reflect.set<ext.i32.i32> 
                    (local.get $arguments) 
                    (i32.const 0) 
                    (local.get $byteLength)
                )

                (local.set $view
                    (call $self.Reflect.construct<ext.ext>ext
                        (local.get $Uint8Array)
                        (local.get $arguments)
                    )
                )
            )

            (block $memory.init
                (i32.const 0)
                (i32.load (i32.const 0))

                (loop $i--
                    (local.set $byteLength (i32.sub (local.get $byteLength) (i32.const 1)))    
                    (memory.init $wat4wasm (i32.const 0) (local.get $byteLength) (i32.const 1))                    
                    (call $self.Reflect.set<ext.i32.i32> (local.get $view) (local.get $byteLength) (i32.load8_u (i32.const 0)))
                    (br_if $i-- (local.get $byteLength))
                )

                (i32.store)
                (data.drop $wat4wasm)
            )

            (block $buffer
                (local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))

                ${"buffer".split("").map(c => c.charCodeAt()).map((c, i) => `
                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const ${i}) (i32.const ${c.toString().padStart(3, " ")}))`).join("")}

                (local.set $buffer
                    (call $self.Reflect.get<ext.ext>ext
                        (local.get $view)
                        (call $self.Reflect.apply<ext.ext.ext>ext
                            (global.get $self.String.fromCharCode)
                            (ref.null extern)
                            (local.get $arguments)
                        )
                    )
                )
            )
        )
        `.trim();

        return { textLocals, prepareBlock };
    }
}


let iteration = 0;
function wat4wasm(wat) {
    let match = { tagType: "boot" };

    while (match) {
        console.log(`☘️ cursing! for \x1b[36m${(++iteration).toString().padStart(3, " ")}\x1b[0m times.. \x1b[33m${match.tagType}\x1b[0m`.trim());

        if (match = w4.block(wat, "include")) {
            wat = w4.replace(wat, match, w4.include(match));
            continue;
        }

        if (match = w4.block(wat, "text")) {
            wat = w4.replace(wat, match, w4.text(match));
            continue;
        }

        if (match = w4.block(wat, "call_direct")) {
            wat = w4.replace(wat, match, w4.call_direct(match));
            continue;
        }

        if (match = w4.block(wat, "self.")) {
            wat = w4.replace(wat, match, w4.self(match));
            continue;
        }

        if (match = w4.block(wat, "needed")) {
            wat = w4.needed(wat, match);
            continue;
        }

        if (match = w4.block(wat, "globalized")) {
            wat = w4.globalized(wat, match);
            continue;
        }

        if (match = w4.block(wat, "oninit")) {
            wat = w4.oninit(wat, match);
            continue;
        }
    }

    const { textLocals, prepareBlock } = w4.generateFinalArgs();

    return optimizeWat(w4.boot(wat), textLocals, prepareBlock);
}

function main() {
    try {
        console.log("🚀 Wat4Wasm: Derleme Başladı (Recursive Processing Mode)...\n");
        if (!fs.existsSync(ENTRY_FILE)) throw new Error("Dosya yok!");
        else {
            const rawCode = fs.readFileSync(ENTRY_FILE, "utf8");
            fs.writeFileSync(OUTPUT_FILE, wat4beauty(wat4wasm(rawCode)));
        }
    } catch (err) {
        console.error(`\n 💥 HATA:\n`, err);
    }
}

main();