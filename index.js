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

        //if (!i) { console.log("\n♻️  cycle (", ++ci, ") started..") }

        wat4 = f(wat, WAT4WASM, imports)
        llen = (wat4.length - wat.length);

        if (llen > 0) { llen = `\x1b[32m+ ${llen}\x1b[0m` }
        else if (llen < 0) { llen = `\x1b[33m- ${llen * -1}\x1b[0m` }
        else { llen = `\x1b[35m· ${llen}\x1b[0m` }

        if (wat4.length - wat.length) {
            console.log(`👀 ƒ( ${scripts[i].substr(0, scripts[i].length - 3).padEnd(10, " ")} )`.padStart(15, " ").concat(` =`), llen, "\t\t", wat.length, "->", wat4.length);
        }

        if (wat4.length !== wat.length) { c++ }

        if (!imports[i + 1]) {
            if (c) {
                i = -1; c = 0;
                //console.log("\n♻️ cycle has changes, reloading..")
            }
            else {
                console.log("☘️  untouched raw \x1b[32m-->\x1b[0m finalizing..")
            }
        }

        wat = wat4;
    }

    return wat;
});