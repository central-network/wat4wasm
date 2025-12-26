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

const GLOBAL_DEFINE_CODE = ($name) => {
    const [pathName = "self", type = "ext"] = helpers.nameSignatureofGlobal($name);

    const tagName = "global";
    const mutValue = t => `(mut ${({ ext: 'externref', fun: 'funcref' })[t] || t})`;
    const nilValue = t => `(${({ ext: 'ref.null extern', fun: 'ref.null func' })[t] || `${t}.const 0`})`;

    return `(${tagName} ${$name} ${mutValue(type)} ${nilValue(type)})`;
}

export default function (wat, WAT4WASM) {

    const maskSet = new helpers.MaskSet(wat);
    const selfSet = new Set();
    const imports = new Array();
    const globals = new Array();
    const oninits = new Array();

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

        maskSet.mask(global);

        if ($name && $name.startsWith("$self")) {
            if (selfSet.has($name) === false) {
                selfSet.add($name);

                const [pathName = "self", type = "ext"
                ] = helpers.nameSignatureofGlobal($name);

                const nameparts = pathName.split(".");

                if (nameparts.length <= 3) {
                    imports.push(GLOBAL_IMPORT_CODE($name));
                }
                else if (globals.includes($name) === false) {
                    globals.push(GLOBAL_DEFINE_CODE($name));

                    const stepType = new Array(nameparts.length - 1).fill("ext");
                    let pathWalker = `(global.get $${nameparts[0]})`;
                    let currentKey;

                    stepType.push(type);
                    stepType.reverse().pop();
                    nameparts.reverse().pop();

                    while (nameparts.length) {
                        currentKey = nameparts.pop();
                        pathWalker = String(`
                        (call $self.Reflect.get<ext.ext>${stepType.pop()}
                            ${pathWalker} 
                            (text "${currentKey}") ;; ${currentKey}
                        )`).trim();
                    }

                    const setter = String(`
                    (global.set ${$name}
                        ${pathWalker}
                    )    
                    `).trim();

                    const name = $name.substring(1);
                    oninits.push({ setter, name, type: 'global' });
                }
            }
        }
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

    globals.forEach(code => {
        if (wat.includes(code) === false) {
            wat = helpers.append(wat, code);
        }
    });

    oninits.forEach(init => {
        const header = `block $${init.type}/${init.name}`;
        if (wat.includes(header) === false) {
            const code = String(`(${header}\n${init.setter}\n)`);
            wat = WAT4WASM.appendOnTextReady(wat, code);
        }
    });

    return wat;
}