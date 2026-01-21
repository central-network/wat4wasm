import helpers from "../helpers.js"

const GENERATE_DATA_VIEWER = (size, $name) => {
    return `
    (block ${$name}
        (result externref)

        (global.set $wat4wasm (call $self.Array<>ext))
        
        (call $self.Reflect.set<ext.i32.i32>
            (global.get $wat4wasm) (i32.const 0) (i32.const ${size})
        )

        (global.set $wat4wasm
            (call $self.Reflect.construct<ext.ext>ext
                (ref.extern $self.Uint8Array<ext>)
                (global.get $wat4wasm)
            )
        )
        
        (if (i32.const ${size})
            (then
                (i32.const 0)
                (i64.load (i32.const 0))

                (block $copy
                    (i32.store (i32.const 0) (i32.const ${size}))
                    (loop $i--
                        (if (i32.load (i32.const 0))
                            (then   
                                (i32.store
                                    (i32.const 0)
                                    (i32.sub (i32.load (i32.const 0)) (i32.const 1))
                                )

                                (memory.init ${$name} 
                                    (i32.const 4) 
                                    (i32.load (i32.const 0)) 
                                    (i32.const 1)
                                )

                                (call $self.Reflect.set<ext.i32.i32>
                                    (global.get $wat4wasm)
                                    (i32.load (i32.const 0))
                                    (i32.load8_u (i32.const 4))
                                )

                                (br $i--)
                            )
                        )
                    )
                )

                (i64.store (; stack stack ;))
            )
        )

        (global.get $wat4wasm)
        (global.set $wat4wasm (null))
    )
    `;
};

const GENERATE_TEXT_VIEWER = (size, $name) => {
    return `
    (block ${$name}
        (result externref)

        (global.set $wat4wasm (call $self.Array<>ext))
        
        (call $self.Reflect.set<ext.i32.i32>
            (global.get $wat4wasm) (i32.const 0) (i32.const ${size})
        )

        (global.set $wat4wasm
            (call $self.Reflect.construct<ext.ext>ext
                (ref.extern $self.Uint8Array<ext>)
                (global.get $wat4wasm)
            )
        )
        
        (if (i32.const ${size})
            (then
                (i32.const 0)
                (i64.load (i32.const 0))

                (block $copy
                    (i32.store (i32.const 0) (i32.const ${size}))
                    (loop $i--
                        (if (i32.load (i32.const 0))
                            (then   
                                (i32.store
                                    (i32.const 0)
                                    (i32.sub (i32.load (i32.const 0)) (i32.const 1))
                                )

                                (memory.init ${$name} 
                                    (i32.const 4) 
                                    (i32.load (i32.const 0)) 
                                    (i32.const 1)
                                )

                                (call $self.Reflect.set<ext.i32.i32>
                                    (global.get $wat4wasm)
                                    (i32.load (i32.const 0))
                                    (i32.load8_u (i32.const 4))
                                )

                                (br $i--)
                            )
                        )
                    )
                )

                (i64.store (; stack stack ;))
            )
        )

        
        (local.set $arguments (call $self.Array<>ext))
        
        (call $self.Reflect.set<ext.i32.ext>
          (local.get $arguments)
          (i32.const 0)
          (global.get $wat4wasm)
        )

        (call $self.Reflect.apply<ext.ext.ext>ext
            (local.get $textDecoder.decode)
            (local.get $textDecoder)
            (local.get $arguments) 
        )
            
        (global.set $wat4wasm (null))
    )
    `;
};

const GENERATE_HREF_VIEWER = (size, $name) => {
    return `
    (block ${$name}
        (result externref)

        (global.set $wat4wasm (call $self.Array<>ext))
        
        (call $self.Reflect.set<ext.i32.i32>
            (global.get $wat4wasm) (i32.const 0) (i32.const ${size})
        )

        (global.set $wat4wasm
            (call $self.Reflect.construct<ext.ext>ext
                (ref.extern $self.Uint8Array<ext>)
                (global.get $wat4wasm)
            )
        )
        
        (if (i32.const ${size})
            (then
                (i32.const 0)
                (i64.load (i32.const 0))

                (block $copy
                    (i32.store (i32.const 0) (i32.const ${size}))
                    (loop $i--
                        (if (i32.load (i32.const 0))
                            (then   
                                (i32.store
                                    (i32.const 0)
                                    (i32.sub (i32.load (i32.const 0)) (i32.const 1))
                                )

                                (memory.init ${$name} 
                                    (i32.const 4) 
                                    (i32.load (i32.const 0)) 
                                    (i32.const 1)
                                )

                                (call $self.Reflect.set<ext.i32.i32>
                                    (global.get $wat4wasm)
                                    (i32.load (i32.const 0))
                                    (i32.load8_u (i32.const 4))
                                )

                                (br $i--)
                            )
                        )
                    )
                )

                (i64.store (; stack stack ;))
            )
        )

        
        (local.set $arguments (call $self.Array<>ext))
        
        (call $self.Reflect.set<ext.i32.ext>
          (local.get $arguments)
          (i32.const 0)
          (global.get $wat4wasm)
        )

        (call $self.Reflect.set<ext.i32.ext>
            (local.get $arguments)
            (i32.const 0)
            (call $self.Reflect.apply<ext.ext.ext>ext
                (local.get $textDecoder.decode)
                (local.get $textDecoder)
                (local.get $arguments) 
            )
        )

        (call $self.Reflect.set<ext.i32.ext>
            (local.get $arguments)
            (i32.const 0)
            (call $self.Reflect.construct<ext.ext>ext
                (call $self.Reflect.get<ext.ext>ext (self) (string "Blob"))
                (local.get $arguments) 
            )
        )

        (call $self.Reflect.apply<ext.ext.ext>ext
            (call $self.Reflect.get<ext.ext>ext 
                (call $self.Reflect.get<ext.ext>ext (self) (string "URL"))
                (string "createObjectURL")
            )
            (null)
            (local.get $arguments) 
        )
            
        (global.set $wat4wasm (null))
    )
    `;
};

export default function (wat, WAT4WASM) {

    const maskSet = new helpers.MaskSet(wat);

    const externgetter = new Map();
    const segmentSizes = new Map();
    const sizeRequests = new Set();
    const viewRequests = new Set();
    const textRequests = new Set();
    const hrefRequests = new Set();

    while (maskSet.hasBlock("data.text")) {
        const block = maskSet.lastBlockOf("data.text");
        textRequests.add(block);
        maskSet.mask(block);
    }

    while (maskSet.hasBlock("data.href")) {
        const block = maskSet.lastBlockOf("data.href");
        hrefRequests.add(block);
        maskSet.mask(block);
    }

    while (maskSet.hasBlock("data.view")) {
        const block = maskSet.lastBlockOf("data.view");
        viewRequests.add(block);
        maskSet.mask(block);
    }

    while (maskSet.hasBlock("data.size")) {
        const block = maskSet.lastBlockOf("data.size");
        sizeRequests.add(block);
        maskSet.mask(block);
    }

    while (maskSet.hasBlock("data")) {

        const block = maskSet.lastBlockOf("data");
        const content = helpers.findQuotedText(block);

        maskSet.mask(block);
        if (helpers.hasProtocol(content) === false) {
            continue;
        }

        let {
            protocol, fullpath, directory,
            filename, basename, extension
        } = helpers.parseProtoPath(content);

        if (protocol === "wasm://") {

            const module_wat = `wat4wasm-${basename}.wat`;
            const wasm_output = `wat4wasm-${basename}.wasm`;
            const wat4wasm_out = `wat4wasm-${basename}.wasm.wat`;

            const params = process.argv
                .filter(a => a.startsWith("--"))
                .filter(a => !a.startsWith("--input="))
                .filter(a => !a.startsWith("--output="))
                ;

            helpers.copyFile(fullpath, module_wat)

            const wat4wasm = process.argv[1];
            const nodejs = process.argv[0];
            const argv = Array.of(
                wat4wasm,
                `--input=${module_wat}`,
                `--output=${wasm_output}`,
                `--no-unlink`
            ).concat(params);

            helpers.spawnSync(nodejs, argv);

            const { data, size } = helpers.readFileAsHex(wasm_output);

            segmentSizes.set(block.$name, size);
            maskSet.update(block, block.replace(content, data));

            helpers.unlinkFile(module_wat);
            helpers.unlinkFile(wasm_output);
            helpers.unlinkFile(wat4wasm_out);
        }

        else if (protocol === "file://") {
            const { data, size } = helpers.readFileAsHex(fullpath);
            segmentSizes.set(block.$name, size);
            maskSet.update(block, block.replace(content, data));
        }
    }

    sizeRequests.forEach(block => {
        const size = segmentSizes.get(block.$name);
        const code = `(i32.const ${size})`;

        maskSet.update(block, code);
    });

    viewRequests.forEach(block => {
        block.id = helpers.referenceId();
        maskSet.update(block, block.id);
    });

    textRequests.forEach(block => {
        block.id = helpers.referenceId();
        maskSet.update(block, block.id);
    });

    hrefRequests.forEach(block => {
        block.id = helpers.referenceId();
        maskSet.update(block, block.id);
    });

    wat = maskSet.restore();

    let oninit = String();

    viewRequests.forEach(block => {
        if (externgetter.has(block.$name) === false) {
            const size = segmentSizes.get(block.$name);
            const code = GENERATE_DATA_VIEWER(size, block.$name);

            const growRequest = WAT4WASM_GROW_EXTERN_TABLE(wat);
            block.tableSetter = growRequest.generateSetter(code);

            wat = growRequest.modifiedRaw;
            oninit = `${oninit}\n\n${block.tableSetter}\n\n`;

            externgetter.set(
                block.$name,
                growRequest.getter.concat(` ;; ${block.$name}\n`)
            );
        }
    });

    textRequests.forEach(block => {
        if (externgetter.has(block.$name) === false) {
            const size = segmentSizes.get(block.$name);
            const code = GENERATE_TEXT_VIEWER(size, block.$name);

            const growRequest = WAT4WASM_GROW_EXTERN_TABLE(wat);
            block.tableSetter = growRequest.generateSetter(code);

            wat = growRequest.modifiedRaw;
            oninit = `${oninit}\n\n${block.tableSetter}\n\n`;

            externgetter.set(
                block.$name,
                growRequest.getter.concat(` ;; ${block.$name}\n`)
            );
        }
    });

    hrefRequests.forEach(block => {
        if (externgetter.has(block.$name) === false) {
            const size = segmentSizes.get(block.$name);
            const code = GENERATE_HREF_VIEWER(size, block.$name);

            const growRequest = WAT4WASM_GROW_EXTERN_TABLE(wat);
            block.tableSetter = growRequest.generateSetter(code);

            wat = growRequest.modifiedRaw;
            oninit = `${oninit}\n\n${block.tableSetter}\n\n`;

            externgetter.set(
                block.$name,
                growRequest.getter.concat(` ;; ${block.$name}\n`)
            );
        }
    });

    viewRequests.forEach(block => {
        wat = wat.replaceAll(
            block.id, externgetter.get(block.$name)
        );
    });

    textRequests.forEach(block => {
        wat = wat.replaceAll(
            block.id, externgetter.get(block.$name)
        );
    });

    hrefRequests.forEach(block => {
        wat = wat.replaceAll(
            block.id, externgetter.get(block.$name)
        );
    });

    wat = APPEND_ON_EXTERN_READY(wat, oninit);

    return wat;
}