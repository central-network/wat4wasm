import helpers from "../helpers.js"

export const BLOCK_NAME = "start";

export default function (wat, WAT4WASM) {
    let startCalls = [];
    let removedWat = wat;

    while (helpers.hasBlock(removedWat, BLOCK_NAME)) {
        let block = helpers.lastBlockOf(removedWat, BLOCK_NAME);
        removedWat = block.removedRaw();

        if (block.includes(WAT4WASM.WAT4WASM_$NAME) === false) {
            startCalls.push(block);
        }
    }

    if (startCalls.length > 0) {
        wat = removedWat;

        let $wat4func = helpers.lastBlockOf(wat, "func", { $name: WAT4WASM.WAT4WASM_$NAME });
        let funcblock = $wat4func.toString();

        const appends = startCalls.filter(start => {
            let $name = `${start.$name}`;
            let $call = `(call ${$name})`;

            if (helpers.hasBlock(funcblock, "call", { $name }) === false) {
                funcblock = helpers.append(funcblock, $call);
                return true;
            }
        });

        if (appends.length) {
            wat = $wat4func.replacedRaw(funcblock);
        }

        wat = helpers.append(wat, WAT4WASM.WAT4WASM_START);
    }

    return wat;
}