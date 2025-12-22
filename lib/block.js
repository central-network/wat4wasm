import { WatSignature } from "./signature.js";
import { TYPES } from "./types.js";

export class WatBlock {
    constructor(parsed) {
        Object.defineProperty(this, "raw", {
            value: parsed.raw || ""
        });

        let rawContent = parsed.raw.substring(
            parsed.raw.indexOf(" "),
            parsed.raw.lastIndexOf(")")
        ).trim();

        this.op = parsed.op;

        const dotIndex = (this.op || "").indexOf(".");
        if (dotIndex > -1) {
            this.blockTag = this.op.substring(0, dotIndex);
            this.blockSubTag = this.op.substring(dotIndex + 1);
        } else {
            this.blockTag = this.op;
            this.blockSubTag = null;
        }

        // Analysis of Arguments for $name and contentType
        let args = parsed.args || [];

        Object.defineProperty(this, "importPath", {
            value: parsed.importPath,
            enumerable: parsed.hasImportPath
        });

        if (parsed.hasImportPath) {
            rawContent = rawContent.substring(
                rawContent.indexOf("(")
            ).trim();
        }

        Object.defineProperty(this, "blockSubTag", {
            value: this.blockSubTag,
            enumerable: !!this.blockSubTag
        });

        this.$name = "";
        this.contentType = "";
        this.extraArgs = [];

        if (rawContent.startsWith("$") && args[0].startsWith("$")) {
            this.$name = args.splice(0, 1).at(0);
            rawContent = rawContent.substring(this.$name.length).trim();
        }

        let initialSize = undefined;
        let maximumSize = undefined;
        let hasSizeDefinition = false;
        let hasMaximumSize = false;
        let isSizeDefinedBefore = false;
        let waitingDecimalCount = NaN;
        let willWaitDecimal = this.blockSubTag === "const";
        let simdType;
        let constantValues = [];

        if (this.blockSubTag === "const") {

            if (this.isSimdType(args[0])) {
                simdType = args.splice(0, 1)[0];
                waitingDecimalCount = this.decimalCountFor(simdType);
                rawContent = rawContent.substring(simdType.length).trim();
            } else {
                simdType = "";
                waitingDecimalCount = this.decimalCountFor(this.blockTag)
            }

            if (waitingDecimalCount === args.filter(a => !isNaN(a)).length) {
                constantValues = args.splice(0, args.length).map(Number);
            }
        }

        args.forEach((arg, i) => {

            if (this.isType(arg)) {
                // Assuming type atoms act as contentType (like result type)
                this.contentType = arg;
                delete args[i];
                if ((i === args.length - 1) && rawContent.endsWith(arg)) {
                    rawContent = rawContent.substring(0, rawContent.length - arg.length).trim()
                }
                return;
            }

            if (!isNaN(arg)) {

                arg = +arg;

                if (Number.isInteger(arg)) {

                    if (typeof initialSize === "undefined") {
                        initialSize = arg;
                        hasSizeDefinition = true;
                        delete args[i];
                    }
                    else if (typeof maximumSize === "undefined") {
                        maximumSize = arg;
                        hasMaximumSize = true;
                        delete args[i];
                    }
                    else if (isSizeDefinedBefore) {
                        delete args[i];

                        this.extraArgs.push(initialSize);
                        this.extraArgs.push(maximumSize);

                        initialSize = undefined;
                        maximumSize = undefined;
                        hasSizeDefinition = false;
                        hasMaximumSize = false;
                        isSizeDefinedBefore = true;
                    }

                    this.extraArgs.push(arg);
                    return;
                }
            }

            this.extraArgs.push(arg);
        });

        Object.defineProperties(this, {
            initialSize: { value: initialSize, enumerable: !!initialSize },
            maximumSize: { value: maximumSize, enumerable: !!maximumSize },
            hasSizeDefinition: { value: hasSizeDefinition, enumerable: !!hasSizeDefinition },
            hasMaximumSize: { value: hasMaximumSize, enumerable: false },
        });

        Object.defineProperties(this, {
            constantValues: { value: constantValues, enumerable: constantValues.length },
        });

        Object.defineProperty(this, "contentType", {
            value: this.contentType || "",
            enumerable: !!this.contentType
        });

        Object.defineProperty(this, "extraArgs", {
            value: this.extraArgs,
            enumerable: !!this.extraArgs.length
        });

        // Name Metadata
        this.namePath = "";
        this.nameSig = "";

        if (this.$name) {
            // Strip $
            let rawName = this.$name.substring(1);

            // Check for signature part <...>
            // It might be anywhere? Usually at end or middle.
            // User example: $self.console.log<i32.ext>ext
            // The >ext part is also part of sig?
            // User mapped `$name` -> `$self.console.log<i32.ext>ext`
            // `namePath` -> `self.console.log`
            // `nameSig` -> `<i32.ext>ext`

            const ltIndex = rawName.indexOf("<");
            if (ltIndex > -1) {
                this.namePath = rawName.substring(0, ltIndex);
                this.nameSig = rawName.substring(ltIndex);
                // "suffix" after > is part of nameSig in user example
            } else {
                this.namePath = rawName;
            }
        }

        Object.defineProperty(this, "nameSig", {
            value: this.nameSig || "",
            enumerable: !!this.nameSig
        });

        Object.defineProperty(this, "namePath", {
            value: this.namePath,
            enumerable: this.namePath.length
        });

        let selfPath = "";
        let selfDescKey = "";

        if (this.namePath.startsWith("self")) {
            [selfPath, selfDescKey = "value"] = this.namePath.split(/[^\w\.\:]/).filter(Boolean);
        }

        Object.defineProperties(this, {
            hasSelfPath: { value: !!selfPath, enumerable: true },
            selfPath: { value: selfPath, enumerable: !!selfPath },
            selfDescKey: { value: selfDescKey, enumerable: !!selfPath },
        });

        Object.defineProperty(this, "$name", {
            value: this.$name,
            enumerable: this.$name.length
        });

        // Analysis of Children
        const children = parsed.children || []; // These are raw objects from parser {op, args...}
        this.blockSig = [];

        let rawHeaders = "";
        children.forEach((child, i) => {
            if (child.op === "param" || child.op === "result" || child.op === "type" || child.op === "local") {
                if (rawContent.startsWith(child.raw)) {
                    rawHeaders = `${rawHeaders} ${child.raw}`.trim();
                    rawContent = rawContent.substring(child.raw.length).trim();
                }
                this.blockSig.push(child);
                delete children[i];
            }
        });

        Object.defineProperty(this, "blockSig", {
            value: this.blockSig,
            enumerable: this.blockSig.length
        });

        Object.defineProperty(this, "children", {
            value: children.filter(Boolean),
            enumerable: false
        });

        Object.defineProperty(this, "args", {
            value: args.filter(Boolean),
            enumerable: args.filter(Boolean).length
        });

        Object.defineProperty(this, "quotedText", {
            value: parsed.quotedText,
            enumerable: !!parsed.quotedText.length
        });

        Object.defineProperty(this, "toString", {
            value: function () { return this.raw; }
        });

        Object.defineProperty(this, "rawContent", {
            value: rawContent, enumerable: true
        });

        Object.defineProperty(this, "rawHeaders", {
            value: rawHeaders, enumerable: true
        });
    }

    isType(token) {
        // Basic check for common WASM types or 'ext' alias
        return TYPES.isKnown(token) || ["ext", "fun"].includes(token);
    }

    isSimdType(token) {
        // Basic check for common WASM types or 'ext' alias
        return TYPES.isSimdType(token);
    }

    decimalCountFor(token) {
        // Basic check for common WASM types or 'ext' alias
        return TYPES.decimalCount(token);
    }

    // Helper to get formatted blockSig string
    get blockSigString() {
        return this.blockSig.map(c => c.raw).join(" ");
    }

    // Helper to get formatted blockContent string
    get blockContentString() {
        return this.children.map(c => c.raw).join(" ");
    }

    generateImportCode() {
        // Only for $self names
        if (!this.$name || !this.namePath.startsWith("self.")) return null;

        let kind = "func";
        // Determine kind based on blockTag
        if (this.op === "global.get" || this.op === "global" || this.op === "ref.extern") {
            kind = "global";
        }
        // ref.func is func

        // Parse path: self.console.log -> "console", "log"
        const cleanPath = this.namePath.substring(5); // remove "self."
        const parts = cleanPath.split(".");
        let moduleName = "env";
        let fieldName = cleanPath;

        if (parts.length >= 2) {
            moduleName = parts[0];
            fieldName = parts.slice(1).join(".");
        } else {
            // self.foo -> module "self" or "env"? 
            // Let's assume module=self if top level? Or env?
            // User didn't specify, sticking to env for single vals or self?
            // "self" in JS usually means global scope, so maybe empty module is not allowed.
            // Let's default to logic: self.X -> import "self" "X"? 
            // Or maybe "env" is safer for simple globals.
            // User example: import "console" "log" -> self.console.log
            // So module is the PROPERTY on self.
        }

        let importName = this.$name;
        let signature = "";

        if (kind === "func") {
            // Function Signature Logic
            const sig = new WatSignature();
            if (this.nameSig) {
                sig.fromNameSig(this.nameSig);
            } else if (this.blockSig.length > 0) {
                // Deduce from block sig and UPDATE NAME
                sig.fromBlockSig(this.blockSig);
                // Update name with suffix
                const suffix = sig.toNameSig();
                importName = "$" + this.namePath + suffix;
            } else {
                // No sig info? Default to empty? or void?
                // Depending on usage? 
                // (call $self.foo) might implied (param) (result)
            }
            signature = `(func ${importName} ${sig.toBlockSig()})`.replace(/\s+\)/g, ")");
        } else {
            // Global Logic
            let type = "externref";
            if (this.contentType) {
                type = TYPES.toLong(this.contentType);
            }
            // (global.get $self.foo i32) -> type comes from args?
            // In constructor, we scan args for types and put in contentType.

            // Global imports usually don't have the <sig> suffix in name?
            // User example: (global $self.console.log externref)
            // But if $name has sig? (ref.func $self.foo<i32>) is func.
            // If global reference is typed? 
            // Usually global names are just names.

            signature = `(global ${importName} ${type})`;
        }

        return `(import "${moduleName}" "${fieldName}" ${signature})`;
    }
}
