import helpers from "../helpers.js"

export const BLOCK_NAME = "text";

export default function (wat) {
    if (helpers.hasBlock(wat, BLOCK_NAME) !== true) { return wat; }

    let externId = helpers.referenceId();
    let oldBlock = helpers.lastBlockOf(wat, BLOCK_NAME);
    let newBlock = helpers.createTableGetter(externId);

    return oldBlock.replacedRaw(newBlock);
}