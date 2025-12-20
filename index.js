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
        fun: "funcref",
        i32: "i32",
        i64: "i64",
        f32: "f32",
        f64: "f64",
        v128: "v128",
    }, { get: (t, p) => t[p.substring(0, 3)] ?? (p && "externref" || "") }),

    defaultValue: new Proxy({
        i32: "i32.const 0",
        i64: "i64.const 0",
        f32: "f32.const 0",
        f64: "f64.const 0",
        fun: "ref.null func",
        ext: "ref.null extern",
        v128: "v128.const i32x4 0 0 0 0",
    }, { get: (t, p) => t[p] ?? (p && "ref.null extern" || "") }),

    shortType: new Proxy({
        externref: "ext",
        extern: "ext",
        ext: "ext",
        funcref: "fun",
        func: "fun",
        fun: "fun",
        i32: "i32",
        i64: "i64",
        f32: "f32",
        f64: "f64",
        v128: "v128",
    }, { get: (t, p) => t[p] ?? (p && "ext" || "") }),

    is_type: p => ["ext", "i32", "f32", "i64", "f64", "fun"].includes(p),
    type_of: (p, defaultType = "") => {
        p = `${p}`.trim().substring(0, 3);
        if (w4.is_type(p)) return p;
        return defaultType;
    },

    encodeText: TextEncoder.prototype.encode.bind(new TextEncoder),
    dataOffset: 4,
    externref: new Map,
    globalize: new Map,
    textExtern: new Array,

    NAME_REGEXP: /[a-zA-Z0-9\@\:\*\!\=\?\#\^\&\`<>\|\%\$\.\+-_\/\\]/,
    TYPE_REGEXP: /i32|f32|i64|f64|v128|ext|fun/g,

    text: function (match) {
        let text = match.blockContent;
        let firstTimeSetterInitTickets = ``, index;



        if (false === this.externref.has(text)) {

            index = TableManager.reserveIndex();

            let view = this.encodeText(text);
            let offset = 0;
            let length = view.length;

            this.externref.forEach(item => {
                if (item.offset && item.text.includes(text)) {
                    const begin = item.text.indexOf(text);
                    if (begin !== -1) {
                        offset = item.offset + begin;
                    }
                }
            });

            if (offset === 0) {
                offset = this.dataOffset;
                this.dataOffset += length;
            }

            this.externref.set(text, {
                view, offset, index, text
            });

            this.textExtern.push({ view, offset, length })

            if (text.length > 20) {
                text = text.substring(0, 20) + ".."
            }

            firstTimeSetterInitTickets = `            
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

        if (blockName.startsWith("self") === false) {
            blockName = `self.${blockName}`
        }

        const params = signature.param.blockContent.split(" ").map(p => w4.type_of(p)).join(".");
        const result = signature.result.blockContent.split(" ").map(p => w4.type_of(p)).join(".");

        const signedFuncName = `$${blockName}<${params}>${result}`;
        const callerArguments = match.blockContent
            .replace(ref_func.block, "")
            .replace(signature.param.block, "")
            .replace(signature.result.block, "")
            .trim();

        return `
        (call ${signedFuncName} ${callerArguments})`.replaceAll(/\s+\)/g, ")");
    },

    self: function (match) {
        let blockName = match.blockName; // Örn: navigator.gpu

        if (blockName.includes(":") === true) blockName = blockName.replaceAll(":", ".prototype.");
        if (blockName.startsWith("self") === false) blockName = `self.${blockName}`;

        const isGetter = blockName.endsWith("/get");
        const isSetter = blockName.endsWith("/set");

        let descriptorKey = "value";

        if (isGetter || isSetter) {
            if (isGetter) descriptorKey = "get";
            if (isSetter) descriptorKey = "set";
            blockName = blockName.substring(0,
                blockName.lastIndexOf(`/${descriptorKey}`)
            );
        }

        const descriptorKeys = [];
        descriptorKeys.push(descriptorKey);

        if (!descriptorKeys.includes("value")) { descriptorKeys.push("value"); }
        if (!descriptorKeys.includes("get")) { descriptorKeys.push("get"); }
        if (!descriptorKeys.includes("set")) { descriptorKeys.push("set"); }

        let pathWalk = blockName.split(".").map((p, i, t) => {
            if (i) {
                return `${t.slice(0, i).join(".")}.${p}`;
            }
            return p;
        });

        const propertyName = blockName.split(".").pop();
        const resultType = match.tagSubType;

        const globalize = `
            (globalized $${match.blockName} (mut ${this.longType[resultType]}) (${this.defaultValue[resultType]}))

        ${pathWalk.map((p, i, t) => {
            return;

            switch (i) {
                case 0: return `
                    (pathwalk $${p} 
                        (local.set $level/0 (global.get $${p}))
                    )
                `;

                case t.length - 1: return `
                    (pathwalk $${p} 


                        (if (call $self.Reflect.has<ext.ext>i32
                                (local.get $level/${i - 1})
                                (texxt "${propertyName}")
                            ) 
                            (then 
                                (local.get $prototype
                                    (call $self.Reflect.getPrototypeOf<ext>ext
                                        (local.get $level/${i - 1})
                                    )
                                )

                                (if (call $self.Reflect.has<ext.ext>i32
                                        (local.get $prototype)
                                        (texxt "${propertyName}")
                                    ) 
                                    (then
                                        (local.get $descriptorContainer
                                            (local.get $prototype)
                                        )
                                    )
                                    (else
                                        ;; object has property key but prototype hasn't
                                        ;; which means key its objects own and
                                        ;; descriptor defined on object
                                        (local.set $descriptorContainer
                                            (local.get $level/${i - 1})
                                        )
                                    )
                                )

                                (local.set $descriptor
                                    (call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
                                        (local.get $descriptorContainer)
                                        (texxt "${propertyName}")
                                    )
                                )

                                (block $descriptorKeys
                                    (br_if $descriptorKeys 
                                        (call $self.Reflect.has<ext.ext>i32
                                            (local.get $descriptor)
                                            (local.tee $descriptorKey (texxt "${descriptorKeys[0]}"))
                                        )
                                    )
                                    
                                    (br_if $descriptorKeys 
                                        (call $self.Reflect.has<ext.ext>i32
                                            (local.get $descriptor)
                                            (local.tee $descriptorKey (texxt "${descriptorKeys[1]}"))
                                        )
                                    )

                                    (local.set $descriptorKey (texxt "${descriptorKeys[2]}"))
                                    (br_if $descriptorKeys 
                                        (call $self.Reflect.has<ext.ext>i32
                                            (local.get $descriptor)
                                            (local.tee $descriptorKey (texxt "${descriptorKeys[2]}"))
                                        )
                                    )

                                    (unreachable)
                                )

                                (local.set $valueFetcher
                                    (call $self.Reflect.get<ext.ext>ext
                                        (local.get $descriptor)
                                        (local.get $descriptorKey)
                                    )
                                )

                                (if (call $self.Reflect.has<ext.ext>i32
                                        (local.get $descriptor)
                                        (texxt "${descriptorKeys[0]}")
                                    )
                                    (then 
                                        

                                        (local.set $value
                                            (call $self.Reflect.apply<ext.ext.ext>${resultType}
                                                (local.get $valueFetcher)
                                                (local.get $level/${i - 1})
                                                (global.get $self)
                                            )
                                        )
                                    )
                                    (else 
                                        (local.set $value
                                            (call $self.Reflect.get<ext.ext>${resultType}
                                                (local.get $level/${i - 1})
                                                (texxt "${propertyName}")
                                            )
                                        )
                                    )
                                )

                                (local.set $value 
                                    (call $self.Reflect.get<ext.ext>${resultType}
                                        (local.get $level/${i - 1})
                                        (texxt "${propertyName}")
                                    )
                                )
                            )
                            (else ;; it's object's value
                                (if (call $self.Reflect.has<ext.ext>i32
                                        (local.get $level/${i - 1})
                                        (texxt "${propertyName}")
                                    ) 
                                    (then
                                        (local.set $descriptor
                                            (call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
                                                (local.get $level/${i - 1})
                                                (texxt "${propertyName}")
                                            )
                                        )

                                        (local.set $descriptor (local.get $level/${i - 1})) 
                                        (local.set $descriptorKey (texxt "${propertyName}")) 
                                    )
                                    (else

                                    )
                                )
                            )
                        )


                        (local.set $hasPropertyValue
                            (call $self.Reflect.has<ext.ext>i32
                                (local.get $level/${i - 1})
                                (texxt "${propertyName}")
                            )
                        )

                        (local.set $hasOwnProperty
                            (call $self.Reflect.has<ext.ext>i32
                                (local.get $level/${i - 1})
                                (texxt "${propertyName}")
                            )
                        )

                        (if (call $self.Reflect.has<ext.ext>i32
                                (local.get $level/${i - 1})
                                (texxt "${propertyName}")
                            )
                            (then
                                (local.set $value
                                    (call $self.Reflect.get<ext.ext>${match.tagSubType}
                                        (local.get $descriptor)
                                        (texxt "${descriptorKey}")
                                    )
                                )
                            )
                            (else
                                (local.set $value
                                    (call $self.Reflect.get<ext.ext>${match.tagSubType}
                                        (local.get $level/${i - 1})
                                        (texxt "${p}")
                                    )
                                )
                            )
                        )

                        (global.set $${match.blockName} (local.get $value))
                    )
                `;

                default: return `
                    (pathwalk $${p} 
                        (local.set $level/${i}
                            (call $self.Reflect.get<ext.ext>ext
                                (local.get $level/${i - 1})
                                (texxt "${propertyName}")
                            )
                        )
                    )
                `;
            }
        }
        ).join("\n")}
            (global.get $${match.blockName})
        `;

        return globalize;
    },

    block: function (raw = "(module)", tag = "nop", start = 0) {

        if (tag.startsWith("(")) {
            throw `The "tag" argument for block search must not start with paranthesis: ${tag}`
        }

        if (start !== 0) {
            if (!tag) {
                let tagNameStart = start + 1;
                let tagNameEnd = tagNameStart;

                while (raw.charAt(tagNameEnd).trim()) {
                    tagNameEnd++;
                }

                tag = raw.substring(tagNameStart, tagNameEnd);
            }
        }

        if (!tag) {
            throw `At least one of "tag" or "start" argument is required for block search. (tag: [${tag}], start: [${start}])`
        }

        const regex = new RegExp(`\\(${tag.replaceAll(/([\.|\s|\$])/g, "\\\$1")}`);
        const match = String(raw).substring(start).match(regex);

        if (match) {
            match.input = raw;
            match.index += start;

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
                substring.match(/\(([\w\.]+)/)[0].length,
                substring.lastIndexOf(")")
            );

            if (blockContent.length) {
                while (!blockContent.charAt(0).trim()) {
                    blockContent = blockContent.substring(1);
                }
            }

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
            if (blockContent.trim().startsWith("$")) {
                let nameStart = -1;
                let nameLen = blockContent.length;
                let char = "";

                while (char = blockContent.charAt(nameStart++)) {
                    if (!char.trim()) {
                        continue;
                    };
                    if (char === "$") {
                        nameStart--;
                        break;
                    };
                }

                let nameEnd = nameStart;
                char = ";"
                while (char = blockContent.charAt(nameEnd++)) {
                    if (!char.trim()) break;
                    if (char === ")") break;
                    if (nameEnd === nameLen) break;
                }

                blockName = blockContent.substring(nameStart, nameEnd).trim();
                blockContent = blockContent.substring(nameEnd);
            }

            if (blockContent.length) {
                while (!blockContent.charAt(0).trim()) {
                    blockContent = blockContent.substring(1);
                }
            }

            let type = "";
            if (blockContent.trim().startsWith("(type")) {
                const typeStart = blockContent.indexOf("(type");
                const typeEnd = blockContent.indexOf(")", typeStart) + 1;

                type = blockContent.substring(typeStart, typeEnd);
                blockContent = blockContent.substring(
                    blockContent.indexOf(type) + type.length
                );
            }

            let param = "";
            if (blockContent.trim().startsWith("(param")) {
                const paramStart = blockContent.indexOf("(param");
                const paramEnd = blockContent.indexOf(")", paramStart) + 1;

                param = blockContent.substring(paramStart, paramEnd);
                blockContent = blockContent.substring(
                    blockContent.indexOf(param) + param.length
                );
            }

            let result = "";
            if (blockContent.trim().startsWith("(result")) {
                const resultStart = blockContent.indexOf("(result");
                const resultEnd = blockContent.indexOf(")", resultStart) + 1;

                result = blockContent.substring(resultStart, resultEnd);
                blockContent = blockContent.substring(
                    blockContent.indexOf(result) + result.length
                );
            }

            const signature = [type, param, result].filter(Boolean).join(" ").trim();
            const pathName = blockName.split("<").at(0).split("/").at(0).split(/\$|\./g).filter(Boolean).join(".");
            const hasSelfPath = pathName.startsWith("self");
            const $name = `${blockName}`;

            Reflect.defineProperty(match, "pathName", { value: pathName, enumerable: true });
            Reflect.defineProperty(match, "tagType", { value: tagType, enumerable: true });
            Reflect.defineProperty(match, "param", { value: param, enumerable: true });
            Reflect.defineProperty(match, "result", { value: result, enumerable: true });
            Reflect.defineProperty(match, "type", { value: type, enumerable: true });
            Reflect.defineProperty(match, "signature", { value: signature, enumerable: true });
            Reflect.defineProperty(match, "tagSubType", { value: tagSubType, enumerable: true });
            Reflect.defineProperty(match, "blockName", { value: blockName, enumerable: true });
            Reflect.defineProperty(match, "$name", { value: $name, enumerable: true });
            Reflect.defineProperty(match, "blockContent", { value: blockContent, enumerable: true });
            Reflect.defineProperty(match, "raw", { value: substring, enumerable: false });
            Reflect.defineProperty(match, "input", { value: match.input, enumerable: false });
            Reflect.defineProperty(match, "startedAt", { value: start, enumerable: true });
            Reflect.defineProperty(match, "hasSelfPath", { value: hasSelfPath, enumerable: true });

            Reflect.defineProperty(match, "generateNameSignature", {
                value: function (defaultType = { param: "", result: "", overwriteParam: false, overwriteResult: false }) {
                    let param = w4.block(this.generateParamBlock(), "param").blockContent.split(" ").filter(Boolean).map(p => w4.shortType[p]).join(".").trim(),
                        result = w4.block(this.generateResultBlock(), "result").blockContent.split(" ").filter(Boolean).map(p => w4.shortType[p]).join(".").trim();

                    if (defaultType.overwriteParam || !param) { param = defaultType.param; }
                    if (defaultType.overwriteResult || !result) { result = defaultType.result; }

                    return `<${param}>${result}`
                }
            });

            Reflect.defineProperty(match, "generateParamBlock", {
                value: function () {

                    if (this.blockName.includes("<") === false ||
                        this.blockName.includes("<>")
                    ) { return this.param || "(param)" }

                    return String()
                        .concat("(param ")
                        .concat(
                            this.blockName
                                .split(/\</).at(1)
                                .split(/\>/).at(0)
                                .split(/\./).map(t => w4.longType[t])
                                .join(" ")
                                .trim()
                        )
                        .concat(")")
                        .replace(" )", ")")
                        ;
                }
            });

            Reflect.defineProperty(match, "generateResultBlock", {
                value: function () {
                    if (this.blockName.includes(">") === false ||
                        this.blockName.endsWith(">")
                    ) { return this.result || "(result)" }

                    return String()
                        .concat("(result ")
                        .concat(
                            this.blockName
                                .split(/\>/).at(1)
                                .split(/\./).map(t => w4.longType[t])
                                .join(" ")
                                .trim()
                        )
                        .concat(")")
                        .replace(" )", ")")
                        ;
                }
            });

            Reflect.defineProperty(match, "generatedSignature", {
                get: function () {
                    return Array.of(
                        this.generateParamBlock(),
                        this.generateResultBlock()
                    ).join(" ").trim();
                }
            });

            Reflect.defineProperty(match, "generatedImportCode", {
                value: function () {
                    const [prop, root = "self"] = this.$name.substring(1).split("<").at(0).split("/").at(0).split(".").reverse();
                    return String(`
                    (import 
                        "${root}" 
                        "${prop}" 
                        
                        (func ${this.$name}
                            ${this.generateParamBlock()}
                            ${this.generateResultBlock()}
                        ) 
                    ) 
                `).replaceAll(/\s+/g, " ").replaceAll(/\s\)/g, ")").trim();
                }
            });

            delete match.groups;
        }

        return match;
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



        let textDataHex = new Uint8Array(this.dataOffset);

        this.textExtern.forEach(t => {
            textDataHex.set(t.view, t.offset)
        });

        let wat4Memory = "";
        if (raw.includes("(memory ") === false) {
            wat4Memory = `(memory $wat4wasm 1)`;
        }

        textDataHex = Array.from(
            textDataHex
        ).map(c => c.toString(16).padStart(2, 0)).join("\\");

        raw = raw.substring(0, raw.lastIndexOf(")"));
        raw = raw.concat(Array.from(this.globalize.values()).map(g => g.def).join("\n"));

        return `${raw}
            (elem   $wat4wasm declare func $wat4wasm)
            (func   $wat4wasm
                ${Array.from(initFuncBodyParts.head).sort(sorter).reverse().join("\n")}\n
                ${Array.from(initFuncBodyParts.blocks).join("\n\n")}\n
                ${Array.from(initFuncBodyParts.table_set).sort(sorter).reverse().join("\n\n")}    
            ) 
            (data   $wat4wasm "\\${textDataHex}")
            ${TableManager.generateTableDefinition()}
            (start  $wat4wasm)
            (global $wat4wasm (mut externref) (ref.null extern))
            ${wat4Memory}
        )`;
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

    ref_extern: function (match) {

        let index = 0,
            label = match.blockName;

        if (this.externref.has(label) === false) {

            index = TableManager.reserveIndex();

            this.externref.set(label, {
                index: index,
                raw: match.raw
            });
        }

        return TableManager.generateGetter(
            this.externref.get(label).index
        ).concat(` ;; ${match.blockName}`);
    },

    global_get: function (match) {
        const label = match.blockName;

        if ((this.globalize.has(label) === false) ||
            (this.globalize.get(label).type === null)
        ) {
            let type = Array.from(match.raw.matchAll(this.TYPE_REGEXP)).map(t => t.pop()).filter(Boolean).pop();
            if (this.is_type(type) === false) { type = null; }

            const mut = `(mut ${this.longType[type]})`;
            const val = `(${this.defaultValue[type]})`;

            this.globalize.set(label, {
                raw: match.raw,
                type: type,
                def: `(global $wat4wasm/${label} ${mut} ${val})`
            });
        }

        return `(global.get $wat4wasm/${label})`;
    },

    self_get: function (match) {

        const label = `self.${match.blockName}`.replace("self.self", "self");
        const chain = label.split(".");

        const blockContent = match.blockContent.split("\n").filter(l => l.trim() || !l.trim().startsWith(";;")).join("\n").trim();
        const propertyKey = chain.pop();
        const rootPathWalk = chain.join(".");

        const resultTypeStart = blockContent.lastIndexOf(")") + 1;
        const resultType = w4.type_of(blockContent.substring(
            resultTypeStart
        ).trim().split(" ").pop());

        return `(call $self.Reflect.get<ext.ext>${resultType} 
            (ref.extern $${rootPathWalk}) 
            (text "${propertyKey}")
        )`;
    },

    self_set: function (match) {

        const label = `self.${match.blockName}`.replace("self.self", "self");
        const chain = label.split(".");

        const blockContent = match.blockContent.split("\n").filter(l => l.trim() || !l.trim().startsWith(";;")).join("\n").trim();
        const propertyKey = chain.pop();
        const rootPathWalk = chain.join(".");

        const valueTypeEnd = blockContent.indexOf("(");
        const resultTypeStart = blockContent.lastIndexOf(")") + 1;
        const valueBlockRaw = blockContent.substring(
            valueTypeEnd, resultTypeStart,
        ).trim();

        const valueType = w4.type_of(blockContent.substring(
            0, valueTypeEnd
        ).trim().split(" ").pop(), "ext");

        const resultType = w4.type_of(blockContent.substring(
            resultTypeStart
        ).trim().split(" ").pop());

        return `(call $self.Reflect.set<ext.ext.${valueType}>${resultType} 
            (ref.extern $${rootPathWalk}) 
            (text "${propertyKey}")
            ${valueBlockRaw}
        )`;
    },

    self_has: function (match) {

        const label = `self.${match.blockName}`.replace("self.self", "self");
        const chain = label.split(".");

        const blockContent = match.blockContent.split("\n").filter(l => l.trim() || !l.trim().startsWith(";;")).join("\n").trim();
        const propertyKey = chain.pop();
        const rootPathWalk = chain.join(".");

        const valueTypeEnd = blockContent.indexOf("(");
        const resultTypeStart = blockContent.lastIndexOf(")") + 1;
        const valueBlockRaw = blockContent.substring(
            valueTypeEnd, resultTypeStart,
        ).trim();

        const valueType = w4.type_of(blockContent.substring(
            0, valueTypeEnd
        ).trim().split(" ").pop(), "ext");

        const resultType = w4.type_of(blockContent.substring(
            resultTypeStart
        ).trim().split(" ").pop(), "i32");

        return `(call $self.Reflect.has<ext.${valueType}>${resultType} 
            (self.get $${match.blockName} ext)
            ${valueBlockRaw}
        )`;
    },

    self_new: function (match) {


        let blockContent = match.blockContent.split("\n").filter(l => l.trim() || !l.trim().startsWith(";;")).join("\n").trim();
        if (blockContent.endsWith("ext")) {
            blockContent = blockContent.substring(0, blockContent.length - 3);
        }

        if (blockContent.indexOf("(") !== -1) {
            blockContent = blockContent.substring(blockContent.indexOf("("));
        }

        return `(call $self.Reflect.construct<ext.ext>ext
            (ref.extern $${match.blockName}) 
            (array 
                ${match.signature}
                ${blockContent.trim()}
            )
        )`;
    },

    array_of: function (match) {
        const nameSig = match.generateNameSignature({ result: "ext", overwriteResult: true });
        const $name = `$self.Array.of${nameSig}`;

        return `(call ${$name}
            ${match.blockContent}
        )`;
    },

    i32_extern: function (match) {
        let index = 0,
            label = match.blockName;

        if (this.externref.has(label)) {
            index = this.externref.get(label).index
        }

        return `(i32.const ${index})`;
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

            (local $value/i32    i32)
            (local $value/f32    f32)
            (local $value/i64    i64)
            (local $value/f64    f64)
            (local $value/ext    externref)
            (local $value/fun    funcref)
        `.trimStart();

        const prepareBlock = `
        (block $init
            (local.set $byteLength (i32.const ${byteLength}))
            (local.set $level/0 (global.get $self))

            (block $TextDecoder
                (local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))
                
                ${"TextDecoder".split("").map(c => c.charCodeAt()).map((c, i) => `
                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const ${i.toString().padStart(2, " ")}) (i32.const ${c.toString().padStart(3, " ")})) ;; ${String.fromCharCode(c)}`).join("")}

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
                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const ${i.toString().padStart(2, " ")}) (i32.const ${c.toString().padStart(3, " ")})) ;; ${String.fromCharCode(c)}`).join("")}

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
                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const ${i.toString().padStart(2, " ")}) (i32.const ${c.toString().padStart(3, " ")})) ;; ${String.fromCharCode(c)}`).join("")}

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
                (i32.const 0)
                (i32.load)

                (loop $i--
                    (local.set $byteLength (i32.sub (local.get $byteLength) (i32.const 1)))    
                    (memory.init $wat4wasm (i32.const 0) (local.get $byteLength) (i32.const 1))                    
                    
                    (call $self.Reflect.set<ext.i32.i32> 
                        (local.get $view) 
                        (local.get $byteLength) 
                        (i32.load8_u (i32.const 0))
                    )

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
    },
}

function redefineReferences(source) {
    let match, index;
    const elemBlocks = new Map;
    let $wat4wasmElemBlock;

    index = -1;
    while (match = w4.block(source, "elem", ++index)) {
        if (elemBlocks.has(match.index) === false) {
            elemBlocks.set(match.index, match.blockContent);
            if (match.$name === "$wat4wasm") {
                $wat4wasmElemBlock = match;
            }
        }
    }

    const refFuncs = new Set;
    index = -1;
    while (match = w4.block(source, "ref.func", ++index)) {
        if (refFuncs.has(match.$name) === false) {
            refFuncs.add(match.$name);
        }
    }

    refFuncs.forEach($name => {
        let isDefined = false;
        elemBlocks.forEach(blockContent => {
            if (isDefined === false &&
                blockContent.endsWith(` ${$name}`) ||
                blockContent.includes(` ${$name} `) ||
                blockContent.includes(` ${$name})`)
            ) { isDefined = true; }
        });

        if (isDefined) { refFuncs.delete($name); }
    });

    if (refFuncs.size > 0) {
        let imports = Array.from(refFuncs).filter($name => $name.startsWith("$self")).map($self_func => {
            return w4.block(`(func ${$self_func})`, `func`).generatedImportCode();
        }).join("\n")

        source = w4.replace(source, $wat4wasmElemBlock, String(`
            (elem   $wat4wasm declare func $wat4wasm ${Array.from(refFuncs).join(" ")})
        `).concat(imports).replaceAll(" )", ")").trim());
    }

    return source;
}

function redefineImports(source) {
    let match, index;

    const userImports = new Set;
    const selfImports = new Map;

    // find import blocks and remove
    index = -1;
    while (match = w4.block(source, "import", ++index)) {
        source = w4.remove(source, match);

        const raw = match.raw;
        if (match = w4.block(match.blockContent, "", match.blockContent.indexOf("("))) {

            if (match.hasSelfPath === false) {
                if (userImports.has(raw) === false) {
                    userImports.add(raw);
                }
                continue;
            }

            const blockName = match.blockName;
            if (true === selfImports.has(blockName)) { continue; }
            else { selfImports.set(blockName, match.generatedImportCode()) }
        }
    }

    // find $self[*]+ calls and create an import
    index = -1;
    while (match = w4.block(source, "call $self", ++index)) {

        const blockName = match.blockName;
        if (true === selfImports.has(blockName)) { continue; }
        else { selfImports.set(blockName, match.generatedImportCode()); }
    }

    if (selfImports.has("$self") === false) {
        selfImports.set("$self", `(import "self" "self" (global $self externref))`)
    }

    if (selfImports.has("$self.String.fromCharCode") === false) {
        selfImports.set("$self.String.fromCharCode", `(import "String" "fromCharCode" (global $self.String.fromCharCode externref))`)
    }

    const sorter = (a, b) => {
        const aLen = a.split(/\s+\(/g).at(0).length;
        const bLen = b.split(/\s+\(/g).at(0).length;
        return (aLen - bLen) || (
            a.split(/\$/g).at(1).split(" ").at(0).length -
            b.split(/\$/g).at(1).split(" ").at(0).length
        );
    }

    const refinedImportSection = Array.of(
        Array.from(userImports.values()).sort(sorter),
        "",
        Array.from(selfImports.values()).sort(sorter)
    ).flat().join("\n").trim();

    return source.replace(`(module`, `(module\n
        ${refinedImportSection}    
    `);
}

let iteration = 0;
function wat4wasm(wat) {
    let match = { tagType: "boot" };
    wat = wat.replaceAll(/\[(.)et(ter|)\]/g, `/$1et`);
    wat = wat.replaceAll(/TypedArray(\:|\.)/g, `Uint8Array.__proto__$1`);
    wat = wat.replaceAll(/\$(.[^\s]*)\:(.)/g, `$$$1.prototype.$2`);
    wat = wat.replaceAll(/\(null\)/g, `(ref.null extern)`);
    wat = wat.replaceAll(/\(self\)/g, `(global.get $self)`);
    wat = wat.replaceAll(/\(this\)/g, `(local.get 0)`);
    wat = wat.replaceAll(/\(array\)/g, `(call $self.Array<>ext)`);

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

        if (match = w4.block(wat, "ref.extern $self.")) {
            wat = w4.replace(wat, match, `(table.get ${match.blockName})`);
            continue;
        }
    }

    let index;
    let pathWalks = [];
    let replaceRaws = new Map;


    index = -1;
    while (match = w4.block(wat, "ref.func $self.", ++index)) {
        if (match.pathName.split(".").length > 3) {
            wat = wat.replaceAll(`(ref.func ${match.$name})`, `(global.get ${match.$name})`);
        }
    }

    index = -1;
    while (match = w4.block(wat, "table.get $self.", ++index)) {

        let extern_index;
        let pathWalker = "";

        if (false === w4.externref.has(match.raw)) {
            extern_index = TableManager.reserveIndex();

            w4.externref.set(match.raw, {
                index: extern_index
            });

            console.log(match)

            const pathWalk = {
                iBlocks: [],
                walkingKeys: match.pathName.split("."),
                walkingPaths: match.pathName.split(".").map((w, i, a) => a.slice(0, i).concat(w).join("."))
            };

            const propertyKey = pathWalk.walkingKeys.pop();
            const propertyPath = pathWalk.walkingPaths.pop();
            const descriptorKey = match.$name.split("/").at(1) || "value";

            let step = 0;
            let prevPath = pathWalk.walkingKeys.at(step);
            const type = match.type || "ext";

            while (++step < pathWalk.walkingPaths.length) {
                const stepKey = pathWalk.walkingKeys.at(step);
                const stepPath = pathWalk.walkingPaths.at(step);

                pathWalk.iBlocks.push(`\
                (oninit
                    (block $${stepPath}
                        (local.set $${stepPath}
                            (call $self.Reflect.get<ext.ext>ext
                                (local.get $${prevPath})
                                (text "${stepKey}")
                            )
                        )
                    )
                )`);

                prevPath = stepPath;
            }

            switch (descriptorKey) {
                case "value":
                    pathWalk.iBlocks.push(`\
                    (oninit
                        (block $${propertyPath}
                            (local.set $${propertyPath}
                                (call $self.Reflect.get<ext.ext>${type}
                                    (local.get $${prevPath})
                                    (text "${propertyKey}")
                                )
                            )
                            ${TableManager.generateSetter(extern_index, `(local.get $${propertyPath})`)}
                        )
                    )
                    `);
                    break;

                case "get":
                case "set": pathWalk.iBlocks.push(`
                (oninit
                    (block $${propertyPath}
                        (local.set $${propertyPath}
                            (call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
                                (local.get $${prevPath})
                                (text "${propertyKey}")
                            )
                        )
                    )

                    (block $${propertyPath}/${descriptorKey}
                        (local.set $${propertyPath}/${descriptorKey}
                            (call $self.Reflect.get<ext.ext>ext
                                (local.get $${propertyPath})
                                (text "${descriptorKey}")
                            )
                        )

                        ${TableManager.generateSetter(extern_index, `(local.get $${propertyPath}/${descriptorKey})`)}
                    )
                )`);
                    break;
            }

            pathWalker = String("\n").concat(pathWalk.iBlocks.join("\n"))
        }

        if (replaceRaws.has(match.raw) === false) {
            extern_index = w4.externref.get(match.raw).index;

            replaceRaws.set(match.raw,
                TableManager
                    .generateGetter(extern_index)
                    .concat(` ;; ${match.$name}\n`)
                    .concat(pathWalker)
            );
        }
    }

    index = -1;
    while (match = w4.block(wat, "global.get $self.", ++index)) {

        const label = match.$name;
        let pathWalker = "";

        if (w4.globalize.has(label) === false) {

            let type = Array.from(match.raw.matchAll(w4.TYPE_REGEXP)).map(t => t.pop()).filter(Boolean).pop();
            if (w4.is_type(type) === false) { type = "ext"; }

            const mut = `(mut ${w4.longType[type]})`;
            const val = `(${w4.defaultValue[type]})`;

            w4.globalize.set(label, {
                raw: match.raw,
                type: type,
                def: `(global ${label} ${mut} ${val})`,
                getter: `(global.get ${label})`,
            });

            const pathWalk = {
                iBlocks: [],
                walkingKeys: match.pathName.split("."),
                walkingPaths: match.pathName.split(".").map((w, i, a) => a.slice(0, i).concat(w).join("."))
            };

            const propertyKey = pathWalk.walkingKeys.pop();
            const propertyPath = pathWalk.walkingPaths.pop();
            const descriptorKey = match.$name.split("/").at(1) || "value";

            let step = 0;
            let prevPath = pathWalk.walkingKeys.at(step);

            while (++step < pathWalk.walkingPaths.length) {
                const stepKey = pathWalk.walkingKeys.at(step);
                const stepPath = pathWalk.walkingPaths.at(step);

                pathWalk.iBlocks.push(`\
                (oninit
                    (block $${stepPath}
                        (local.set $${stepPath}
                            (call $self.Reflect.get<ext.ext>ext
                                (local.get $${prevPath})
                                (text "${stepKey}")
                            )
                        )
                    )
                )`);

                prevPath = stepPath;
            }

            switch (descriptorKey) {
                case "value":
                    pathWalk.iBlocks.push(`\
                    (oninit
                        (block $${propertyPath}
                            (local.set $value/${type}
                                (call $self.Reflect.get<ext.ext>${type}
                                    (local.get $${prevPath})
                                    (text "${propertyKey}")
                                )
                            )
                                
                            (global.set $${label} (local.get $value/${type}))
                        )

                        (block $${propertyPath}
                            (local.set $${propertyPath}
                                (call $self.Reflect.get<ext.ext>ext
                                    (local.get $${prevPath})
                                    (text "${propertyKey}")
                                )
                            )
                        )
                    )
                    `);
                    break;

                case "get":
                case "set": pathWalk.iBlocks.push(`
                (oninit
                    (block $${propertyPath}
                        (local.set $${propertyPath}
                            (call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
                                (local.get $${prevPath})
                                (text "${propertyKey}")
                            )
                        )
                    )

                    (block $${propertyPath}/${descriptorKey}
                        (local.set $value/${type}
                            (local.tee $${propertyPath}/${descriptorKey}
                                (call $self.Reflect.get<ext.ext>${type}
                                    (local.get $${propertyPath})
                                    (text "${descriptorKey}")
                                )
                            )
                        )

                        (global.set $${label} (local.get $value/${type}))
                    )
                )`);
                    break;
            }

            pathWalker = String("\n").concat(pathWalk.iBlocks.join("\n"))
        }

        if (replaceRaws.has(match.raw) === false) {
            replaceRaws.set(match.raw, `(global.get $${label}) ${pathWalker}`)
        }
    }

    replaceRaws.forEach((replaceWith, search) => {
        wat = wat.replaceAll(search, replaceWith);
    });



    index = -1;
    while (match = w4.block(wat, "i32.extern", ++index)) {
        wat = w4.replace(wat, match, w4.i32_extern(match));
    }

    while (match = w4.block(wat, "array")) {
        wat = w4.replace(wat, match, w4.array_of(match));
    }

    while (match = w4.block(wat, "apply")) {
        wat = w4.replace(wat, match, `(call $self.Reflect.apply${match.generateNameSignature()}
            ${match.blockContent}
        )`);
    }

    while (match = w4.block(wat, "text")) {
        wat = w4.replace(wat, match, w4.text(match));
    }
    while (match = w4.block(wat, "oninit")) {
        wat = w4.oninit(wat, match);
    }

    wat = w4.boot(wat);
    wat = redefineReferences(wat);

    const { textLocals, prepareBlock } = w4.generateFinalArgs();
    wat = redefineImports(wat);
    wat = optimizeWat(wat, textLocals, prepareBlock);

    return wat;
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