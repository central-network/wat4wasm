import fs from "fs";
import { WatCompiler } from "./wat4wasm.js";

const [
    ENTRY_FILE = "",
    OUTPUT_FILE = ENTRY_FILE.replace(".wat", "-output.wat")
] = Array.from(process.argv).filter(a => a.endsWith(".wat")).map(f => f.split("=").pop() || f);

if (!ENTRY_FILE) {
    throw "entry file required!"
}

console.log({
    ENTRY_FILE, OUTPUT_FILE
});

function main() {
    try {
        console.log("🚀 Wat4Wasm: Compilation Started (Consolidated Mode)...\n");
        if (!fs.existsSync(ENTRY_FILE)) throw new Error("File not found!");
        else {
            const rawCode = fs.readFileSync(ENTRY_FILE, "utf8");
            const compiler = new WatCompiler();
            const compiled = compiler.compile(rawCode);
            fs.writeFileSync(OUTPUT_FILE, compiled);
            console.log(`✅ Compilation successful.`);
        }
    } catch (err) {
        console.error(`\n 💥 ERROR:\n`, err);
    }
}

main();