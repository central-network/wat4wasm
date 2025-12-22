
import { WatParser } from "./lib/parser.js";
import { WatBlock } from "./lib/block.js";

console.log("--- Import Generation Verification ---");

const tests = [
    {
        name: "Call with NameSig",
        wat: "(call $self.console.log<i32>)",
        expected: '(import "console" "log" (func $self.console.log<i32> (param i32)))'
    },
    {
        name: "Call with BlockSig (reconstruct sig)",
        wat: "(call $self.foo (param i32))",
        expected: '(import "env" "foo" (func $self.foo<i32> (param i32)))' // Assuming env for single part
    },
    {
        name: "Global Get with Type",
        wat: "(global.get $self.console.log i32)",
        expected: '(import "console" "log" (global $self.console.log i32))'
    },
    {
        name: "Global Get Default Type",
        wat: "(global.get $self.console.log)",
        expected: '(import "console" "log" (global $self.console.log externref))'
    },
    {
        name: "Ref Extern Default",
        wat: "(ref.extern $self.window)",
        expected: '(import "env" "window" (global $self.window externref))'
    }
];

tests.forEach(test => {
    console.log(`\nCase: ${test.name}`);
    console.log(`  Input: ${test.wat}`);
    const parsed = new WatParser(test.wat).parse()[0];
    const block = new WatBlock(parsed);
    const generated = block.generateImportCode();

    // Normalization might be needed (extra spaces etc)
    const normGen = generated ? generated.replace(/\s+/g, " ").trim() : "NULL";
    const normExp = test.expected.replace(/\s+/g, " ").trim();

    const passed = normGen === normExp;
    console.log(`  Gen  : ${normGen}`);
    if (!passed) console.log(`  Exp  : ${normExp}`);
    console.log(`  Result: ${passed ? "PASS" : "FAIL"}`);
});
