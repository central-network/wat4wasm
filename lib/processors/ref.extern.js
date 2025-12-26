import helpers from "../helpers.js"

export const BLOCK_NAME = "ref.extern";

const PATH_WALKER_CODE = ($name, descriptorKey) => {

    const nameparts = $name.split("<").at(0).split("$").pop().split(".");
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
            (text "${currentKey}") ;; ${currentKey}
        )`).trim();
    }

    if (descriptorKey !== "value") {
        currentKey = nameparts.pop();
        pathWalker = String(`
        (call $self.Reflect.get<ext.ext>ext
            (call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
                ${pathWalker} 
                (text "${currentKey}") ;; ${currentKey}
            )
            (text "${descriptorKey}") ;; ${descriptorKey}
        )`).trim();
    }

    return String(`
    ${pathWalker}
    `);
}

export default function (wat, WAT4WASM) {

    while (helpers.hasBlock(wat, BLOCK_NAME)) {
        const wrapper = helpers.lastBlockOf(wat, BLOCK_NAME);
        const $name = wrapper.$name;
        const name = $name.substring(1);

        const growRequest = WAT4WASM.growExternTable(wat);

        const refGetter = growRequest.getter;
        const refSetter = growRequest.generateSetter(
            PATH_WALKER_CODE($name, wrapper.descriptorKey)
        );

        wat = growRequest.modifiedRaw.replaceAll(
            wrapper.toString(), refGetter
        );

        const header = `block $ref.extern/${name}`;
        if (wat.includes(header) === false) {
            const code = String(`(${header}\n${refSetter}\n)`);
            wat = WAT4WASM.appendOnTextReady(wat, code);
        }
    }

    return wat;
}