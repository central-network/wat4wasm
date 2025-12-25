import wat4beauty from "wat4beauty";

export default {
    blockAt(raw, begin) {

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

    append(raw, block) {
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

    lastBlockOf(raw, keyword, filter) {
        keyword = this.fixBlockKeyword(keyword, filter);

        let begin = raw.lastIndexOf(keyword);
        let block = this.blockAt(raw, begin);

        return block && Object.defineProperties(Object({
            block,
            begin,
            end: begin + block.length,
            $name: block.split(keyword).at(1).split(/\s+|\)|\(/).filter(Boolean).find((w, i) => !i && w.startsWith("$")) || "",
            toString: () => block,
            wrappedRaws: () => Object({
                before: raw.substring(0, begin),
                after: raw.substring(begin + block.length)
            }),
            removedRaw: function () {
                return this.replacedRaw("");
            },
            replacedRaw: function (str) {
                const { before, after } = this.wrappedRaws();
                return before.concat(str.toString()).concat(after);
            },
        }), {
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
            [Symbol.toPrimitive]: { value: function () { return this.block; } }
        })
    }
}