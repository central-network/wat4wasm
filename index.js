import fs from "fs";
import wat4beauty from "wat4beauty"

import { resolveIncludes } from "./lib/resolveIncludes.js";
import { processSimpleMacros, getStandardImports } from "./lib/standardLibrary.js";
import { extractRefExtern, generateRefExternInfrastructure, resetRefExternPool } from "./lib/extractRefExtern.js";
import { extractTextBlocks, generateTextSections, resetTextPool } from "./lib/extractTextBlocks.js";
import { extractStringBlocks } from "./lib/extractStringBlocks.js";
import { TableManager } from "./lib/TableManager.js";
import { injectRuntimeLogic } from "./lib/injector.js";

// --- YENİ MİSAFİRLERİMİZ ---
import { processCustomTypes, resetCustomTypes } from "./lib/processCustomTypes.js";
import { processArrays, generateArrayImports, resetArrayImports } from "./lib/processArrays.js";
import { processApply } from "./lib/processApply.js";
import { cleanComments } from "./lib/cleanComments.js";

const ENTRY_FILE = "test.wat";
const OUTPUT_FILE = "output.wat";

function main() {
    try {
        console.log("🚀 Wat4Wasm: Derleme Başladı (Type & Array Modu)...\n");
        if (!fs.existsSync(ENTRY_FILE)) throw new Error("Dosya yok!");

        // Temizlik
        TableManager.reset();
        resetTextPool();
        resetRefExternPool();
        resetCustomTypes();  // YENİ
        resetArrayImports(); // YENİ

        let rawCode = fs.readFileSync(ENTRY_FILE, "utf8");

        // 1. Pre-Process & Macros
        let processedCode = resolveIncludes(rawCode);
        processedCode = processSimpleMacros(processedCode);

        // 2. Text Extraction (Önce textleri saklayalım)
        processedCode = extractTextBlocks(processedCode);

        // 3. Ref Extern & Strings
        console.log("🔗 Referanslar ve Stringler işleniyor...");
        processedCode = extractRefExtern(processedCode);
        processedCode = extractStringBlocks(processedCode);

        // Yorumları şimdi silebiliriz ki Apply/Array parser'ları şaşırmasın.
        console.log("🧹 Yorum satırları temizleniyor...");
        processedCode = cleanComments(processedCode);

        // 4. CUSTOM TYPES (YENİ - Array işleminden önce çalışmalı!)
        console.log("🏷️  Özel tipler (type ...) çözülüyor...");
        processedCode = processCustomTypes(processedCode);

        // 4. APPLY (Standard WASM Style)
        console.log("⚡ (apply ...) blokları (standard style) dönüştürülüyor...");
        processedCode = processApply(processedCode);

        // 5. ARRAY SUGAR (YENİ - Apply işleminden önce çalışmalı)
        console.log("📦 Array tanımları (Array.of) dönüştürülüyor...");
        processedCode = processArrays(processedCode);

        // 6. Çıktı Üretimi
        const { dataBlock, initBlock: assetsInitBlock } = generateTextSections();
        const { initBlock: refInitBlock, bootstrapLocals } = generateRefExternInfrastructure();
        const tableDef = TableManager.generateTableDefinition();
        const standardImports = getStandardImports();
        const arrayImports = generateArrayImports(); // YENİ

        // 7. Init Bloklarını Birleştir
        const combinedInitBlock = `
        ${assetsInitBlock}
        ${refInitBlock}
        `;

        // 8. Importları Birleştir
        const allImports = `
        ${standardImports}
        ${arrayImports} 
        `;

        // 9. Enjeksiyon
        console.log("💉 Final kod enjekte ediliyor...");
        const finalWat = injectRuntimeLogic(
            processedCode,
            dataBlock,
            combinedInitBlock,
            tableDef,
            allImports,
            "",
            bootstrapLocals
        );

        fs.writeFileSync(OUTPUT_FILE, wat4beauty(finalWat));
        console.log(`\n✅ BAŞARILI! Çıktı: ${OUTPUT_FILE}`);

    } catch (err) {
        console.error("\n💥 HATA:", err.message);
    }
}

main();