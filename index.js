#!/usr/bin/env node

import fs from "fs";
import { processCLI } from "./lib/cli.js";

const pcs_dir = "./lib/processors";
const scripts = fs.readdirSync(pcs_dir);
const imports = await Array.fromAsync(scripts.map(file => import(`${pcs_dir}/${file}`).then(p => p.default)));

console.log(imports)

processCLI(async wat4 => {
    let wat = wat4, pi;
    console.log({ wat4 })

    while (imports.some((p, i) => [pi = i] && (wat4 !== (wat = p(wat))))) {
        console.warn(`ƒ( ${scripts[pi].substr(0, scripts[pi].length - 3).padEnd(7, " ")} )`.padStart(15, " ").concat(` =`), wat4.length - wat.length, "\t", wat.length, "->", wat4.length);
        wat4 = wat;
    }

    return wat;
});