import fs from "fs";
import { WatParser } from "./lib/parser.js";
import { WatBlock } from "./lib/block.js";

const userExample = `(call.i32 $self.console.log<i32.ext>ext (param i32 ext) (result ext) (i32.const 1) (local.get $ext) externref)`;

console.log("--- User Example Analysis ---");
const parser = new WatParser(userExample);
const parsed = parser.parse()[0]; // It's a single expression
const block = new WatBlock(parsed);


console.log("Raw:", block.raw);
console.log("BlockTag:", block.blockTag);
console.log("BlockSubTag:", block.blockSubTag);
console.log("NamePath:", block.namePath);
console.log("$Name:", block.$name);
console.log("NameSig:", block.nameSig);
console.log("BlockSig:", block.blockSigString);
console.log("BlockContentType:", block.blockContentType);
console.log("BlockContent:", block.blockContentString);

console.log("\n--- Comparison with Requirement ---");
const expected = {
    blockTag: "call",
    blockSubTag: "i32",
    namePath: "self.console.log",
    $name: "$self.console.log<i32.ext>ext",
    nameSig: "<i32.ext>ext",
    blockSig: "(param i32 ext) (result ext)",
    blockContentType: "externref",
    blockContent: "(i32.const 1) (local.get $ext)",
};

for (const [key, val] of Object.entries(expected)) {
    const got = key === 'blockSig' ? block.blockSigString :
        key === 'blockContent' ? block.blockContentString :
            block[key];
    const match = got === val;
    console.log(`${key.padEnd(16)}: Expected='${val}' Got='${got}' [${match ? "OK" : "FAIL"}]`);
}

const testContent = fs.readFileSync("test.wat", "utf8");

// Extract the content inside (; ... ;) block
// Assuming there is only one big block comment or we take the first one that matches our known examples
const match = testContent.match(/\(;([\s\S]*?);\)/);

if (!match) {
    console.error("Could not find the comment block in test.wat");
    process.exit(1);
}

const rawBlock = match[1];
console.log("--- Extracted Block Content ---");
// console.log(rawBlock);

console.log("\n--- Parsing Results ---");

const blockParser = new WatParser(rawBlock);
const results = blockParser.parse();

console.table(results.map(r => ({
    Op: r.op || "(anon)",
    Args: r.args.join(", "),
    Children: r.children.length
})));

// Detailed Dump for complex types
console.log("\n--- Detailed Objects ---");
results.forEach(r => {
    // console.log(JSON.stringify(r, null, 2));

    // Custom pretty print
    const args = r.args.length ? `Args: [${r.args.join(", ")}]` : "";
    const children = r.children.length ? `Children: ${r.children.map(c => c.op).join(", ")}` : "";
    console.log(`[${r.op}] ${args} ${children}`);
    if (r.op === "text") {
        console.log(`   Value: ${r.args[0]}`);
    }
});
