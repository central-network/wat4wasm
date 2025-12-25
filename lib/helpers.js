import wat4beauty from "wat4beauty";
import fs from "fs";
import cp from "child_process";

export default {
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


    findQuotedText(rawBlock) {
        return rawBlock.substring(
            rawBlock.indexOf(`"`) + 1,
            rawBlock.lastIndexOf(`"`)
        );
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
        str = `${str || ''}`.replaceAll(/\s+/g, ' ');
        if (str.length < max) return str;
        return `${str.substring(0, 5)} ... ${str.substring(str.length - 5)}`
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
        mask(block) {
            if (this.has(block.uuid) === false) {
                this.set(block.uuid, block);
            }
            return block.maskedRaw();
        }

        update(oldBlock, newBlock) {
            this.set(oldBlock.uuid, newBlock);
        }

        restoreInto(raw) {
            this.forEach((block, uuid) =>
                raw = raw.replaceAll(uuid, block)
            );
            return raw;
        }
    },

    assignBlockProperties(raw, block, begin) {
        return block && Object.defineProperties(Object({
            block,
            begin,
            uuid: crypto.randomUUID(),
            end: begin + block.length,
            $name: block.split(/\(\w+/, 2).pop().trim().split(/\s+|\)|\(/).filter(Boolean).find((w, i) => !i && w.startsWith("$")) || "",
            toString: () => block,
            wrappedRaws: () => Object({
                before: raw.substring(0, begin),
                after: raw.substring(begin + block.length)
            }),
            maskedRaw: function () { return this.replacedRaw(this.uuid); },
            removedRaw: function () { return this.replacedRaw(""); },
            replacedRaw: function (str) {
                const { before, after } = this.wrappedRaws();
                return before.concat(str.toString()).concat(after);
            },
        }), {
            raw: { value: raw },
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
            [Symbol.toPrimitive]: { value: function () { return this.block; } }
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
    }
}