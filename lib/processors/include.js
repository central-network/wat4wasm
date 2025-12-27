import helpers from "../helpers.js"

export const BLOCK_NAME = "include";

export default function (wat, WAT4WASM) {

    while (helpers.hasBlock(wat, BLOCK_NAME)) {
        const block = helpers.lastBlockOf(wat, BLOCK_NAME);
        const path = helpers.findQuotedText(block);

        wat = block.replacedRaw(
            helpers.readFileAsText(path)
        );
    }

    return wat;
}