import helpers from "../helpers.js"

export let WAT4WASM_$NAME = `$wat4wasm`;

export let WAT4WASM_FUNC = String(`
    (func $wat4wasm 
        (local $textDecoder externref)
        (local $textDecoder.decode externref)
        (local $Uint8Array externref)
        (local $arguments externref)
        (local $arrayBufferView externref)

        (local $viewAt i32)
        (local $offset i32)
        (local $length i32)

        (block $prepare
            (local.set $textDecoder
                (call $self.Reflect.construct<ext.ext>ext
                    (call $self.Reflect.get<ext.ext>ext
                        (self) 
                        (string "TextDecoder")
                    )
                    (self)
                )
            )

            (local.set $textDecoder.decode
                (call $self.Reflect.get<ext.ext>ext
                    (local.get $textDecoder)
                    (string "decode")
                )
            )

            (local.set $Uint8Array
                (call $self.Reflect.get<ext.ext>ext
                    (self) 
                    (string "Uint8Array")
                )
            )
        )

        ;;secure zero heap for memory.init
        (i32.const 0)
        (i32.load (i32.const 0))
        ;; offset and value stacked now 

        (block $oninit)
        (block $ontextready)
        (block $onexternready)
        
        ;; restore zero heap value
        (i32.store (; stack stack ;))
        (nop)
    )
`);

export let WAT4WASM_GLOBAL = String(
    `(global $wat4wasm (mut externref) (ref.null extern))`
);

export let WAT4WASM_TABLE = (size = 1) => String(
    `(table $wat4wasm ${size} externref)`
);

export let WAT4WASM_DATA = (buff = "0000") => String(
    `(data $wat4wasm "${Buffer.from(buff).toString("hex").replaceAll(/(..)/g, `\\$1`)}")`
);

export let WAT4WASM_ELEM = String(
    `(elem $wat4wasm declare func)`
);

export let WAT4WASM_MEMORY = String(
    `(memory $wat4wasm 1)`
);

export let WAT4WASM_START = String(
    `(start $wat4wasm)`
);

export const WAT4WASM = {
    global: WAT4WASM_GLOBAL,
    table: WAT4WASM_TABLE(1),
    elem: WAT4WASM_ELEM,
    func: WAT4WASM_FUNC,
    data: WAT4WASM_DATA(),
    start: WAT4WASM_START
};

export function FUNC_WAT4WASM(wat) {
    return helpers.lastBlockOf(wat, "func", { $name: WAT4WASM_$NAME });
}

export function ELEM_WAT4WASM(wat) {
    const block = helpers.lastBlockOf(wat, "elem", { $name: WAT4WASM_$NAME });
    return Object.assign(block, {
        isInitial: helpers.generateId(block) === helpers.generateId(WAT4WASM_ELEM)
    });
}

export function MEMORY_WAT4WASM(wat) {
    return helpers.lastBlockOf(wat, "memory", { $name: WAT4WASM_$NAME });
}

export function GLOBAL_WAT4WASM(wat) {
    return helpers.lastBlockOf(wat, "global", { $name: WAT4WASM_$NAME });
}

export function START_WAT4WASM(wat) {
    return helpers.lastBlockOf(wat, "start", { $name: WAT4WASM_$NAME });
}

export function FUNC_WAT4WASM_NOBLOCKS(wat) {
    const maskSet = new helpers.MaskSet(FUNC_WAT4WASM(wat));

    maskSet.remove(maskSet.lastBlockOf("block", { name: "onexternready" }));
    maskSet.remove(maskSet.lastBlockOf("block", { name: "ontextready" }));
    maskSet.remove(maskSet.lastBlockOf("block", { name: "oninit" }));
    maskSet.remove(maskSet.lastBlockOf("block", { name: "prepare" }));

    return maskSet.restore();
}

export function FUNC_WAT4WASM_START_CALLS(wat) {
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


export function FUNC_WAT4WASM_BLOCK_ONINIT(wat) {
    const wat4func = FUNC_WAT4WASM(wat);
    const blockoninit = helpers.lastBlockOf(wat4func, "block", { name: "oninit" });
    const $blockoninit = helpers.parseBlockAt(wat, wat4func.begin + blockoninit.begin);

    return $blockoninit;
}

export function FUNC_WAT4WASM_BLOCK_ONTEXTREADY(wat) {
    const wat4func = FUNC_WAT4WASM(wat);
    const ontextready = helpers.lastBlockOf(wat4func, "block", { name: "ontextready" });
    const $ontextready = helpers.parseBlockAt(wat, wat4func.begin + ontextready.begin);

    return $ontextready;
}

export function FUNC_WAT4WASM_BLOCK_ONEXTERNREADY(wat) {
    const wat4func = FUNC_WAT4WASM(wat);
    const onexternready = helpers.lastBlockOf(wat4func, "block", { name: "onexternready" });
    const $onexternready = helpers.parseBlockAt(wat, wat4func.begin + onexternready.begin);

    return $onexternready;
}

export function prependOnInit(wat, block) {
    const oninitblock = FUNC_WAT4WASM_BLOCK_ONINIT(wat);

    if (oninitblock.includes(block.toString())) {
        return wat;
    }

    wat = oninitblock.replacedRaw(
        helpers.prepend(oninitblock, block.toString())
    );

    return wat;
}

export function appendOnInit(wat, block) {
    const oninitblock = FUNC_WAT4WASM_BLOCK_ONINIT(wat);

    if (oninitblock.includes(block.toString())) {
        return wat;
    }

    wat = oninitblock.replacedRaw(
        helpers.append(oninitblock, block)
    );

    return wat;
}

export function appendOnTextReady(wat, block) {
    const ontextready = FUNC_WAT4WASM_BLOCK_ONTEXTREADY(wat);

    if (ontextready.hasBlock("block",
        { $name: helpers.firstBlockOf(block, "block")?.$name }
    ) === false && !ontextready.includes(block.trim())) {
        return ontextready.replacedRaw(
            helpers.append(ontextready, block)
        );
    }

    return wat;
}

export function appendOnExternReady(wat, block) {
    const onexternready = FUNC_WAT4WASM_BLOCK_ONEXTERNREADY(wat);

    if (onexternready.includes(block.toString())) {
        return wat;
    }

    wat = onexternready.replacedRaw(
        helpers.append(onexternready, block)
    );

    return wat;
}


export function TABLE_WAT4WASM(wat) {
    const wat4table = helpers.lastBlockOf(wat, "table", { $name: WAT4WASM_$NAME });
    const lastIndex = parseInt(wat4table.toString().match(/\s(\d+)/).pop());

    return Object.assign(wat4table, {
        lastIndex, isInitial: lastIndex === 1
    })
}

export function growExternTable(wat) {
    const wat4table = TABLE_WAT4WASM(wat);
    const lastIndex = wat4table.lastIndex;

    return {
        index: lastIndex,
        getter: `(table.get ${WAT4WASM_$NAME} (i32.const ${lastIndex}))`,
        generateSetter: value => `(table.set ${WAT4WASM_$NAME} (i32.const ${lastIndex}) ${value.toString()})`,
        modifiedRaw: wat4table.replacedRaw(WAT4WASM_TABLE(lastIndex + 1))
    };
}


export function referenceElement(wat, $name) {
    const $wat4elem = ELEM_WAT4WASM(wat);
    const _wat4elem = $wat4elem.toString();

    if (_wat4elem.includes($name) === false) {
        wat = $wat4elem.replacedRaw(_wat4elem
            .substring(0, _wat4elem.lastIndexOf(")"))
            .concat(` ${$name}`)
            .concat(")")
        );
    }

    return wat;
}


export function DATA_WAT4WASM(wat) {
    const block = helpers.lastBlockOf(wat, "data", { $name: WAT4WASM_$NAME });
    const strhex = helpers.findQuotedText(block);
    const buffer = Buffer.from(strhex.replaceAll(/[^a-f0-9A-F]/g, ""), "hex");

    return Object.assign(block, {
        buffer: buffer,
        offset: buffer.byteLength,
        isInitial: buffer.byteLength === 4
    });
}

export function allocDataBuffer(wat, buffer) {
    const new_data = Buffer.from(buffer);
    const all_data = DATA_WAT4WASM(wat);

    let offset = all_data.buffer.indexOf(new_data);
    let modifiedRaw = wat;

    if (offset < 1) {
        offset = all_data.offset;
        all_data.buffer.writeUint32LE(offset + new_data.byteLength);
        modifiedRaw = all_data.replacedRaw(WAT4WASM_DATA(Buffer.concat([all_data.buffer, new_data])));
    }

    return {
        offset,
        modifiedRaw,
        isRawModified: modifiedRaw.toString() !== wat.toString()
    };
}

export function clean(wat) {
    let block;

    block = FUNC_WAT4WASM_BLOCK_ONEXTERNREADY(wat);
    if (!block.hasAnyBlock) { wat = block.removedRaw(); }

    block = FUNC_WAT4WASM_BLOCK_ONTEXTREADY(wat);
    if (!block.hasAnyBlock) { wat = block.removedRaw(); }

    block = FUNC_WAT4WASM_BLOCK_ONINIT(wat);
    if (!block.hasAnyBlock) {

        wat = block.removedRaw();
        let $starts = FUNC_WAT4WASM_START_CALLS(wat);
        if ($starts.length <= 1) {
            wat = START_WAT4WASM(wat).removedRaw();
            wat = FUNC_WAT4WASM(wat).removedRaw();

            if ($starts.length === 1) {
                wat = helpers.append(wat, `(start ${$starts.pop()})`);
            }
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

export default function (wat) {
    let i = 31, raw;

    if (helpers.hasBlock(wat, "memory") === false) {
        WAT4WASM.memory = WAT4WASM_MEMORY;
    }

    for (const BLOCK_NAME in WAT4WASM) {

        if (wat.includes(`(${BLOCK_NAME} ${WAT4WASM_$NAME}`)) {
            continue;
        }

        if (i === 31) console.log("")
        console.log(`🦋 appending element --> \x1b[${i++}m(${BLOCK_NAME} ${WAT4WASM_$NAME}) ...)\x1b[0m`);

        raw = WAT4WASM[BLOCK_NAME].replaceAll("$wat4wasm", WAT4WASM_$NAME);
        wat = helpers.append(wat, raw);
    }
    if (i !== 31) console.log("")

    return wat;
}