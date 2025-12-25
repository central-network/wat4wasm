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
                    (self) (string "Uint8Array")
                )
            )
        )

        ;;secure zero heap for memory.init
        (i32.const 0)
        (i32.load (i32.const 0))
        ;; offset and value stacked now 

        (block $oninit)

        
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

export let WAT4WASM_DATA = (buff = "00000000") => String(
    `(data $wat4wasm "${Buffer.from(buff).toString("hex").replaceAll(/(..)/g, `\\$1`)}")`
);

export let WAT4WASM_ELEM = String(
    `(elem $wat4wasm declare func $wat4wasm)`
);

export let WAT4WASM_START = String(
    `(start $wat4wasm)`
);

export const WAT4WASM = {
    global: WAT4WASM_GLOBAL,
    table: WAT4WASM_TABLE(1),
    elem: WAT4WASM_ELEM,
    func: WAT4WASM_FUNC,
    data: WAT4WASM_DATA("00000000"),
    start: WAT4WASM_START,
};

export function FUNC_WAT4WASM_BLOCK_ONINIT(wat) {
    const wat4func = helpers.lastBlockOf(wat, "func", { $name: WAT4WASM_$NAME });
    const blockoninit = helpers.lastBlockOf(wat4func, "block", { name: "oninit" });
    return helpers.parseBlockAt(wat, wat4func.begin + blockoninit.begin);
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

export function TABLE_WAT4WASM(wat) {
    return helpers.lastBlockOf(wat, "table", { $name: WAT4WASM_$NAME });
}

export function growExternTable(wat) {
    const wat4table = TABLE_WAT4WASM(wat);
    const lastIndex = parseInt(wat4table.toString().match(/\d+/).pop());

    return {
        index: lastIndex,
        getter: `(table.get ${WAT4WASM_$NAME} (i32.const ${lastIndex}))`,
        generateSetter: value => `(table.set ${WAT4WASM_$NAME} (i32.const ${lastIndex}) ${value.toString()})`,
        modifiedRaw: wat4table.replacedRaw(WAT4WASM_TABLE(lastIndex + 1))
    };
}

export function DATA_WAT4WASM(wat) {
    const block = helpers.lastBlockOf(wat, "data", { $name: WAT4WASM_$NAME });
    const strhex = helpers.findQuotedText(block);
    const buffer = Buffer.from(strhex.replaceAll(/\\+/g, ""), "hex");

    return Object.assign(block, {
        buffer: buffer,
        offset: buffer.byteLength
    });
}

export function allocDataBuffer(wat, buffer) {
    const new_data = Buffer.from(buffer);
    const all_data = DATA_WAT4WASM(wat);

    let offset = all_data.buffer.indexOf(new_data);
    let modifiedRaw = wat;

    if (offset < 1) {
        offset = all_data.offset;
        modifiedRaw = all_data.replacedRaw(WAT4WASM_DATA(Buffer.concat([all_data.buffer, new_data])));
    }

    return {
        offset,
        modifiedRaw,
        isRawModified: modifiedRaw.toString() !== wat.toString()
    };
}

export default function (wat) {
    let i = 31, raw;

    for (const BLOCK_NAME in WAT4WASM) {
        if (helpers.hasBlock(wat, BLOCK_NAME, { $name: WAT4WASM_$NAME })) {
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