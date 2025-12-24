import helpers from "../helpers.js"

export const BLOCK_NAME = "string";

export default function (wat) {
    if (helpers.hasBlock(wat, BLOCK_NAME) !== true) { return wat; }

    if (false === helpers.hasBlock(wat, "table", { $name: "$wat4wasm" })) {
        console.log("\n\t<-- no extern table -->\n")

        return wat.substring(0, wat.lastIndexOf(")")).concat(`
            (table $wat4wasm 1 externref)    
        `).concat(")")
    }

    const oldTable = helpers.lastBlockOf(wat, "table", { $name: "$wat4wasm" });
    const operator = helpers.getTableOperator(oldTable);

    const {
        newTableBlock,
        getTableBlock
    } = operator.grow(1);

    wat = oldTable.replacedRaw(newTableBlock);

    let oldBlock = helpers.lastBlockOf(wat, BLOCK_NAME);
    let newBlock = getTableBlock;

    wat = oldBlock.replacedRaw(newBlock);

    return wat;
}