#!/usr/bin/env node

import { processCLI } from "./lib/cli.js";
import { WatCompiler } from "./wat4wasm.js";

const compiler = new WatCompiler();

processCLI((source) => {
    return compiler.compile(source);
});