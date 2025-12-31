import { FUNC_WAT4WASM_BLOCK_ONEXTERNREADY } from "./processors/wat4wasm.js"
import { FUNC_WAT4WASM_BLOCK_ONTEXTREADY } from "./processors/wat4wasm.js"
import { FUNC_WAT4WASM_BLOCK_ONINIT } from "./processors/wat4wasm.js"
import { ELEM_WAT4WASM } from "./processors/wat4wasm.js"
import { TABLE_WAT4WASM } from "./processors/wat4wasm.js"
import { DATA_WAT4WASM } from "./processors/wat4wasm.js"
import { MEMORY_WAT4WASM } from "./processors/wat4wasm.js"
import { START_WAT4WASM } from "./processors/wat4wasm.js"
import { FUNC_WAT4WASM } from "./processors/wat4wasm.js"

function FUNC_WAT4WASM_START_CALLS(wat) {
    let $call;
    const calls = [];
    const maskSet = new helpers.MaskSet(
        FUNC_WAT4WASM_NOBLOCKS(wat)
    );

    while ($call = maskSet.lastBlockOf("call")) {
        if (calls.includes($call.$name) === false) {
            calls.push($call.$name);
        }
        maskSet.mask($call);
    }

    return calls;
}

export default function (wat) {
    let block;

    block = FUNC_WAT4WASM_BLOCK_ONEXTERNREADY(wat);
    if (!block.hasAnyBlock) { wat = block.removedRaw(); }

    block = FUNC_WAT4WASM_BLOCK_ONTEXTREADY(wat);
    if (!block.hasAnyBlock) { wat = block.removedRaw(); }

    block = FUNC_WAT4WASM_BLOCK_ONINIT(wat);
    if (!block.hasAnyBlock) {

        wat = block.removedRaw();

        let $starts = FUNC_WAT4WASM_START_CALLS(wat);
        if ($starts.length === 1) {
            wat = wat.replace(`(start $wat4wasm)`, `(start ${$starts.pop()})`);
        }

        let $func = FUNC_WAT4WASM(wat);
        if ($func) {
            wat = $func.removedRaw();
        }
    }

    block = ELEM_WAT4WASM(wat);
    if (block.isInitial) { wat = block.removedRaw(); }

    block = TABLE_WAT4WASM(wat);
    if (block.isInitial) { wat = block.removedRaw(); }

    block = DATA_WAT4WASM(wat);
    if (block.isInitial) { wat = block.removedRaw(); }

    if (false === helpers.hasBlock(wat, "global.get", { $name: WAT4WASM_$NAME }) &&
        false === helpers.hasBlock(wat, "global.set", { $name: WAT4WASM_$NAME })) {
        wat = GLOBAL_WAT4WASM(wat).removedRaw();
    }

    block = MEMORY_WAT4WASM(wat);
    if (block && (helpers.containsMemoryOperation(wat) === false)) {
        wat = block.removedRaw();
    }

    const maskSet = new helpers.MaskSet(wat);
    const imports = new Array();

    while (block = maskSet.lastBlockOf("import")) {
        block.$name = helpers.parseFirstBlock(block).$name;
        imports.push(block);
        maskSet.remove(block);
    }

    wat = maskSet.restore();
    wat = helpers.prepend(wat,
        imports
            .filter(b => new RegExp(`\\${b.$name}\(\\s|\\)\)`).test(wat))
            .sort((a, b) => helpers.generateId(a) - helpers.generateId(b))
            .map(b => b.toString())
            .join("\n")
    );

    return wat;
}