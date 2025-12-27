#!/usr/bin/env node

import fs from "fs";
import { processCLI } from "./lib/cli.js";

const pcs_dir = "./lib/processors";
const scripts = fs.readdirSync(pcs_dir);
const wat4pcs = scripts.indexOf("wat4wasm.js");

scripts.splice(wat4pcs, 1);
scripts.unshift("wat4wasm.js");

const imports = await Array.fromAsync(scripts.map(file => import(`${pcs_dir}/${file}`).then(p => Object.assign(p.default, p))));
const WAT4WASM = imports[0];

processCLI(async wat4 => {
    let wat = wat4, f, i = -1, llen, m = -1, c = 0, ci = 0;

    while (f = imports[++i]) {
        wat4 = f(wat, WAT4WASM);

        const input = wat;
        const output = wat4;
        const inLines = input.split("\n").map(l => l.trim()).filter(Boolean);
        const outLines = output.split("\n").map(l => l.trim()).filter(Boolean);

        let startCommon = 0;
        while (
            startCommon < inLines.length &&
            startCommon < outLines.length &&
            inLines[startCommon] === outLines[startCommon]
        ) { startCommon++; }

        let endCommon = 0;
        while (
            endCommon < inLines.length - startCommon &&
            endCommon < outLines.length - startCommon &&
            inLines[inLines.length - 1 - endCommon] === outLines[outLines.length - 1 - endCommon]
        ) { endCommon++; }

        const commonLines = startCommon + endCommon;
        const removedLines = inLines.length - commonLines;
        const addedLines = outLines.length - commonLines;
        const netChange = outLines.length - inLines.length;

        const stat = [
            `\x1b[32m+${addedLines}\x1b[0m`.padStart(15, " "),
            `\x1b[34m-${removedLines}\x1b[0m`.padStart(15, " "),
            `\x1b[${netChange && 36 || 33}m\u0394\x1b[0m`.padStart(12, " "),
            `\x1b[${netChange && 36 || 33}m${netChange}\x1b[0m`.padStart(12, " "),
            `  byte(\u03B4) :`,
            `\x1b[33m${wat.length}\x1b[0m`.padStart(14, " "),
            `-->`,
            `\x1b[33m${wat4.length}\x1b[0m`,
        ];

        if (wat !== wat4) {
            c++;
            wat = wat4;
            console.log(`👀 ƒ( ${scripts[i].substr(0, scripts[i].length - 3).padEnd(10, " ")} )`.padStart(15, " "), ...stat);
        }

        if (!imports[i + 1]) {
            if (c) { i = -1; c = 0; }
            else { console.log("☘️  untouched raw \x1b[32m-->\x1b[0m finalizing..") }
        }
    }

    return wat;
});