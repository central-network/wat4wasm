import helpers from "../helpers.js"

export const TEXT_BLOCK_NAME = "text";

const TEXT_ONINIT_BLOCK = (offset, length, setter) => String(
    `
    (block $decodeText/${offset}:${length}

        (local.set $viewAt (i32.const 0))
        (local.set $offset (i32.const ${offset}))
        (local.set $length (i32.const ${length}))

        (local.set $arguments (call $self.Array<>ext))
            
        (call $self.Reflect.set<ext.i32.i32>
            (local.get $arguments) (i32.const 0) (local.get $length)
        )

        (local.set $arrayBufferView
            (call $self.Reflect.construct<ext.ext>ext
                (local.get $Uint8Array)
                (local.get $arguments)
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

        (local.set $arguments (call $self.Array<>ext))

        (call $self.Reflect.set<ext.i32.ext>
            (local.get $arguments)
            (i32.const 0)
            (local.get $arrayBufferView)
        )

        ${setter}
    )    
`).trim();

const extern = new Set();

export default function (wat, WAT4WASM) {

    const maskSet = new helpers.MaskSet(wat);
    const textBlocks = new Array();

    while (maskSet.hasBlock(TEXT_BLOCK_NAME)) {
        let block = maskSet.lastBlockOf(TEXT_BLOCK_NAME);
        maskSet.mask(block);
        textBlocks.push(block);
    }

    wat = maskSet.restore();

    textBlocks.forEach(block => {
        const text = helpers.findQuotedText(block);
        if (extern.has(text) === false) {
            extern.add(text)

            const view = helpers.encodeText(text);
            const dataRequest = WAT4WASM_ALLOC_DATA_BUFFER(wat, view.buffer);

            block.dataOffset = dataRequest.offset;
            block.viewLength = view.length;
            block.strPreview = helpers.abstract(text);
            block.strContent = text;
            block.isExtended = true;

            wat = dataRequest.modifiedRaw;
        }
        else {
            block.isExtended = false;
        }
    });

    textBlocks.filter(block => block.isExtended).forEach(block => {
        const growRequest = WAT4WASM_GROW_EXTERN_TABLE(wat);
        block.tableGetter = growRequest.getter.concat(`;; ${block.strPreview} \n`);
        block.tableSetter = growRequest.generateSetter(`
        (call $self.Reflect.apply<ext.ext.ext>ext
            (local.get $textDecoder.decode)
            (local.get $textDecoder)
            (local.get $arguments) ;; ${block.strPreview}
        )`).trim();

        wat = growRequest.modifiedRaw;
    });

    textBlocks.filter(block => block.isExtended).forEach(block => {
        wat = wat.replaceAll(block.toString(), block.tableGetter);
    });

    const oninit = textBlocks.filter(block => block.isExtended).map(block =>
        TEXT_ONINIT_BLOCK(
            block.dataOffset,
            block.viewLength, block.tableSetter
        )
    ).join("\n");

    if (oninit.trim()) {
        wat = APPEND_ON_INIT(wat, oninit);
    }

    return wat;
}