import helpers from "../helpers.js"

export const BLOCK_NAME = "data";

export default function (wat, WAT4WASM) {

    const maskSet = new helpers.MaskSet();
    while (helpers.hasBlock(wat, BLOCK_NAME)) {

        const block = helpers.lastBlockOf(wat, BLOCK_NAME);
        const content = helpers.findQuotedText(block);

        wat = maskSet.mask(block);

        let path, temp, data, name;
        switch (content.substring(0, 7)) {
            case "file://":
                path = content.substring(7);
                data = helpers.readFileAsDataHex(path);
                maskSet.update(block, block.replace(content, data));
                break;

            case "wasm://":
                path = content.substring(7);
                name = path.split("/").pop().split(".").reverse().slice(1).reverse().join(".");
                temp = helpers.copyFileToTemp(path, `${name}.wat`);

                const params = process.argv
                    .filter(a => a.startsWith("--"))
                    .filter(a => !a.startsWith("--input="))
                    .filter(a => !a.startsWith("--output="))
                    ;

                const argv = Array()
                    .concat(process.argv[1])
                    .concat(`--input=${temp}`)
                    .concat(`--output=${temp}.wasm`)
                    .concat(params)
                    ;

                helpers.spawnSync(process.argv0, argv);
                data = helpers.readFileAsDataHex(`${temp}.wasm`);
                maskSet.update(block, block.replace(content, data));
                break;

            default:
                break;
        }
    }

    return maskSet.restoreInto(wat);
}