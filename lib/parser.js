import { WatBlock } from "./block.js";

/**
 * Wat4Wasm S-Expression Parser
 * 
 * Goals:
 * - Robustly detect balanced parentheses (blocks).
 * - Handle strings with escape characters and newlines correctly.
 * - Support nested blocks.
 * - Support custom sugar tokens.
 */

let i = 0;
class Block {

    watParser = undefined;

    constructor(watParser, watBlock, raw, begin, end) {
        Object.defineProperties(
            Object.assign(this, { raw, begin, end, watBlock }),
            {
                watParser: { value: watParser },
                watBlock: { value: watBlock, enumerable: true },
            }
        );
    }

    get tagName() { return this.raw.match(/\(([\w\.]+)/).pop() }
    get index() { return this.watParser.blocks.indexOf(this); }
    get WatParser() { return this.watParser.constructor; }

    replace(raw) {
        const { blocks: [block] } = Reflect.construct(this.WatParser, [raw]);

        Reflect.set(
            this.watParser.blocks,
            this.index,
            block
        );
    }

    remove() { this.replace(""); }
}

export class WatParser {

    blocks = [];
    /**
     * Scans and parses all top-level S-expressions in the source.
     * @returns {Array} Array of parsed objects { op, args: [], children: [] }
     */
    parse() {
        const expressions = [];
        let index = 0;

        while (index < this.length) {
            // Skip whitespace
            if (/\s/.test(this.source[index])) {
                index++;
                continue;
            }

            // Skip comments
            // ;; ...
            if (this.source[index] === ';' && this.source[index + 1] === ';') {
                index += 2;
                while (index < this.length && this.source[index] !== '\n') index++;
                continue;
            }
            // (; ... ;)
            if (this.source[index] === '(' && this.source[index + 1] === ';') {
                const end = this.findBalancedParen(index);
                if (end !== -1) index = end + 1;
                else index = this.length; // error or end
                continue;
            }

            if (this.source[index] === '(') {
                const end = this.findBalancedParen(index);
                if (end === -1) {
                    console.error("Unbalanced paren at", index);
                    break;
                }
                const fullContent = this.source.substring(index, end + 1);
                const watBlock = this.parseExpression(fullContent);

                this.addBlock(new Block(this, watBlock, fullContent, index, end + 1));
                expressions.push(watBlock);

                index = end + 1;
            } else {
                // Unexpected atom at top level? Or just skip.
                // WAT allows top level text but mostly it's (module ...)
                index++;
            }
        }
        return expressions;
    }

    blockAt(index) { return this.blocks.at(index); }
    addBlock(block) { return this.blocks.push(block) - 1; }

    /**
     * Parses a single S-expression string into structured data.
     * Input: "(op arg1 "string" (child))"
     * Output: { op: "op", args: ["arg1", "\"string\""], children: [{op:"child"...}] }
     */
    parseExpression(sexpr) {
        // Strip outer parens
        const content = sexpr.substring(1, sexpr.length - 1).trim();
        if (!content) return { op: null, args: [], children: [], raw: sexpr }; // Added raw

        const tokens = [];
        let cursor = 0;
        const len = content.length;

        while (cursor < len) {
            const char = content[cursor];

            if (/\s/.test(char)) {
                cursor++;
                continue;
            }

            if (char === '"') {
                // Parse String
                let end = cursor + 1;
                while (end < len) {
                    if (content[end] === '\\') end++; // skip escape
                    else if (content[end] === '"') break;
                    end++;
                }
                tokens.push({ type: 'string', value: content.substring(cursor, end + 1) });
                cursor = end + 1;
            }
            else if (char === '(') {
                // Nested Expression - need to find balanced paren *within content*
                // We can clone findBalancedParen logic or use a simpler counter since we are already inside a valid block?
                // But strings might contain parens.
                let depth = 1;
                let subEnd = cursor + 1;
                let inStr = false;

                while (subEnd < len && depth > 0) {
                    const c = content[subEnd];
                    if (inStr) {
                        if (c === '\\') subEnd++;
                        else if (c === '"') inStr = false;
                    } else {
                        if (c === '"') inStr = true;
                        else if (c === '(') depth++;
                        else if (c === ')') depth--;
                    }
                    if (depth > 0) subEnd++;
                }
                // subEnd is now at the closing ')'
                const subExpr = content.substring(cursor, subEnd + 1);
                const watBlock = this.parseExpression(subExpr);
                this.addBlock(new Block(this, watBlock, subExpr, cursor, subEnd + 1));

                tokens.push({ type: 'expr', value: watBlock });
                cursor = subEnd + 1;
            }
            else {
                // Atom (bareword, number, $var)
                let end = cursor;
                while (end < len && !/\s|\(|\)/.test(content[end])) {
                    end++;
                }
                tokens.push({ type: 'atom', value: content.substring(cursor, end) });
                cursor = end;
            }
        }

        if (tokens.length === 0) return { op: null, args: [], children: [] };

        // First token is Op (if atom)
        let op = null;
        let startIdx = 0;
        if (tokens[0].type === 'atom') {
            op = tokens[0].value;
            startIdx = 1;
        }

        const args = [];
        const children = [];
        let quotedText = "";
        let importPath = { root: "", prop: "" };
        let hasImportPath = false;

        for (let i = startIdx; i < tokens.length; i++) {
            if (tokens[i].type === 'expr') {
                children.push(tokens[i].value);
            } else {
                const value = tokens[i].value.trim();

                if (value.startsWith("\"") && value.endsWith("\"")) {
                    const begin = value.indexOf("\"") + 1;
                    let end = value.lastIndexOf("\"");

                    if (quotedText === "") {
                        quotedText = value.substring(begin, end);
                        continue;
                    } else {
                        importPath.root = quotedText;
                        importPath.prop = value.substring(begin, end);
                        quotedText = "";
                        hasImportPath = true;
                        continue;
                    }
                }
                args.push(tokens[i].value);
            }
        }

        return new WatBlock(
            Object.defineProperty(
                { op, args, quotedText, importPath, children, hasImportPath },
                "raw", { value: sexpr }
            )
        );
    }

    constructor(source) {
        this.raw = source;
    }

    get raw() {
        console.log(this.watBlocks.map(b => {
            return b.toString()
        }))
        return "";
    }

    set raw(source) {
        Object.defineProperties(this, {
            length: { value: source.length, writable: true, configurable: true },
            source: { value: source, writable: true, configurable: true },
        });

        this.blocks.length = 0;
        this.watBlocks = this.parse();
        this.blocks.sort((a, b) => a.begin - b.begin);
    }

    forEachBlock(callback, filter = {}) {

        if (typeof filter === "string") {
            filter = { tagName: filter }
        }

        else if (typeof filter === "number") {
            filter = { afterBegin: filter }
        }

        let i = this.blocks.length;
        let b = null;
        while (b = this.blockAt(--i)) {

            if (filter.tagName && b.tagName !== filter.tagName) {
                continue;
            }

            if (filter.blockType && b.blockType !== filter.blockType) {
                continue;
            }

            if (filter.afterBegin && b.begin <= filter.afterBegin) {
                continue;
            }

            if (filter.beforeEnd && b.end >= filter.beforeEnd) {
                continue;
            }

            if (callback.call(this, b, i) === -1) {
                break;
            }
        }
    }

    /**
     * Finds the next occurrence of a specific block type.
     * @param {string} blockName - The token to search for after '(', e.g., "include", "module".
     * @param {number} startOffset - Index to start searching from.
     * @returns {object|null} - { start, end, content, innerContent }
     */
    findBlock(blockName, startOffset = 0) {
        // Regex to find '(<blockName>'
        // We need to be careful about word boundaries, but WAT tokens can be complex.
        // Simple approach: find strict string "(blockName" followed by space/boundary.

        // Construct regex for finding the start sequence
        // Escape special regex chars in blockName if any (like $ or .)
        const escapedName = blockName.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
        // Look for '(' followed by name, followed by whitespace or ')' or end of line.
        const regex = new RegExp(`\\(${escapedName}(?=[\\s\\)])`, 'g');

        regex.lastIndex = startOffset;
        const match = regex.exec(this.source);

        if (!match) return null;

        const start = match.index;
        const end = this.findBalancedParen(start);

        if (end === -1) {
            throw new Error(`Unbalanced parenthesis starting at ${start}`);
        }

        const fullContent = this.source.substring(start, end + 1);
        // innerContent removes the outer '(' and ')'
        const innerContent = this.source.substring(start + 1, end);

        return {
            start,
            end: end + 1,
            fullContent,
            innerContent,
            blockName
        };
    }

    /**
     * Finds the matching closing parenthesis for a given opening parenthesis index.
     * skips strings and comments.
     */
    findBalancedParen(startIndex) {
        let depth = 0;
        let inString = false;
        let inComment = false; // ;; comment
        let inBlockComment = false; // (; ;) comment

        for (let i = startIndex; i < this.length; i++) {
            const char = this.source[i];

            // String handling
            if (inString) {
                if (char === '\\') {
                    i++; // skip next char (escape)
                } else if (char === '"') {
                    inString = false;
                }
                continue;
            }

            // Comment handling
            if (inComment) {
                if (char === '\n') {
                    inComment = false;
                }
                continue;
            }

            if (inBlockComment) {
                if (char === ';' && this.source[i + 1] === ')') {
                    inBlockComment = false;
                    i++;
                }
                continue;
            }

            // Start of string
            if (char === '"') {
                inString = true;
                continue;
            }

            // Start of comments
            if (char === ';' && this.source[i + 1] === ';') {
                inComment = true;
                i++;
                continue;
            }
            if (char === '(' && this.source[i + 1] === ';') {
                inBlockComment = true;
                i++;
                continue;
            }

            // Parentheses
            if (char === '(') {
                depth++;
            } else if (char === ')') {
                depth--;
                if (depth === 0) {
                    return i;
                }
            }
        }

        return -1; // Not found
    }
}
