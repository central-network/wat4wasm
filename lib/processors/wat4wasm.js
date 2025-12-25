import helpers from "../helpers.js"

export let WAT4WASM_$NAME = `$wat4wasm`;

export let WAT4WASM_FUNC = String(`
    (func $wat4wasm 
        (local $TextDecoder externref)
        (local $decode externref)
        (local $Uint8Array externref)

        (block $prepare
            (local.set $TextDecoder
                (call $self.Reflect.construct<ext.ext>ext
                    (call $self.Reflect.get<ext.ext>ext
                        (self)
                        (string "TextDecoder")
                    )
                    (self)
                )
            )

            (local.set $decode
                (call $self.Reflect.get<ext.ext>ext
                    (local.get $TextDecoder)
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

        (local.get $TextDecoder)
        (call $self.console.log<ext>)

        (local.get $decode)
        (call $self.console.log<ext>)

        (local.get $Uint8Array)
        (call $self.console.log<ext>)
    )
`);

export let WAT4WASM_GLOBAL = String(
    `(global $wat4wasm (mut externref) (ref.null extern))`
);

export let WAT4WASM_TABLE = String(
    `(table $wat4wasm 1 externref)`
);

export let WAT4WASM_DATA = String(
    `(data $wat4wasm "\\00\\00\\00\\00")`
);

export let WAT4WASM_ELEM = String(
    `(elem $wat4wasm declare func $wat4wasm)`
);

export let WAT4WASM_START = String(
    `(start $wat4wasm)`
);

export const WAT4WASM = {
    global: WAT4WASM_GLOBAL,
    table: WAT4WASM_TABLE,
    elem: WAT4WASM_ELEM,
    func: WAT4WASM_FUNC,
    data: WAT4WASM_DATA,
    start: WAT4WASM_START,
};

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