
import { TYPES } from "./types.js";

export class WatSignature {
    constructor() {
        this.params = [];
        this.results = [];
    }

    /**
     * Parses from "nameSig" format: <p1.p2>r1.r2
     * Example: <i32.ext>ext
     */
    fromNameSig(sigStr) {
        // Remove < and >
        // Format <params>results
        // If no <, assume it's just results? or error?
        // User example: <i32.ext>ext

        const splitIdx = sigStr.indexOf(">");
        let paramStr = "";
        let resultStr = "";

        if (splitIdx > -1) {
            // has <...>
            const openIdx = sigStr.indexOf("<");
            if (openIdx > -1) {
                paramStr = sigStr.substring(openIdx + 1, splitIdx);
                resultStr = sigStr.substring(splitIdx + 1);
            } else {
                // Invalid format?
            }
        } else {
            // maybe just <params>? <i32>
            if (sigStr.startsWith("<") && sigStr.endsWith(">")) {
                paramStr = sigStr.slice(1, -1);
            } else {
                // assume just results? or just params?
                // Context dependent. Let's assume params if wrapped in <>, else results?
                // Use safe defaults.
            }
        }

        this.params = paramStr ? paramStr.split(".").filter(Boolean).map(TYPES.toLong) : [];
        this.results = resultStr ? resultStr.split(".").filter(Boolean).map(TYPES.toLong) : [];
        return this;
    }

    /**
     * Parses from "blockSig" array of parsed objects (from WatBlock.blockSig)
     * Example: [(param i32 ext), (result ext)]
     * Also handles: (func (param $x i32))
     */
    fromBlockSig(blockSigChildren) {
        this.params = [];
        this.results = [];

        for (const child of blockSigChildren) {
            if (child.op === "param") {
                // args might contain names like $label
                // (param $label i32) -> i32
                // (param i32 i32) -> i32, i32
                for (const arg of child.args) {
                    if (arg.startsWith("$")) continue; // skip param names
                    this.params.push(TYPES.toLong(arg));
                }
            } else if (child.op === "result") {
                for (const arg of child.args) {
                    this.results.push(TYPES.toLong(arg));
                }
            } else if (child.op === "type") {
                // (type $t) - Reference to type index/alias
                // We might preserve this or resolve it? 
                // For now, store it? But signature usually implies explicit types.
                // TODO: Handle type references
            }
        }
        return this;
    }

    /**
     * Converts to "blockSig" string format
     * Example: (param i32 externref) (result externref)
     */
    toBlockSig() {
        const p = this.params.length ? `(param ${this.params.join(" ")})` : "";
        const r = this.results.length ? `(result ${this.results.join(" ")})` : "";
        return `${p} ${r}`.trim();
    }

    /**
     * Converts to "nameSig" string format
     * Example: <i32.ext>ext
     * Uses short types
     */
    toNameSig() {
        const p = this.params.map(TYPES.toShort).join(".");
        const r = this.results.map(TYPES.toShort).join(".");
        // If params empty, still <>? < >ext?
        // User example: Math.random<>f32 implies <>
        return `<${p}>${r}`;
    }
}
