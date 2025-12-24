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

    fixBlockKeyword(keyword, filter = {}) {
        if (filter.$name) {
            keyword = `${keyword} ${filter.$name}`;
        }

        if (keyword.startsWith("(") === false) {
            return `(${keyword}`;
        }
        return keyword;
    },

    getTableOperator(block) {
        let [match, $name = "", initial = "", maximum = "", kindof = "externref"] = block.toString().match(/\(table(?:\s*(.[^\s]*)?)\s+(\d+)(?:\s*(\d+)?)\s+(externref|funcref)\)/) ?? [];

        initial = parseInt(initial);
        maximum = parseInt(maximum);

        return {
            $name, initial, maximum, kindof, grow: function (count = 1) {
                return {
                    newTableBlock: `(table ${[$name, initial + count, maximum, kindof].filter(Boolean).join(" ").trim()})`,
                    getTableBlock: `(table.get ${[$name, `(i32.const ${initial})`].join(" ").trim()})`
                };
            }
        };
    },

    hasBlock(raw, keyword, filter) {
        keyword = this.fixBlockKeyword(keyword, filter);
        return raw.includes(keyword);
    },

    lastBlockOf(raw, keyword, filter) {
        keyword = this.fixBlockKeyword(keyword, filter);

        let begin = raw.lastIndexOf(keyword);
        let block = this.blockAt(raw, begin);

        return block && Object({
            block,
            begin, end: begin + block.length,
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
        })
    }
}