import helpers from "../helpers.js"

export const BLOCK_NAME = "ref.extern";

const PATH_WALKER_CODE = ($name, descriptorKey) => {

    const nameparts = $name.split(/\<|\//).at(0).split("$").pop().split(".");
    const stepType = new Array(nameparts.length - 1).fill("ext");
    const type = $name.split(">").at(0).split("<").pop() || "ext";

    let pathWalker = `(self)`;
    let currentKey;

    stepType.push(type);
    stepType.reverse().pop();
    nameparts.reverse().pop();

    let stepCount = nameparts.length;
    if (descriptorKey !== "value") {
        stepCount = stepCount - 1;
    }

    while (stepCount--) {
        currentKey = nameparts.pop();
        pathWalker = String(`
        (call $self.Reflect.get<ext.ext>${stepType.pop()}
            ${pathWalker} 
            (text "${currentKey}")
        )`).trim();
    }

    if (descriptorKey !== "value") {
        currentKey = nameparts.pop();
        pathWalker = String(`
        (call $self.Reflect.get<ext.ext>ext
            (call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
                ${pathWalker} 
                (text "${currentKey}")
            )
            (text "${descriptorKey}")
        )`).trim();
    }

    return String(`
    ${pathWalker}
    `);
};

const FIXNAME_SELF_PATH = ($name, descriptorKey) => {

    if ($name.startsWith("$self") === false) {
        $name = `$self.${$name.substring(1)}`;
    }

    if ($name.endsWith(">") === false) {
        if (descriptorKey === "value") {
            $name = `${$name}<ext>`;
        }
    }

    return $name;
};

export default function (wat, WAT4WASM) {

    const externs = new Map();
    const getters = new Map();
    const maskSet = new helpers.MaskSet(wat);

    while (maskSet.hasBlock(BLOCK_NAME)) {
        const block = maskSet.lastBlockOf(BLOCK_NAME);
        const $name = FIXNAME_SELF_PATH(block.$name, block.descriptorKey);

        if (externs.has($name) === false) {
            externs.set($name, block.descriptorKey);
        }

        maskSet.mask(block);
    }

    wat = maskSet.restore();

    let oninit = String();
    externs.forEach((dKey, $name) => {
        const pathWalker = PATH_WALKER_CODE($name, dKey);
        const growExtern = WAT4WASM.growExternTable(wat);

        const __getter__ = growExtern.getter.concat(` ;; ${$name}\n`);
        const __setter__ = growExtern.generateSetter(pathWalker);

        wat = growExtern.modifiedRaw;
        oninit = `${oninit}\n\n(block ${$name}\n${__setter__})\n`;
        getters.set($name, __getter__);
    });

    while (helpers.hasBlock(wat, BLOCK_NAME)) {
        const block = helpers.lastBlockOf(wat, BLOCK_NAME);
        const $name = FIXNAME_SELF_PATH(block.$name, block.descriptorKey);
        wat = block.replacedRaw(getters.get($name));
    }

    if (oninit.trim()) {
        wat = WAT4WASM.appendOnTextReady(wat, oninit);
    }

    return wat;
}