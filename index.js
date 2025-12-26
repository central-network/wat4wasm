#!/usr/bin/env node

import fs from "fs";
import { processCLI } from "./lib/cli.js";
import $text from "./lib/text.js";
import $imports from "./lib/processors/import.js";

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

        wat4 = f(wat, WAT4WASM, imports);

        const input = wat;
        const output = wat4;

        const inLines = input.split("\n").map(l => l.trim()).filter(Boolean);
        const outLines = output.split("\n").map(l => l.trim()).filter(Boolean);

        // 1. Baştan kaç satır aynı? (Prefix)
        let startCommon = 0;
        while (
            startCommon < inLines.length &&
            startCommon < outLines.length &&
            inLines[startCommon] === outLines[startCommon]
        ) {
            startCommon++;
        }

        // 2. Sondan kaç satır aynı? (Suffix)
        // Not: Başlangıçtaki ortak kısımla çakışmamasına dikkat etmeliyiz.
        let endCommon = 0;
        while (
            endCommon < inLines.length - startCommon &&
            endCommon < outLines.length - startCommon &&
            inLines[inLines.length - 1 - endCommon] === outLines[outLines.length - 1 - endCommon]
        ) {
            endCommon++;
        }

        // Toplam değişmeyen satır sayısı
        const totalCommonLines = startCommon + endCommon;

        // Hesaplamalar
        // Silinenler: Orijinal satır sayısından ortak olanları çıkar
        const removedLines = inLines.length - totalCommonLines;

        // Eklenenler: Yeni satır sayısından ortak olanları çıkar
        const addedLines = outLines.length - totalCommonLines;

        // Net değişim (Sizin appendedLines dediğiniz)
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
            if (c) {
                i = -1; c = 0;
                //console.log("\n♻️ cycle has changes, reloading..")
            }
            else {
                console.log("☘️  untouched raw \x1b[32m-->\x1b[0m finalizing..")
            }
        }
    }

    wat = $text(wat, WAT4WASM);
    wat = $imports(wat, WAT4WASM);
    wat = $text(wat, WAT4WASM);

    return wat;
});