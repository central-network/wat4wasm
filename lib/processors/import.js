import helpers from "../helpers.js"

export const BLOCK_NAME = "import";

const RAWBLOCK_IMPORT_CODE = (pathName, rawBlock) => `(import "${pathName.split(".").at(-2) || 'self'}" "${pathName.split(".").at(-1)}"  \t${rawBlock})`.replaceAll(" )", ")");
const FUNCTION_IMPORT_CODE = ($name) => {
    const namesig = $name.match(/\$(.[^<]*)<(.[^>]*)?>(.[^\s]*)?/).slice(1);
    const [pathName, inputs = "", outputs = ""] = namesig;

    const tagName = `func`;
    const longType = t => ({ ext: 'externref', fun: 'funcref' })[t] || t;
    const paramBlock = `(param${`.${inputs}`.split('.').map(longType).join(' ')})`;
    const resultBlock = `(result${`.${outputs}`.split('.').map(longType).join(' ')})`;

    return RAWBLOCK_IMPORT_CODE(pathName, `(${tagName} ${$name} ${paramBlock} ${resultBlock})`);
}

const GLOBAL_IMPORT_CODE = ($name) => {
    const namesig = $name.match(/\$(.[^<]*)(?:\<(.[^>]*)\>)?/)?.slice(1) || [];
    const [pathName = "self", type = "ext"] = namesig;

    const tagName = "global";
    const typeName = type.replace(`ext`, `externref`);

    return RAWBLOCK_IMPORT_CODE(pathName, `(${tagName} ${$name} ${typeName})`);
}

export default function (wat, WAT4WASM) {

    const maskSet = new helpers.MaskSet(wat);
    const selfSet = new Set();
    const imports = new Array();

    while (maskSet.hasBlock(BLOCK_NAME)) {
        const wrapper = maskSet.lastBlockOf(BLOCK_NAME);
        const $name = helpers.parseFirstBlock(wrapper).$name;

        if ($name && $name.startsWith("$self")) {
            if (selfSet.has($name) === false) {
                selfSet.add($name);
            }
        }

        maskSet.mask(wrapper);
    }

    while (maskSet.hasBlock("global.get")) {
        const global = maskSet.lastBlockOf("global.get");
        const $name = global.$name;

        if ($name && $name.startsWith("$self")) {
            if (selfSet.has($name) === false) {
                selfSet.add($name);
                imports.push(GLOBAL_IMPORT_CODE($name));
            }
        }

        maskSet.mask(global);
    }

    while (maskSet.hasBlock("call")) {
        const caller = maskSet.lastBlockOf("call");
        const $name = caller.$name;

        if ($name && $name.startsWith("$self")) {
            if (selfSet.has($name) === false) {
                selfSet.add($name);
                imports.push(FUNCTION_IMPORT_CODE($name));
            }
        }

        maskSet.mask(caller);
    }

    wat = maskSet.restore();

    imports.forEach(code => {
        if (wat.includes(code) === false) {
            wat = helpers.prepend(wat, code);
        }
    });

    return wat;
}