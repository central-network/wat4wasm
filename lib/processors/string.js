import helpers from "../helpers.js"

export const BLOCK_NAME = "string";

export default function (wat) {

    while (helpers.hasBlock(wat, BLOCK_NAME)) {

        let oldBlock = helpers.lastBlockOf(wat, BLOCK_NAME);
        const string = helpers.findQuotedText(oldBlock);
        const ccodes = helpers.encodeString(string);
        const beauty = helpers.beautify(`
            (block ;; "${helpers.abstract(string)}"
                (result externref)
                (global.set $wat4wasm (call $self.Array<>ext))
                
                ${ccodes
                .map((c, i) => `(global.get $wat4wasm) (i32.const ${i}) (i32.const ${c})`)
                .map((args) => `(call $self.Reflect.set<ext.i32.i32> ${args})`)
                .join("\n")}

                (call $self.Reflect.apply<ext.ext.ext>ext
                    (global.get $self.String.fromCharCode) 
                    (ref.null extern) 
                    (global.get $wat4wasm)
                )

                (global.set $wat4wasm (null))
            )
        `);

        wat = oldBlock.replacedRaw(beauty);
    }

    return wat;
}