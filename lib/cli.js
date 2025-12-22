
import fs from "fs";
import { spawnSync } from "child_process";
import wat4beauty from "wat4beauty"

export async function processCLI(compileCallback) {

    console.log("\x1b[31m")
    // Argument Parsing Logic
    const args = process.argv.slice(2);
    const config = {
        inputFile: null,
        outputFile: null,
        wat2wasmPath: null,
        unlinkWat4FileIfCompilationSuccess: true,
        printOnly: false,
        passthroughArgs: []
    };

    for (let i = 0; i < args.length; i++) {
        const arg = args[i];
        if (arg.startsWith("--output=")) {
            config.outputFile = arg.split("=")[1];
        } else if (arg.startsWith("--wat2wasm=")) {
            config.wat2wasmPath = arg.split("=")[1];
        } else if (arg === "--print-only") {
            config.printOnly = true;
        } else if (arg === "--no-unlink") {
            config.unlinkWat4FileIfCompilationSuccess = false;
        } else if (arg.startsWith("-")) {
            // Collect flags to pass to wat2wasm
            config.passthroughArgs.push(arg);
        } else {
            if (!config.inputFile) {
                config.inputFile = arg;
            } else {
                console.warn(`Warning: Ignoring extra argument '${arg}'`);
            }
        }
    }

    if (!config.inputFile) {
        console.error("Error: Input file required! Usage: wat4wasm <input.wat> [options]");
        process.exit(1);
    }

    // Default output file if not specified (and not printing only)
    if (!config.outputFile && !config.printOnly) {
        config.outputFile = config.inputFile.replace(/\.wat$/, "-output.wat");
    }

    console.log("\x1b[0m")

    try {
        console.log("\x1b[33m")
        console.log(`🚀 Wat4Wasm: Processing ${config.inputFile}...`);
        if (!fs.existsSync(config.inputFile)) {
            throw new Error(`Input file not found: ${config.inputFile}`);
        }

        const rawCode = fs.readFileSync(config.inputFile, "utf8");

        // 2. Call the provided compile function
        console.log("\x1b[0m")
        const compiled = compileCallback(rawCode);
        console.log("\x1b[33m")

        // 3. Handle Output
        if (config.printOnly) {
            console.log("--- Compiled Output ---");
            console.log(compiled);
            console.log("-----------------------");
            return;
        }

        // Write compiled WAT (or temp WAT for WASM target)
        let watFile = config.outputFile;
        let wasmFile = config.outputFile;
        const isWasmTarget = config.outputFile.endsWith(".wasm") || config.wat2wasmPath;

        if (isWasmTarget && config.outputFile.endsWith(".wasm")) {
            // If target is WASM, write WAT to a temp file
            watFile = config.outputFile + ".wat";
        }

        fs.writeFileSync(watFile, wat4beauty(compiled));
        console.log(`✅ WAT Written to: ${watFile}`);

        // Run wat2wasm if requested
        if (config.wat2wasmPath) {
            console.log(`🔨 Running wat2wasm...`);

            // If user explicitly set .wasm output but output file was .wat? 
            // The logic above sets wasmFile = config.outputFile.
            // If config.outputFile was "out.wat", then we overwrite it with "out.wasm"? 
            // Standard wat2wasm behavior takes -o <file>.
            // Our config.outputFile came from --output.

            const cmdArgs = [watFile, ...config.passthroughArgs, "--output", wasmFile];
            console.log(`   Command: ${config.wat2wasmPath} ${cmdArgs.join(" ")}`);

            const result = spawnSync(config.wat2wasmPath, cmdArgs, { stdio: "inherit" });

            if (result.status === 0) {
                console.log(`🎉 WASM Build Successful: ${wasmFile}`);
                if (config.unlinkWat4FileIfCompilationSuccess && watFile !== wasmFile) {
                    try { fs.unlinkSync(watFile); } catch (e) { }
                }
            } else {
                console.error(`💥 wat2wasm failed with exit code ${result.status}`);
                process.exit(result.status);
            }
        }

    } catch (err) {
        console.error(`\n💥 ERROR:`, err);
        process.exit(1);
    } finally {
        console.log("\x1b[0m")
    }
}
