import helpers from "../helpers.js"

export const REF_FUNC_BLOCK_NAME = "ref.func";

export default function (wat, WAT4WASM) {

    const maskSetElem = new helpers.MaskSet(wat);
    const elemSegments = new Array();
    const needReference = new Set();

    while (maskSetElem.hasBlock("elem")) {
        const block = maskSetElem.lastBlockOf("elem");
        const $name = block.$name;
        if (WAT4WASM.WAT4WASM_$NAME !== $name) {
            elemSegments.push(block.toString());
        }
        maskSetElem.mask(block);
    }

    const maskSetRef = new helpers.MaskSet(wat);

    while (maskSetRef.hasBlock(REF_FUNC_BLOCK_NAME)) {
        const block = maskSetRef.lastBlockOf(REF_FUNC_BLOCK_NAME);
        const $name = block.$name

        if (WAT4WASM.WAT4WASM_$NAME !== $name) {
            if (elemSegments.some(seg => seg.includes($name)) === false) {
                if (needReference.has($name) === false) {
                    needReference.add($name);
                }
            }
        }

        maskSetRef.mask(block);
    }

    wat = maskSetRef.restore();

    needReference.forEach($name => {
        wat = WAT4WASM_REFERENCE_FUNC_ELEMENT(wat, $name);
    });

    return wat;
}