export class BlockManager {
    // WebAssembly İsim Karakterleri (Genişletilmiş Tag Regex)
    // a-z, 0-9, nokta, alt çizgi ve tire içerir. 
    // Örn: func, i32.const, memory.init, sub_type
    static TAG_REGEXP = /^[a-z0-9_.\-]+/;

    // WebAssembly İsim (Identifier) Karakterleri
    static NAME_REGEXP = /[a-zA-Z0-9\@\:\*\!\=\?\#\^\&\`<>\|\%\$\.\+-_\/\\]/;

    static TYPE_REGEXP = /^(i32|i64|f32|f64|v128|i32x4|f32x4|externref|funcref|extern|func|ext|fun|anyref|eqref|optref|ref|null|mut)$/;
    static STRING_REGEXP = /^"(.*)"$/;
    static NUMBER_REGEXP = /^-?(\d+|0x[0-9a-fA-F]+|\d*\.\d+(e-?\d+)?)$/;

    /**
     * Bloğu analiz eder.
     */
    static analyze(rawBlock, rootBlock) {
        let core = rawBlock.trim();
        if (!core.startsWith("(") || !core.endsWith(")")) return null;

        // 1. Dış parantezleri soy
        let content = core.slice(1, -1).trim();

        // 2. Etiketi (Tag) Güvenli Tespit Et
        // Regex kullanarak ilk anlamlı kelimeyi alıyoruz.
        const tagMatch = content.match(this.TAG_REGEXP);
        let tag = "";
        let body = "";

        if (tagMatch) {
            tag = tagMatch[0];
            // Tag'den sonraki kısmı body olarak al (boşluk varsa atla)
            body = content.substring(tag.length).trim();
        } else {
            // Eğer tag yoksa (örn: sadece "( )"), boş dönebilir veya hata verebiliriz.
            tag = "unknown";
            body = content;
        }

        const nonNestedChildren = rootBlock || [];
        const children = [];
        const signature = {
            block: { params: [], results: [] },
            inline: { params: [], results: [] }
        };

        // 3. Alt Blokları Bul
        let cursor = 0;
        let cleanBody = "";

        while (cursor < body.length) {
            const char = body[cursor];

            if (char === "(") {
                const childData = this.at(body, cursor);
                if (childData) {
                    const childRaw = childData.block;
                    // Alt bloğun tag'ini de aynı güvenli yöntemle alalım
                    const childContent = childData.content.trim();
                    const childTagMatch = childContent.match(this.TAG_REGEXP);
                    const childTag = childTagMatch ? childTagMatch[0] : "unknown";

                    if (childTag === "param") {
                        signature.block.params.push(childData);
                    } else if (childTag === "result") {
                        signature.block.results.push(childData);
                    } else {
                        // Konsol kirliliğini önlemek için 'raw' verisini gizliyoruz
                        const childObj = Object.assign({
                            tag: childTag,
                            start: childData.start,
                            end: childData.end
                        }, this.analyze(childRaw, nonNestedChildren));

                        Object.defineProperty(
                            childObj, "raw", { value: childRaw });

                        children.push(childObj);
                        nonNestedChildren.push(childObj)
                    }

                    cursor = childData.end;
                    continue;
                }
            }

            cleanBody += char;
            cursor++;
        }

        // 4. Tokenization & Reverse Parsing
        const tokens = this.tokenize(cleanBody);
        const attributes = {
            types: [],
            numbers: [],
            strings: [],
            others: []
        };
        let name = null;
        let nameMeta = null;

        for (let i = tokens.length - 1; i >= 0; i--) {
            const token = tokens[i];

            if (this.TYPE_REGEXP.test(token)) {
                attributes.types.unshift(token);
                continue;
            }
            if (this.NUMBER_REGEXP.test(token)) {
                attributes.numbers.unshift(token);
                continue;
            }
            if (this.STRING_REGEXP.test(token)) {
                attributes.strings.unshift(token.slice(1, -1));
                continue;
            }
            if (token.startsWith("$")) {
                name = token;
                nameMeta = this.analyzeIdentifier(name);
                if (nameMeta.signature) {
                    signature.inline = nameMeta.signature;
                }
                continue;
            }
            attributes.others.unshift(token);
        }

        const resultObj = {
            tag,
            name,
            nameMeta,
            signature,
            children,
            attributes,
            type: attributes.types.join(" ")
        };

        if (typeof rootBlock === "undefined") {
            Object.defineProperty(resultObj, "nonNestedChildren", {
                value: nonNestedChildren
            })
        }

        // 'raw' verisini ana objede de gizliyoruz
        Object.defineProperty(resultObj, "raw", { value: rawBlock });

        return resultObj;
    }

    /**
     * $isim Parçalama (Önceki versiyonla aynı, sadece entegre edildi)
     */
    static analyzeIdentifier(rawName) {
        let cleanName = rawName;
        let signature = null;
        let suffix = "";

        const sigMatch = cleanName.match(/<([^>]*)>(.*)/);
        if (sigMatch) {
            const paramsStr = sigMatch[1];
            const resultStr = sigMatch[2];

            signature = {
                params: paramsStr ? paramsStr.split(".") : [],
                results: resultStr ? resultStr.split(".") : []
            };

            cleanName = cleanName.substring(0, sigMatch.index);
            suffix = `<${paramsStr}>${resultStr}`;
        }

        if (!cleanName.startsWith("$self.") && !cleanName.startsWith("$self/")) {
            return { raw: rawName, cleanName, isSelf: false, signature };
        }

        // $self işlemleri
        let pathStr = cleanName.substring(1);
        let descriptorKey = null;

        if (pathStr.endsWith("/get")) {
            descriptorKey = "get";
            pathStr = pathStr.substring(0, pathStr.length - 4);
        } else if (pathStr.endsWith("/set")) {
            descriptorKey = "set";
            pathStr = pathStr.substring(0, pathStr.length - 4);
        }

        if (pathStr.includes(":")) {
            pathStr = pathStr.replaceAll(":", ".prototype.");
        }
        if (pathStr.includes("TypedArray")) {
            pathStr = pathStr.replace("TypedArray", "Uint8Array.__proto__");
        }

        const parts = pathStr.split(".");
        const pathKeys = [];
        const walkPath = [];
        let currentPath = "";

        parts.forEach((part, index) => {
            pathKeys.push(part);
            if (index === 0) currentPath = part;
            else currentPath += "." + part;
            walkPath.push(currentPath);
        });

        return {
            raw: rawName,
            cleanName: "$" + pathStr,
            isSelf: true,
            signature,
            suffix,
            descriptorKey,
            parts,
            pathKeys,
            walkPath
        };
    }

    static tokenize(text) {
        const tokens = [];
        let current = "";
        let inString = false;

        for (let i = 0; i < text.length; i++) {
            const char = text[i];
            if (char === '"' && text[i - 1] !== '\\') {
                inString = !inString;
                current += char;
            } else if (/\s/.test(char) && !inString) {
                if (current) {
                    tokens.push(current);
                    current = "";
                }
            } else {
                current += char;
            }
        }
        if (current) tokens.push(current);
        return tokens;
    }

    static at(source, startIndex) {
        if (source[startIndex] !== "(") return null;
        let depth = 0;
        let inString = false;
        let i = startIndex;
        const len = source.length;

        while (i < len) {
            const char = source[i];
            if (inString) {
                if (char === '"' && source[i - 1] !== '\\') inString = false;
            } else {
                if (char === '"') {
                    inString = true;
                } else if (char === ';') {
                    if (source[i + 1] === ';') {
                        const nextLine = source.indexOf('\n', i);
                        if (nextLine === -1) break;
                        i = nextLine;
                        continue;
                    }
                } else if (char === '(') {
                    depth++;
                } else if (char === ')') {
                    depth--;
                    if (depth === 0) {
                        const end = i + 1;
                        const block = source.substring(startIndex, end);
                        const content = block.slice(1, -1).trim();
                        return {
                            start: startIndex,
                            length: (end - startIndex),
                            end,
                            block,
                            content
                        };
                    }
                }
            }
            i++;
        }
        return null;
    }
}