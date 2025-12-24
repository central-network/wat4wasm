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
        this.otherBlocks = [];

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

                default:
                    this.otherBlocks.push(block);
                    break;

            }
        });

        if (false === this.importBlocks.some(b => b.match(/\(global\s+\$self\s+externref\)/))) {
            this.importBlocks.unshift(`(import "self" "self" (global $self externref))`)
        }

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
        return Array.from(this.textBuffer.toString("hex").matchAll(/[a-f0-9]{2}/g)).join("\\") || "00";
    }

    get $wat4wasm_data() {
        return `(data $wat4wasm "\\${this.hex}")`
    }

    get $wat4wasm_start() {
        return `(start $wat4wasm)`
    }

    get $wat4wasm_global() {
        return `(global $wat4wasm (mut externref) (ref.null extern))`
    }

    get $wat4wasm_table() {
        return `(table $wat4wasm ${this.externrefs.length + 1} externref)`
    }

    static TEMPLATE = {
        stringFromCharCode: (offset, length, extindex, string = "") => String(`
            (block $text/${offset}+=${length / 4} (; ${string.replaceAll(/\s+/g, " ").substring(0, 50)} ;)
                (local.set $arguments (call $self.Reflect.ownKeys<ext>ext (global.get $self.String.fromCharCode)))
                
                (local.set $offset (i32.const ${offset}))
                (local.set $length (i32.const ${length}))
                (local.set $charAt (i32.const 0))

                (loop $i--
                    (if (local.get $length)
                        (then
                            (memory.init $wat4wasm 
                                (i32.const 0) (local.get $offset) (i32.const 4)
                            )

                            (call $self.Reflect.set<ext.i32.i32> 
                                (local.get $arguments) 
                                (local.get $charAt) 
                                (i32.sub (i32.load (i32.const 0)) (i32.const 0xffff))  
                            )  

                            (local.set $charAt (i32.add (local.get $charAt) (i32.const 1)))
                            (local.set $offset (i32.add (local.get $offset) (i32.const 4)))
                            (local.set $length (i32.sub (local.get $length) (i32.const 4)))

                            (br $i--)
                        )
                    )
                )

                (table.set $wat4wasm 
                    (i32.const ${extindex})
                    (call $self.Reflect.apply<ext.ext.ext>ext
                        (global.get $self.String.fromCharCode)
                        (ref.null extern)
                        (local.get $arguments)
                    )
                )
            ) 
        `)
    }

    get $wat4wasm_func() {
        return `(func $wat4wasm
            (local $arguments externref)
            (local $offset i32)
            (local $length i32)
            (local $charAt i32)

            ${this.externrefs
                .filter(e => Reflect.has(Object(e), "text"))
                .map(t => WatModule.TEMPLATE.stringFromCharCode(t.offset, t.length, t.extindex, t.text))
                .join("\n")
            }

            ${this.startBlocks.map(b => this.replaceTag(b, 'call')).join("\n")}
        )`;
    }

    get $wat4wasm_elem() {
        return `(elem $wat4wasm declare func $wat4wasm)`
    }

    create_global_importer(signature) {
        let value, mutater, type;
        switch (signature.kind.substring(0, 3)) {
            case "i32":
            case "f32":
            case "i64":
            case "f64":
                type = signature.kind;
                mutater = `(mut ${type})`;
                value = `(${type}.const 0)`;
                break;
            case "v12":
                type = signature.kind;
                mutater = `(mut ${type})`;
                value = `(${type}.const i32x4 0 0 0 0)`;
                break;

            case "fun":
                type = "funcref";
                mutater = `(mut ${type}ref)`;
                value = `(ref.null func)`;
                break;

            case "ext":
                type = "externref";
                mutater = `(mut ${type}ref)`;
                value = `(ref.null extern)`;
                break;
        }

        return String(`(import
            "${signature.object}" 
            "${signature.property}"

            (global ${signature.name} ${type})
        )`).trim().replaceAll(/\s+/g, ` `).replaceAll(" )", ")");
    }

    create_function_importer(signature) {
        return String(`(import 
            "${signature.object}" 
            "${signature.property}"
            
            (func ${signature.name} 
                (param ${signature.param.join(" ")}) 
                (result ${signature.result.join(" ")})
            )
        )`).trim().replaceAll(/\s+/g, ` `).replaceAll(" )", ")");
    }

    desugar_path(path, tag) {
        path = path.replaceAll(/\:/g, ".prototype.");
        path = path.replaceAll("self.TypedArray.", "self.Uint8Array.__proto__.");

        let name = path;
        path = path.substring(path.indexOf("$") + 1);

        let signature = path.match(
            /\<((?:(?:i32|f32|i64|f64|ext|fun|v128)(?:\.?))*)>((?:(?:i32|f32|i64|f64|ext|fun|v128)(?:\.?))*)/
        );

        let param = [];
        let result = [];

        if (signature) {
            const replaceType = t => {
                if (t.startsWith("ext")) { t = "externref"; }
                else if (t.startsWith("fun")) { t = "funcref"; }
                return `${t}`;
            }

            const convertSign = t => {
                return t.split(".").map(replaceType);
            }

            path = path.replace(signature.at(0), "");
            param = convertSign(signature.at(1));
            result = convertSign(signature.at(2));
        }

        const pathParts = path.split(".");

        signature = { name, path };
        signature.object = pathParts.at(-2);
        signature.property = pathParts.at(-1);

        switch (tag) {
            case "call":
                signature.type = "func";
                signature.param = param;
                signature.result = result;
                break;

            case "global.get":
                signature.type = "global";
                signature.kind = param[0] || "ext";
                if (pathParts.length > 3) {
                    signature.type = "externref"
                }
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

        return signature;
    }

    generateHead() {
        const functions = [];
        const globals = [];

        this.externrefs = [null];
        this.texts = [];

        const body = this.body.concat(
            WatModule.TEMPLATE.stringFromCharCode()
        )

        Array
            .from(body.matchAll(/\((.[^\s]*)\s+(\$self([\.a-zA-Z0-9\+\_\<\>\[\]\/\:]*))/g))
            .map(m => Object({ tag: m[1], signature: this.desugar_path(m[2], m[1]), at: m.index }))
            .filter(m => false === this.importBlocks.some(b => b.includes(` ${m.signature.name} `)))
            .forEach(m => {
                switch (m.signature.type) {
                    case "func":
                        functions.push(this.create_function_importer(m.signature));
                        break;

                    case "global":
                        globals.push(this.create_global_importer(m.signature));
                        break;

                    case "externref":
                        this.externrefs.push(this.handle_externref_request(m.signature));
                        break;
                }
            });

        Array
            .from(this.body.replaceAll(/\\\"/g, "*:*").matchAll(/\(text\s+\"(.[^\"]*)\"\)/gm))
            .map(m => Object({ block: m[0].replaceAll("*:*", '\\"'), length: m[1].length, text: m[1].replaceAll("*:*", "\"") }))
            .filter(m => false === this.texts.some(t => t.block === m.block))
            .forEach(m => this.texts.push(m))
            ;

        this.texts.sort((a, b) => b.length - a.length);

        let text = "💚 özgür ...";
        let buffers = [Buffer.from(text)];
        let lastOffset = buffers[0].byteLength;

        let extindex = this.externrefs.length;

        this.texts.forEach(t => {
            let ccodes = t.text.split("").map(c => c.charCodeAt());
            let length = ccodes.length * 4;
            let buffer = new ArrayBuffer(length);
            let writer = new DataView(buffer);

            let offset = -4;
            ccodes.forEach(c => {
                writer.setUint32(offset += 4, c + 0xffff, true);
            });

            offset = text.indexOf(t.text);
            if (offset === -1) {
                offset = lastOffset;
                lastOffset += length;
                buffers.push(Buffer.from(buffer));
                text = text + t.text;
                t.extindex = ++extindex;
                this.externrefs.push(t)
            }
            else {
                t.extindex = this.texts.find(b => b.text.includes(t.text)).extindex;
            }

            t.offset = offset;
            t.length = length;
        });

        this.texts.forEach(t => {
            this.body = this.body.replaceAll(
                t.block, `(table.get $wat4wasm (i32.const ${t.extindex})) (; ${t.text.replaceAll(/\s+/g, " ").substring(0, 25)} ;)`
            );
        });

        this.textBuffer = Buffer.concat(buffers);
        this.head = Array(functions.sort(), globals.sort()).flat().filter((c, i, t) => t.lastIndexOf(c) === i).join("\n");
    }

    get $wat4wasm_import() {
        return this.head;
    }

    toString() {
        this.body = String(`
            ${this.importBlocks.join("\n\n\t")}
            ${this.typeBlocks.join("\n\n\t")}
            ${this.globalBlocks.join("\n\n\t")}
            ${this.memoryBlocks.join("\n\n\t")}
            ${this.tableBlocks.join("\n\n\t")}
            ${this.elemBlocks.join("\n\n\t")}
            ${this.funcBlocks.join("\n\n\t")}
            ${this.dataBlocks.join("\n\n\t")}
            ${this.otherBlocks.join("\n\n\t")}
        `);

        this.generateHead()

        return `(module
            ${this.$wat4wasm_import}
            ${this.body}
            ;; $wat4wasm 
            ${this.$wat4wasm_func}
            ${this.$wat4wasm_memory}
            ${this.$wat4wasm_global}
            ${this.$wat4wasm_table}
            ${this.$wat4wasm_elem}
            ${this.$wat4wasm_data}
            ${this.$wat4wasm_start}            
        )`.trim();
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
