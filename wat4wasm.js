import { WatParser } from "./lib/parser.js";
import fs from "fs";
import path from "path";

const define = (object, prop, value) => {
    return Object.defineProperty(object, prop, {
        value, configurable: true, writable: true
    });
};

const assign = (object, prop, value) => {
    return Object.assign(object, { [prop]: value });
};

class WatBlock {
    static TAG = new Map
    static ops = new Array

    static get registeredClasses() {
        console.table(WatBlock.TAG);
    }

    static #template = "([tag])";
    static #consumes = NaN;
    static #produces = NaN;

    constructor(raw = "(nop)", scope) {
        assign(this, "raw", raw)
        this.scope = scope;
    }

    get root() {
        let root = this;
        while (root.scope) {
            root = root.scope;
        }
        return root;
    }

    get raw() { }
    set raw(source) {
        this.source = source;
        this.reset();
    }

    reset() { }

    static isBlock(source) {
        return source.split("(").length === source.split(")").length;
    }

    static encodedAt(source, begin, opener, closer) {
        if (source.charAt(begin) !== opener) {
            throw new Error(`Encosed segment at needs to be start with: ${opener} but source is: ${source.substring(begin, begin + 10)}...`)
        }

        let end = source.indexOf(closer, begin + 1);
        let block = source;
        let max = source.length;


        while (block = source.substring(begin, ++end)) {
            if (block.split(opener).length === block.split(closer).length) {
                return block
            }

            end = source.indexOf(closer, end);

            if (end === -1) break;
            if (end > max) break;
        }

        return "";
    }

    static blockAt(source, begin = 0) {
        return this.encodedAt(source, begin, "(", ")")
    }

    static quotedAt(source, begin) {
        return this.encodedAt(source, begin, '"', '"')
    }

    static isClass(any) {
        return Array.from(WatBlock.TAG).flat().includes(any);
    }

    static parseTag(source) {
        const keyword = source.split(/\s|\)/).at(0);
        const match = keyword.match(/([a-z0-9]+)(?:\.([a-z0-9\._]+)?|)/);
        const [tag, tagRoot, tagOperator] = match;

        return {
            tag,
            tagRoot,
            tagOperator
        };
    }

    static findClass(raw) {
        const { tag } = this.parseTag(raw);
        const Class = WatBlock.TAG.get(tag);

        if (this.isClass(Class) === false) {
            console.warn(`⚠️  \x1b[35mWarning: Registered class NOT found for \x1b[0m(${tag} ...)`);
            return class extends WatBlock { tag = tag; raw = raw; toString() { return this.raw } };
        }

        return Class
    }

    static fromRaw(source, scope) {
        if (this.isBlock(source) === false) {
            throw new RangeError(`Block is NOT valid: ${source}`);
        }

        return Reflect.construct(
            this.findClass(source), Array.of(
                source, scope
            )
        );
    }

    static register(TagClass) {
        const { tag } = TagClass;

        if (WatBlock.TAG.has(tag)) {
            throw new Error(`Block type already registered: ${tag}`)
        }

        WatBlock.TAG.set(tag, TagClass);

        if (Object.hasOwn(TagClass, "ops")) {
            TagClass.ops.forEach(WatBlock.register);
        }
    }

    static cleanSpaces(source) {
        return source
            .replaceAll(/\s+/g, " ")
            .replaceAll(/\s+\)/g, ")");
    }

    extractAlias() {
        let raw = this.source,
            watRemain = this.trimBlockWrapper(),
            $name = "",
            alias = { $name, toString: function () { return `${this.$name}` } };


        if (watRemain.startsWith("$")) {
            alias.$name = watRemain.split(/\s/).at(0).split(")").at(0)
            alias.isSelfPath = alias.$name.startsWith("$self");
            const begin = raw.indexOf(alias.$name);
            const end = begin + alias.$name.length;

            raw = raw.substring(0, begin).concat(raw.substring(end));
        }

        this.source = raw;
        return alias;
    }

    static trimBlockWrapper(raw) {

        raw = raw.trim();

        if (raw.startsWith('(') && raw.endsWith(')')) {
            raw = raw.substring(
                raw.indexOf('('), raw.lastIndexOf(')'),
            );

            //walk untik (tag... ends
            while (raw.length && raw.at(0).trim()) { raw = raw.substring(1); }
        }

        raw = raw.trim();

        return raw;
    }

    trimBlockWrapper() {
        return WatBlock.trimBlockWrapper(this.source);
    }

    static splitBlocks(raw) {
        let begin = -1, block, blocks = [];

        while ((begin = raw.indexOf("(", begin)) !== -1) {

            if (block = WatBlock.blockAt(raw, begin)) {
                begin = begin + block.length;
                blocks.push(block);
                continue;
            }

            break;
        }

        return blocks;
    }

    extractBlocks() {
        let raw = this.source,
            begin,
            watRemain = this.trimBlockWrapper(),
            block, blocks = [];

        while (true) {
            begin = watRemain.indexOf("(");

            if (begin === -1) { break; }

            if (block = WatBlock.blockAt(watRemain, begin)) {
                blocks.push(block);
                raw = raw.replace(block, "");
                watRemain = watRemain.replace(block, "");
                continue;
            }

            break;
        }

        this.source = raw;

        return blocks;
    }

    extractQuotes() {
        let raw = this.source,
            begin,
            watRemain = this.trimBlockWrapper(),
            quote, quotes = [];

        while (true) {
            begin = watRemain.indexOf('"');

            if (begin === -1) { break; }

            if (quote = WatBlock.quotedAt(watRemain, begin)) {
                quotes.push(quote.substring(1, quote.length - 1));
                raw = raw.replace(quote, "");
                watRemain = watRemain.replace(quote, "");
                continue;
            }

            break;
        }

        this.source = raw;
        return quotes;
    }

    get blockOpeners() { return Array(); }
    get headSegments() { return Array(); }
    get bodySegments() { return Array(); }
    get footSegments() { return Array(); }
    get blockClosers() { return Array(); }

    toString() {
        return Array()
            .concat(`(${this.constructor.tag} `)
            .concat(this.blockOpeners.filter(Boolean).join(" ").concat(" "))
            .concat(this.headSegments.filter(Boolean).map(s => s.toString()).join("\n").concat(" "))
            .concat(this.bodySegments.filter(Boolean).map(s => s.toString()).join("\n").concat(" "))
            .concat(this.footSegments.filter(Boolean).map(s => s.toString()).join("\n").concat(" "))
            .concat(this.blockClosers.filter(Boolean).join(" ").concat(" "))
            .join("\n\n")
            .trim()
            .concat(`)`);
    }

    static isEmpty(source) {
        return source.split(/\s+|\(|\)/).slice(2).filter(Boolean).length === 0;
    }

    isEmpty() {
        return WatBlock.isEmpty(this.source)
    }

    static get tag() {
        throw new TypeError(`Tag requested from root class: WatBlock`)
    }
}

class WatModule {
    constructor(raw) {
        const content = WatBlock.trimBlockWrapper(raw);

        this.blocks = [];
        this.importBlocks = [];
        this.typeBlocks = [];
        this.globalBlocks = [];
        this.memoryBlocks = [];
        this.elemBlocks = [];
        this.funcBlocks = [];
        this.dataBlocks = [];
        this.tableBlocks = [];
        this.startBlocks = [];

        WatBlock.splitBlocks(content).forEach(block => {
            this.blocks.push(block);

            switch (this.getBlockTag(block)) {
                case "import":
                    this.importBlocks.push(block);
                    break;

                case "data":
                    this.dataBlocks.push(block);
                    break;

                case "func":
                    this.funcBlocks.push(block);
                    break;

                case "elem":
                    this.elemBlocks.push(block);
                    break;

                case "table":
                    this.tableBlocks.push(block);
                    break;

                case "memory":
                    this.memoryBlocks.push(block);
                    break;

                case "start":
                    this.startBlocks.push(block);
                    break;

                case "type":
                    this.typeBlocks.push(block);
                    break;

            }
        })

        define(this, "raw", raw);
    }

    get saccharine() {
        let sugar, block;
        let blockIndex = this.blocks.length;
        let sugarIndex;

        while (--blockIndex) {
            block = this.blocks.at(blockIndex);
            sugarIndex = WatModule.sugars.length

            while (--sugarIndex) {
                sugar = WatModule.sugars.at(sugarIndex);

                if (sugar.exec.test(block)) {
                    return { sugar, block };
                }
            }
        }
    }

    get blockTags() {
        return this.blocks.map(b => this.getBlockTag(b))
    }

    hasBlock(tag) {
        return this.blockTags.some(t => t === tag);
    }

    getBlockTag(block) {
        return block.split(" ").at(0).split(")").at(0).substring(1);
    }

    getBlock(tag) {
        return this.blocks[this.blockTags.indexOf(tag)] || ``;
    }

    replaceTag(block, tag) {
        return block && block.replace(this.getBlockTag(block), tag) || ``;
    }

    get $wat4wasm_memory() {
        if (this.hasBlock("memory")) return ``
        return `(memory $wat4wasm 1)`
    }

    get hex() {
        return `\\00\\00\\00\\00`;
    }

    get $wat4wasm_data() {
        return `(data $wat4wasm "${this.hex}")`
    }

    get $wat4wasm_start() {
        return `(start $wat4wasm)`
    }

    get $wat4wasm_global() {
        return `(global $wat4wasm (mut extern) (ref.null externref))`
    }

    get $wat4wasm_table() {
        return `(table $wat4wasm externref)`
    }

    get $wat4wasm_func() {
        return `(func $wat4wasm
            (local $TextDecoder externref)
            (local $arguments externref)

                    (call $self.Reflect.set<ext.i32.fun> (local.get $arguments) (i32.const 0) (i32.const 25))
                    (call $self.Reflect.set<ext.v128.fun.i64.f64.ext>fun.i64.f64.ext (local.get $arguments) (i32.const 0) (i32.const 25))

            (block $prepare
                (block $TextDecoder
                    (local.set $arguments (call $self.Array<i32>ext (i32.const 0)))
                    (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 0) (i32.const 25))

                    (local.set $TextDecoder
                        (call $self.Reflect.construct<ext.ext>ext
                            (call $self.Reflect.get<ext.ext>ext
                                (global.get $self)
                                (call $self.Reflect.apply<ext.ext.ext>ext
                                    (global.get $self.String.fromCharCode<ext>)
                                    (ref.null externref)
                                    (local.get $arguments)
                                )
                            )
                            (global.get $self)
                        )
                    )
                )
            )

            ${this.startBlocks.map(b => this.replaceTag(b, 'call')).join("\n")}
        )`;
    }

    get $wat4wasm_elem() {
        return `(elem $wat4wasm declare func $wat4wasm)`
    }

    static create_global_definer(name, type) {
        let value, mutater;
        switch (type.substring(0, 3)) {
            case "i32":
            case "f32":
            case "i64":
            case "f64":
                mutater = `(mut ${type})`;
                value = `(${type}.const 0)`;
                break;
            case "v12":
                mutater = `(mut ${type})`;
                value = `(${type}.const i32x4 0 0 0 0)`;
                break;

            case "fun":
                mutater = `(mut funcref)`;
                value = `(ref.null func)`;
                break;

            case "ext":
                mutater = `(mut externref)`;
                value = `(ref.null extern)`;
                break;
        }

        return `(global ${name} 
            ${mutater}
            ${value}
        )`.replaceAll(/\s+/g, ` `).replaceAll(" )", ")");
    }

    static create_function_definer(name, param, result) {
        return `(func ${name} 
            (param ${param.join(" ")}) 
            (result ${result.join(" ")})
        )`.replaceAll(/\s+/g, ` `).replaceAll(" )", ")");
    }

    static desugar_path(path, tag) {
        path = path.replaceAll(/\:/g, ".prototype.");
        path = path.replaceAll("self.TypedArray.", "self.Uint8Array.__proto__.");

        let name = path;
        let signature = path.match(
            /\<((?:(?:i32|f32|i64|f64|ext|fun|v128)(?:\.?))*)>((?:(?:i32|f32|i64|f64|ext|fun|v128)(?:\.?))*)/
        );

        let param = [];
        let result = [];
        let definer = ``;

        if (signature) {
            const replaceType = t => {
                if (t.startsWith("ext")) { t = "externref"; }
                else if (t.startsWith("fun")) { t = "funcref"; }
                return `${t}`
            }

            const convertSign = t => {
                return t.split(".").map(replaceType);
            }

            path = path.replace(signature.at(0), "");
            param = convertSign(signature.at(1));
            result = convertSign(signature.at(2));
        }

        signature = { name, path: path.split(".").slice(1), definer }

        switch (tag) {
            case "call":
                signature.type = "func";
                signature.param = param;
                signature.result = result;
                break;

            case "global.get":
                signature.type = "global";
                signature.kind = param[0] || "ext";
                break;

            case "ref.func":
                signature.type = "elem";
                signature.kind = "funcref";
                break;

            case "ref.extern":
                signature.type = "table";
                signature.kind = "externref";
                break;
        }

        if (signature.type === "func") {
            signature.definer = this.create_function_definer(signature.name, signature.param, signature.result);
        }
        else if (signature.type === "global") {
            signature.definer = this.create_global_definer(signature.name, signature.kind);
        }

        return signature
    }

    importsFor(body) {
        return Array.from(
            body
                .matchAll(/\((.[^\s]*)\s+(\$self([\.a-zA-Z0-9\+\_\<\>\[\]\/\:]*))/g))
            .map(m => Object({ tag: m[1], path: WatModule.desugar_path(m[2], m[1]), at: m.index }))
            .map(m => {
                let { tag, path, at } = m;
                console.log(m)

            }).filter(Boolean).join("\n");
    }

    toString() {
        const body = (`
            ;; developer
            ${this.typeBlocks.join("\n\n\t")}
            ${this.globalBlocks.join("\n\n\t")}
            ${this.memoryBlocks.join("\n\n\t")}
            ${this.tableBlocks.join("\n\n\t")}
            ${this.elemBlocks.join("\n\n\t")}
            ${this.funcBlocks.join("\n\n\t")}
            ${this.dataBlocks.join("\n\n\t")}
            ;; $wat4wasm 
            ${this.$wat4wasm_memory}
            ${this.$wat4wasm_global}
            ${this.$wat4wasm_table}
            ${this.$wat4wasm_func}
            ${this.$wat4wasm_elem}
            ${this.$wat4wasm_data}
            ${this.$wat4wasm_start}            
        `);

        return `
        (module
            ${this.importsFor(body)}
            ${this.importBlocks.join("\n\n\t")}
            ${body}
        )
        `;
    }
}

WatBlock.register(class WatMemory extends WatBlock {
    static tag = "memory"
    static ops = [
        class extends this {
            static tag = "memory.init";
        }
    ]

    toString() {
        const args = [];

        if (this.alias.$name) { args.push(this.alias.$name) }
        if (this.isI64Memory) { args.push("i64") }
        if (!isNaN(this.initial)) { args.push(this.initial) }
        if (!isNaN(this.maximum)) { args.push(this.maximum) }
        if (this.isSharedBuffer) { args.push("shared") }

        return `(memory ${args.join(" ")})`
    }

    reset() {
        const alias = this.extractAlias();
        const content = this.trimBlockWrapper().split(/\s+/).filter(Boolean);

        if (content[0] === "i64") {
            this.isI64Memory = true;
            content.splice(0, 1);
        }

        if (content[content.length - 1] === "shared") {
            this.isSharedBuffer = "shared";
            content.splice(-1, 1);
        }

        if (isNaN(content[0]) === false) {
            this.initial = content[0];
            content.splice(0, 1);
        }

        if (isNaN(content[0]) === false) {
            this.maximum = content[0];
            content.splice(0, 1);
        }

        assign(this, "alias", alias);
    }
})

WatBlock.register(class WatData extends WatBlock {
    static tag = "data"
    static ops = [
        class extends this {
            static tag = "data.drop";
        }
    ]

    toString() {
        const parts = Array.of(
            this.alias.toString(),
            this.offset.toString(),
        ).filter(Boolean);

        return (`
            (data ${parts.join(" ")} "${this.content.toString()}"})
        `).trim();
    }

    reset() {
        const alias = this.extractAlias();
        const offset = this.extractBlocks();
        const content = this.extractQuotes();

        assign(this, "alias", alias);
        assign(this, "offset", offset);
        assign(this, "content", content);
    }

})


WatBlock.register(
    class WatI32 extends WatBlock {
        static tag = "i32"
        static ops = [
            class extends this {
                static tag = "i32.const";
                static #template = "([tag][dot][op][space][number])"
                static #consumes = 0;
                static #produces = 1;
            },

            class extends this {
                static tag = "i32.load"
                static #template = "([tag][dot][op][space][?offset][block])"
                static #consumes = 1;
                static #produces = 1;
            },

            class extends this {
                static tag = "i32.atomic"
                static ops = [
                    class extends this {
                        static tag = "i32.atomic.load"
                        static #template = "([tag][dot][op][space][?offset][block])"
                        static #consumes = 1;
                        static #produces = 1;
                    },

                    class extends this {
                        static tag = "i32.atomic.rmw"
                        static ops = [
                            class extends this {
                                static tag = "i32.atomic.rmw.add"
                            }
                        ]
                    }
                ]
            }
        ]

    }
)

WatBlock.register(
    class WatImport extends WatBlock {
        static tag = "import"

        toString() {
            return (`
                (import "${this.rootName}" "${this.propName}" ${this.variable.toString()})
            `).trim();
        }

        reset() {
            let quotes = this.extractQuotes();
            let blocks = this.extractBlocks();

            if (quotes.length === 2) {
                assign(this, "rootName", quotes[0]);
                assign(this, "propName", quotes[1]);
            }

            if (blocks.length === 1) {
                assign(this, "variable", WatBlock.fromRaw(blocks[0], this.root));
            }

            if (this.isEmpty() === false) {
                throw new Error(`Import block has non-block expression: \x1b[31m${this.source}\x1b[0m`);
            }
        }
    }
)

console.log(WatBlock.registeredClasses)

export class WatCompiler {
    constructor() {
        // Core state will go here
    }

    compile(wat) {
        const wp = new WatModule(
            this.resolveIncludes(wat)
        );

        // 1. Recursive Include Resolution
        //wat = this.resolveIncludes(wat);
        return wp.toString();
    }

    resolveIncludes(wat) {
        let parser = new WatParser(wat);
        let match;
        // Loop until no more includes found
        // Note: findBlock returns the *first* match from offset. 
        // Since we replace content, offsets change. It's safer to re-parse or handle carefully.
        // Simplest: Find first, replace, recurse/loop.

        while (match = parser.findBlock("include")) {
            // match.innerContent: "include "file.wat"" -> we need to extract the string.
            // expecting: include "filepath"

            const parts = match.innerContent.trim().split(/\s+/);
            // parts[0] is "include"
            // parts[1] is filename (quoted)

            let filename = parts[1];
            if (filename && filename.startsWith('"') && filename.endsWith('"')) {
                filename = filename.slice(1, -1);
            } else {
                console.warn("Invalid include syntax:", match.fullContent);
                // Replace with empty or keep? preventing infinite loop requires change.
                // Replaec with comment to avoid loop
                wat = wat.substring(0, match.start) + `;; INVALID INCLUDE: ${match.fullContent}` + wat.substring(match.end);
                parser = new WatParser(wat);
                continue;
            }

            let includeContent = "";
            try {
                // Assuming relative to CWD for now, or relative to entry file?
                // For this step, simply reading from CWD.
                includeContent = fs.readFileSync(filename, "utf8");
            } catch (e) {
                console.warn(`Could not read include file: ${filename}`, e.message);
                includeContent = `;; ERROR: Could not include ${filename}\n`;
            }

            // Replace the (include ...) block with the file content
            wat = wat.substring(0, match.start) + includeContent + wat.substring(match.end);

            // Re-initialize parser with new content to find nested includes or next includes
            parser = new WatParser(wat);
        }
        return wat;
    }
}
