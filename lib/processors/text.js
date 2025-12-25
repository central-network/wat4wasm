import helpers from "../helpers.js"

export const BLOCK_NAME = "text";

let dataOffset = 4;
export default function (wat, WAT4WASM) {
    if (helpers.hasBlock(wat, BLOCK_NAME) !== true) { return wat; }

    let uuid = helpers.referenceId();
    let oldBlock = helpers.lastBlockOf(wat, BLOCK_NAME);

    //secure location
    wat = oldBlock.replacedRaw(uuid);

    const text = helpers.findQuotedText(oldBlock);
    const view = helpers.encodeText(text);

    const dataRequest = WAT4WASM.allocDataBuffer(wat, view.buffer);
    if (dataRequest.isRawModified) {
        wat = dataRequest.modifiedRaw;
    }

    const growRequest = WAT4WASM.growExternTable(wat);

    const offset = dataRequest.offset;
    const length = view.length;

    const oninit = String(`
        (block $decodeText/${offset}+=${length}

            (local.set $viewAt (i32.const 0))
            (local.set $offset (i32.const ${offset}))
            (local.set $length (i32.const ${length}))

            (local.set $arrayBufferView
                (call $self.Reflect.construct<ext.ext>ext
                    (local.get $Uint8Array)
                    (call $self.Array.of<i32>ext (local.get $length))
                )
            )

            (loop $length--
                (if (local.get $length)
                    (then
                        (memory.init $wat4wasm 
                            (i32.const 0) 
                            (local.get $offset) 
                            (i32.const 1)
                        )

                        (call $self.Reflect.set<ext.i32.i32>
                            (local.get $arrayBufferView)
                            (local.get $viewAt)
                            (i32.load8_u (i32.const 0))
                        )

                        (local.set $viewAt (i32.add (local.get $viewAt) (i32.const 1)))
                        (local.set $offset (i32.add (local.get $offset) (i32.const 1)))
                        (local.set $length (i32.sub (local.get $length) (i32.const 1)))

                        (br $length--)
                    )
                )
            )

            (local.set $arguments 
                (call $self.Array.of<ext>ext
                    (local.get $arrayBufferView)
                )
            )

            ${growRequest.generateSetter(`
            (call $self.Reflect.apply<ext.ext.ext>ext
                (local.get $textDecoder.decode)
                (local.get $textDecoder)
                (local.get $arguments)
            )`)}
        )    
    `);

    dataOffset += length;

    wat = growRequest.modifiedRaw;
    wat = WAT4WASM.appendOnInit(wat, oninit);

    //restore location
    wat = wat.replaceAll(uuid, growRequest.getter);
    return wat;
}