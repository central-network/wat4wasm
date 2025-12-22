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

    constructor(raw = "(nop)", begin = 0, end = begin + raw.length, rootSource = raw) {
        assign(this, "rootSource", rootSource)
        assign(this, "begin", begin)
        define(this, "end", end)
        assign(this, "raw", raw)
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

    static fromRaw(source) {
        if (this.isBlock(source) === false) {
            throw new RangeError(`Block is NOT valid: ${source}`);
        }

        return Reflect.construct(
            this.findClass(source), arguments
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
            watRemain = raw,
            $name = "",
            alias = { $name, toString: function () { return `${this.$name}` } };

        if (watRemain.trim().startsWith(`(${this.constructor.tag}`)) {
            watRemain = watRemain.substring(
                watRemain.indexOf(" "),
                watRemain.lastIndexOf(")")
            ).trim();
        }

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

    extractBlocks() {
        let raw = this.source,
            begin,
            watRemain = raw,
            block, blocks = [];

        let starter = `(${this.constructor.tag}`;
        if (watRemain.trim().startsWith(starter)) {
            watRemain = watRemain.substring(
                watRemain.indexOf(starter) + starter.length,
                watRemain.lastIndexOf(")")
            ).trim();
        }

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
            watRemain = raw,
            quote, quotes = [];

        if (watRemain.trim().startsWith(`(${this.constructor.tag}`)) {
            watRemain = watRemain.substring(
                watRemain.indexOf(" "),
                watRemain.lastIndexOf(")")
            ).trim();
        }

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

WatBlock.register(
    class WatModule extends WatBlock {
        static tag = "module"

        get headSegments() {
            return Array()
                .concat(this.importBlocks)
                .flat().filter(Boolean);
        }

        get bodySegments() {
            return Array()
                .concat(this.globalDefinitions)
                .concat(this.memoryDefinitions)
                .concat(this.tableDefinitions)
                .concat(this.elemSegments)
                .concat(this.funcBlocks)
                .concat(this.dataSegments)
                .concat(this.startCall)
                .concat(this.unknownBlocks)
                .flat().filter(Boolean);
        }

        reset() {
            assign(this, "importBlocks", new Array)
            assign(this, "globalDefinitions", new Array)
            assign(this, "memoryDefinitions", new Array)
            assign(this, "tableDefinitions", new Array)
            assign(this, "elemSegments", new Array)
            assign(this, "funcBlocks", new Array)
            assign(this, "dataSegments", new Array)
            assign(this, "startCall", null)
            assign(this, "unknownBlocks", new Array)

            let blocks = this.extractBlocks();

            if (this.isEmpty() === false) {
                throw new Error(`Module block has non-block expression: \x1b[31m${this.source}\x1b[0m`);
            }

            while (blocks.length) {
                const [raw] = blocks.splice(0, 1);
                const { tag } = WatBlock.parseTag(raw);

                const block = WatBlock.fromRaw(raw);

                switch (tag) {
                    case "import": this.importBlocks.push(block); break;
                    case "global": this.globalDefinitions.push(block); break;
                    case "memory": this.memoryDefinitions.push(block); break;
                    case "table": this.tableDefinitions.push(block); break;
                    case "elem": this.elemSegments.push(block); break;
                    case "func": this.funcBlocks.push(block); break;
                    case "data": this.dataSegments.push(block); break;
                    case "start": this.startCall = block; break;
                    default: this.unknownBlocks.push(block); break;
                }
            }
        }

        toString() {
            return (`
                (module
                    ${this.headSegments.map(s => s.toString().trim()).filter(Boolean).join("\n\n\t")}
                    ${this.bodySegments.map(s => s.toString().trim()).filter(Boolean).join("\n\n\t")}
                    ${this.footSegments.map(s => s.toString().trim()).filter(Boolean).join("\n\n\t")}
                )
            `);
        }
    }
);

WatBlock.register(class WatMemory extends WatBlock {
    static tag = "memory"
    static ops = [
        class extends this {
            static tag = "memory.init";
            static #template = "([tag][dot][op][space][?alias][block][block][block])"
            static #consumes = 3;
            static #produces = 0;
        }
    ]
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
                assign(this, "variable", WatBlock.fromRaw(blocks[0]));
            }

            if (this.isEmpty() === false) {
                throw new Error(`Import block has non-block expression: \x1b[31m${this.source}\x1b[0m`);
            }
        }
    }
)

WatBlock.register(
    class WatImport extends WatBlock {
        static tag = "include"

        content = "";

        toString() {
            return this.content.toString();
        }

        reset() {
            const [path] = this.extractQuotes();
            assign(this, "path", path);

            const content = fs.readFileSync(path, "utf8").trim();
            if (content) {
                this.content = WatBlock.fromRaw(content)
                console.log(this.content)
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
        const wp = WatBlock.fromRaw(wat);

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
