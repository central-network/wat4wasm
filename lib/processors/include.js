import helpers from "../helpers.js"

export const BLOCK_NAME = "include";

export default function (wat) {
    if (helpers.hasBlock(wat, BLOCK_NAME) !== true) { return wat; }

    let oldBlock = helpers.lastBlockOf(wat, BLOCK_NAME);
    let newBlock = `;;(nop)`;

    return oldBlock.replacedRaw(newBlock);
}