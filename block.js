function block(raw = "(module)", tag = "include") {
    const regex = new RegExp(`\\(${tag.replaceAll(/\./g, "\\\.")}`);
    const match = String(raw).match(regex);

    if (match) {
        let { index, input } = match;
        let end;
        let maxEnd = input.length;
        let substring;

        end = input.indexOf(")", index);
        substring = input.substring(index, ++end);

        while (substring.split("(").length !== substring.split(")").length) {
            end = input.indexOf(")", end);
            substring = input.substring(index, ++end);
            if (end > maxEnd) throw "max end reached!";
        }

        match.block = substring;
        match.end = end;

        let blockContent = substring.substring(
            substring.indexOf(" "),
            substring.lastIndexOf(")")
        ).trim();

        const charMatch = blockContent.charAt(0).match(/["'`]/);
        if (charMatch && blockContent.charAt(blockContent.length - 1) === charMatch.at(0)) {
            blockContent = blockContent.substring(1, blockContent.length - 1);
        }
        const [
            tagType, tagSubType = ""
        ] = substring.substring(
            1, substring.indexOf(" ")
        ).trim().split(".");

        let blockName = "";
        if (blockContent.startsWith("$")) {
            let nameEnd = 0;
            let nameLen = blockContent.length;

            while (blockContent.charAt(++nameEnd).match(w4.NAME_REGEXP)) {
                if (nameEnd === nameLen) break;
            }

            blockName = blockContent.substring(1, nameEnd);
        }

        if (blockName) {
            blockContent = blockContent.substring(
                blockContent.indexOf(blockName) + blockName.length
            ).trim() || blockContent;
        }

        Reflect.defineProperty(match, "tagType", { value: tagType, enumerable: true });
        Reflect.defineProperty(match, "tagSubType", { value: tagSubType, enumerable: true });
        Reflect.defineProperty(match, "blockName", { value: blockName, enumerable: true });
        Reflect.defineProperty(match, "blockContent", { value: blockContent, enumerable: true });
        Reflect.defineProperty(match, "input", { value: match.input, enumerable: false });

        delete match.groups;
    }

    return match;
}