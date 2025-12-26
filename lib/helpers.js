import wat4beauty from "wat4beauty";
import fs from "fs";
import cp from "child_process";

const helpers = {
    readFileAsDataHex(path) {
        const data = fs.readFileSync(path, "hex").replaceAll(/(..)/g, `\\$1`);
        const size = Buffer.alloc(4);
        size.writeUint32LE(data.length / 3);
        return size.toString("hex").replaceAll(/(..)/g, `\\$1`).concat(data);
    },

    copyFileToTemp(path, name = path.split('/').pop()) {

        if (name.startsWith(".")) {
            name = path
                .split(".").reverse()
                .slice(1)
                .reverse().join(".")
                .concat(name)
                .split("/")
                .pop()
                ;
        }

        fs.copyFileSync(path, `/tmp/${name}`);
        return `/tmp/${name}`;
    },

    spawnSync(command, argv) {
        return cp.spawnSync(command, argv, { stdio: "inherit" });
    },

    blockAt(raw, begin) {
        raw = raw.toString();

        if ((begin === -1) || !(raw = raw.substring(begin))) {
            return "";
        }

        let maskUsed = raw.includes("\\)");
        if (maskUsed) {
            maskUsed = `__RAND${Math.random()}__`;
            raw = raw.replaceAll("\\)", maskUsed);
        }

        let end = begin = 0, block = raw;

        end = raw.indexOf(")", end);
        block = raw.substring(begin, ++end);

        while (block && (
            block.split("(").length !==
            block.split(")").length)
        ) {
            end = raw.indexOf(")", end);
            block = raw.substring(begin, ++end);
        }

        if (maskUsed && block) {
            block = block.replaceAll(maskUsed, "\\)");
        }

        return block;
    },

    prepend(raw, block) {
        raw = raw.toString();
        block = block.toString().trim().concat(" ");

        if (raw.startsWith("(module")) {
            return String(`(module\n${block}\n`).concat(
                raw.substring("(module".length).trimStart()
            )
        }

        let begin;
        begin = raw.indexOf("(", 1);

        if (raw.substring(begin).startsWith("(param")) { begin = raw.indexOf("(", ++begin); }
        if (raw.substring(begin).startsWith("(local")) { begin = raw.indexOf("(", ++begin); }
        if (raw.substring(begin).startsWith("(result")) { begin = raw.indexOf("(", ++begin); }
        if (raw.substring(begin).startsWith("(type")) { begin = raw.indexOf("(", ++begin); }

        if (begin !== -1) {
            return raw.substring(0, begin).concat(block).concat(raw.substring(begin))
        }

        const blockparts = raw.split(/\s+/).filter(Boolean);
        if (blockparts.length === 1) {
            return this.append(raw, block);
        }

        const maybe$name = blockparts.at(1);
        if (maybe$name.startsWith("$")) {
            if (maybe$name.endsWith(")")) {
                return this.append(raw, block);
            }
        }

        const [firstLine, ...restLines] = raw.split(/\n/g);
        return [firstLine, block, ...restLines].join("\n");
    },


    append(raw, block) {
        raw = raw.toString();
        return raw.substring(0, raw.lastIndexOf(")")).concat(`${block || ''}\n)`);
    },


    findQuotedTexts(rawBlock, maxcount = -1) {
        let maskUsed = rawBlock.includes('\\"');
        if (maskUsed) {
            maskUsed = `__RAND${Math.random()}__`;
            rawBlock = rawBlock.replaceAll('\\"', maskUsed);
        }

        let texts = [];
        let begin = rawBlock.indexOf(`"`);
        let end = rawBlock.indexOf(`"`, begin + 1);

        while (maxcount-- && begin !== -1) {
            texts.push(rawBlock.substring(begin + 1, end));
            begin = rawBlock.indexOf('"', end + 1);
            end = rawBlock.indexOf(`"`, begin + 1);
        }

        if (maskUsed) {
            texts = texts.map(t => t.replaceAll(maskUsed, "\\)"));
        }

        return texts;
    },

    findQuotedText(rawBlock) {
        return this.findQuotedTexts(rawBlock, 1).at(0);
    },

    encodeText: TextEncoder.prototype.encode.bind(new TextEncoder),
    encodeString: str => Array.from(str).map(c => c.charCodeAt()),

    fix$Name(keyword, self = false) {
        if (keyword.startsWith("$") === false) {
            return `$${keyword}`;
        }

        if (self && keyword.startsWith("$self") === false) {
            return `$self.${keyword.substring(1)}`;
        }

        return keyword;
    },

    fixBlockKeyword(keyword, filter = {}) {
        if (filter.$name) {
            keyword = `${keyword} ${filter.$name}`;
        }

        if (filter.name) {
            keyword = `${keyword} $${filter.name}`;
        }

        if (keyword.startsWith("(") === false) {
            return `(${keyword}`;
        }
        return keyword;
    },

    getBlockKeyword(block) {
        let keyword = block;

        if (keyword.startsWith("(") === true) {
            keyword = keyword.substring(1);
        }

        let i = 0;
        while (keyword.at(i++).match(/[a-z0-9\_\.]/));;
        return keyword.substring(0, i);
    },

    getBlockRootTag(block) {
        return this.getBlockKeyword(block).split(".").at(0);
    },

    getBlockRootTagType(block) {
        return this.getBlockRootTag(block).match(/(i32|f32|i64|f64)/)?.at(0) || "ext";
    },

    getTableOperator(block) {
        let [match, $name = "", initial = "", maximum = "", kindof = "externref"] = block.toString().match(/\(table(?:\s*(.[^\s]*)?)\s+(\d+)(?:\s*(\d+)?)\s+(externref|funcref)\)/) ?? [];

        initial = parseInt(initial);
        maximum = parseInt(maximum);

        return {
            $name, initial, maximum, kindof,
            grow: function (count = 1) {
                return {
                    newTableBlock: `(table ${[$name, initial + count, maximum, kindof].filter(Boolean).join(" ").trim()})`,
                    getTableBlock: `(table.get ${[$name, `(i32.const ${initial})`].join(" ").trim()})`
                };
            }
        };
    },

    abstract(str, max = 15) {
        str = `${str || ''}`.replaceAll(/\s+/g, ' ').replaceAll(/\s+\)/g, ")");
        if (str.length < max) return str;
        return `${str.substring(0, max / 3)} ... ${str.substring(str.length - max / 3)}`
    },

    beautify: wat4beauty,

    createTableGetter(index, kindof = "extern") {
        return `(ref.null (;${index};) ${kindof})`;
    },

    referenceId() {
        return "0x" + crypto.randomUUID().replace(/\-/g, "");
    },

    hasBlock(raw, keyword, filter) {
        keyword = this.fixBlockKeyword(keyword, filter);
        return raw.includes(keyword);
    },

    MaskSet: class MaskSet extends Map {

        constructor(raw) {
            Reflect.defineProperty(super(), "input", { value: raw, writable: true })
        }

        mask(block) {
            if (!block.uuid) {
                throw new Error(`Raw block needs uuid: ${block}`);
            };

            if (this.has(block.uuid) === false) {
                this.set(block.uuid, block);
            }

            const rawRange = this.input.substring(
                block.begin, block.end
            );

            if (block.toString() !== rawRange) {
                console.error({ block, rawRange })
                throw new Error(`Raw block pointer range is not matched!`);
            };

            this.input = this.input
                .substring(0, block.begin)
                .concat(block.uuid)
                .concat(this.input.substring(block.end))
                ;
        }

        lastBlockOf(keyword, filter) {
            return helpers.lastBlockOf(this.input, keyword, filter);
        }

        hasBlock(keyword, filter) {
            return helpers.hasBlock(this.input, keyword, filter);
        }

        update(oldBlock, newBlock) {
            this.set(oldBlock.uuid, newBlock);
        }

        restore() {
            return this.restoreInto(this.input);
        }

        restoreInto(raw) {
            const masks = Array.from(this.keys());
            const uuid = masks.find(uuid => raw.includes(uuid));

            if (uuid) {
                const block = this.get(uuid);
                raw = raw.replaceAll(uuid, block.toString());
                return this.restoreInto(raw);
            }

            return raw;
        }
    },

    assignBlockProperties(raw, block, begin) {
        let $name = block.split(/[^a-z0-9A-Z\.\<\>\/\_\+\-\`\[\]\$\=\#\!]/g).filter(Boolean).at(1)
        if ($name.startsWith("$") === false) {
            $name = "";
        }

        return block && Object.defineProperties({
            block,
            begin,
            uuid: crypto.randomUUID(),
            end: begin + block.length,
            $name: $name,
            toString: function () { return this.block; },
            wrappedRaws: function () {
                return {
                    before: this.input.substring(0, this.begin),
                    after: this.input.substring(this.end)
                }
            },
            maskedRaw: function () { return this.replacedRaw(this.uuid); },
            removedRaw: function () { return this.replacedRaw(""); },
            replacedRaw: function (str) {
                const { before, after } = this.wrappedRaws();
                return before.concat(str.toString()).concat(after);
            },
        }, {
            input: { value: raw },
            indexOf: { value: function () { return this.block.indexOf(...arguments) } },
            includes: { value: function () { return this.block.includes(...arguments) } },
            lastIndexOf: { value: function () { return this.block.lastIndexOf(...arguments) } },
            split: { value: function () { return this.block.split(...arguments) } },
            at: { value: function () { return this.block.at(...arguments) } },
            length: { get: function () { return this.block.length } },
            charCodeAt: { value: function () { return this.block.charCodeAt(...arguments) } },
            concat: { value: function () { return this.block.concat(...arguments) } },
            startsWith: { value: function () { return this.block.startsWith(...arguments) } },
            endsWith: { value: function () { return this.block.endsWith(...arguments) } },
            substring: { value: function () { return this.block.substring(...arguments) } },
            replace: { value: function () { return this.block.replace(...arguments) } },
            replaceAll: { value: function () { return this.block.replaceAll(...arguments) } },
            lastBlockOf: { value: function () { return helpers.lastBlockOf(this.block, ...arguments) } },
            [Symbol.toPrimitive]: { value: function () { return this.block; } },
        })
    },

    lastBlockOf(raw, keyword, filter) {
        keyword = this.fixBlockKeyword(keyword, filter);
        raw = raw.toString();

        let begin = raw.lastIndexOf(keyword);
        return this.parseBlockAt(raw, begin);
    },

    parseBlockAt(raw, begin) {
        return this.assignBlockProperties(raw, this.blockAt(raw, begin), begin);
    },

    parseFirstBlock(raw) {
        raw = raw.toString();
        return this.parseBlockAt(raw, raw.indexOf("(", 1));
    }
};

export default helpers;