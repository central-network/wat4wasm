
import { WatSignature } from "./lib/signature.js";
import { WatParser } from "./lib/parser.js";
import { WatBlock } from "./lib/block.js";

console.log("--- Signature Tests ---");

const cases = [
    {
        name: "Complex User Example",
        nameSig: "<i32.ext>ext",
        blockSig: "(param i32 externref) (result externref)"
    },
    {
        name: "Empty Params",
        nameSig: "<>f32",
        blockSig: "(result f32)"
    },
    {
        name: "Multiple Params/Results",
        nameSig: "<i32.i32>i64.i64", // hypothetical
        blockSig: "(param i32 i32) (result i64 i64)"
    },
    {
        name: "Named Params Parsing",
        rawFunc: "(func $test (param $a i32) (param $b f32) (result f64))",
        expectedNameSig: "<i32.f32>f64"
    }
];

cases.forEach(c => {
    console.log(`\nTest Case: ${c.name}`);
    const sig1 = new WatSignature();
    const sig2 = new WatSignature();

    if (c.nameSig) {
        sig1.fromNameSig(c.nameSig);
        console.log(`  fromNameSig('${c.nameSig}') ->`);
        console.log(`    toBlockSig: '${sig1.toBlockSig()}'`);
        console.log(`    toNameSig : '${sig1.toNameSig()}'`);

        let match = true;
        if (c.blockSig && sig1.toBlockSig() !== c.blockSig) match = false;
        console.log(`    Match Expected BlockSig: ${match ? "OK" : `FAIL (Got '${sig1.toBlockSig()}')`}`);
    }

    if (c.rawFunc) {
        // Parse block first
        const p = new WatParser(c.rawFunc);
        const parsed = p.parse()[0];
        const block = new WatBlock(parsed);
        // Extract sig children
        sig2.fromBlockSig(block.blockSig);
        console.log(`  fromBlockSig('${c.rawFunc}') ->`);
        console.log(`    toNameSig : '${sig2.toNameSig()}'`);
        console.log(`    toBlockSig: '${sig2.toBlockSig()}'`);

        if (c.expectedNameSig) {
            const match = sig2.toNameSig() === c.expectedNameSig;
            console.log(`    Match Expected NameSig: ${match ? "OK" : `FAIL (Got '${sig2.toNameSig()}')`}`);
        }
    }
});
