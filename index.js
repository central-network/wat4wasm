import wat4beauty from "wat4beauty"

import fs from "fs";
import { TableManager } from "./lib/TableManager.js";
import { resolveIncludes } from "./lib/resolveIncludes.js";
import { cleanComments } from "./lib/cleanComments.js";
import { processSimpleMacros, getStandardImports } from "./lib/standardLibrary.js";
import { extractRefExtern, generateRefExternInfrastructure, resetRefExternPool } from "./lib/extractRefExtern.js";
import { extractTextBlocks, generateTextSections, resetTextPool } from "./lib/extractTextBlocks.js";
import { extractStringBlocks, generateStringInfrastructure, resetStringPool } from "./lib/extractStringBlocks.js";
import { injectRuntimeLogic } from "./lib/injector.js";
import { processCustomTypes, resetCustomTypes } from "./lib/processCustomTypes.js";
import { processArrays, generateArrayImports, resetArrayImports } from "./lib/processArrays.js";
import { processCallDirect, generateDirectImports, resetDirectImports } from "./lib/processCallDirect.js";
import { processApply, generateApplyImports, resetApplyImports } from "./lib/processApply.js";
import { processGet, generateGetImports, resetGetImports } from "./lib/processGet.js";
import { processSet, generateSetImports, resetSetImports } from "./lib/processSet.js";
import { processNew, generateNewImports, resetNewImports } from "./lib/processNew.js";
import { processCallBound, generateBoundImports, getBoundInitCodes, resetCallBound } from "./lib/processCallBound.js";
import { processRefFunc } from "./lib/processRefFunc.js";

const ENTRY_FILE = "test.wat";
const OUTPUT_FILE = "output.wat";

function main() {
    try {
        console.log("🚀 Wat4Wasm: Derleme Başladı (Recursive Processing Mode)...\n");
        if (!fs.existsSync(ENTRY_FILE)) throw new Error("Dosya yok!");

        // --- 1. RESET ---
        // Her şeyi sıfırla ki üst üste binmesin (Idempotency)
        TableManager.reset();
        resetTextPool();
        resetStringPool();
        resetRefExternPool();
        resetCustomTypes();
        resetArrayImports();
        resetDirectImports();
        resetApplyImports();
        resetGetImports();
        resetSetImports();
        resetNewImports();
        resetCallBound();

        let rawCode = fs.readFileSync(ENTRY_FILE, "utf8");

        // --- 2. PRE-PROCESS ---
        let processedCode = resolveIncludes(rawCode);
        processedCode = processSimpleMacros(processedCode);
        // Önce yorumları sil, yapıları bozmasın
        processedCode = cleanComments(processedCode);

        // --- 3. STRUCTURE PROCESSING (Yapısal İşlemler) ---
        // Bu aşamada init kodları ve importlar hafızada (RAM) birikiyor.
        console.log("🏗️ Yapısal analiz yapılıyor...");
        processedCode = processCustomTypes(processedCode);

        // Call Bound (Init kodları içinde (text...) üretecek)
        processedCode = processCallBound(processedCode, TableManager, extractRefExtern);

        // Referans Ağacını Kur (Init kodları içinde (text...) üretecek)
        processedCode = extractRefExtern(processedCode, TableManager);

        // Diğer makrolar
        processedCode = processCallDirect(processedCode);
        processedCode = processApply(processedCode);
        processedCode = processGet(processedCode);
        processedCode = processSet(processedCode);
        processedCode = processNew(processedCode);

        // En son arrayler (iç içe yapıları çözmek için)
        processedCode = processArrays(processedCode);

        // --- 4. ARA DERLEME (CRITICAL STEP) 🚨 ---
        // Burası senin sorunu çözen yer aşkım!

        // A. Ana koddaki (text ...) bloklarını topla
        processedCode = extractTextBlocks(processedCode, TableManager);

        // B. Üretilen Init kodlarını al (RefExtern ve CallBound'dan)
        const externInfrastructure = generateRefExternInfrastructure(TableManager);
        const boundInitCodeRaw = getBoundInitCodes();

        // D. String bloklarını (string ...) işle (Eğer hala varsa)
        processedCode = extractStringBlocks(processedCode, TableManager);

        // C. BU KODLARI DA İŞLE! (Recursive Compilation)
        // Init kodlarının içinde geçen (text "Array") gibi ifadeleri (table.get ID) ye çevir.
        // extractTextBlocks fonksiyonu zaten global TEXT_POOL'u kullandığı için sorun yok.

        let finalRefInitBlock = extractTextBlocks(externInfrastructure.initBlock, TableManager);
        let finalBoundInitCode = extractTextBlocks(boundInitCodeRaw, TableManager);

        const { source: finalSource, elemBlock } = processRefFunc(processedCode);
        processedCode = finalSource;

        // --- 5. ÇIKTI BİRLEŞTİRME ---
        // Text/Data bölümünü oluştur (Artık hem ana koddan hem init kodlarından gelenler burada)
        const { dataBlock, initBlock: assetsInitBlock } = generateTextSections();

        const stringInfrastructure = generateStringInfrastructure();
        const tableDef = TableManager.generateTableDefinition();

        // Tüm Importları Topla
        const allImports = `
        ${getStandardImports()}
        ${stringInfrastructure.imports}
        ${externInfrastructure.bootstrapLocals ? "" : ""} 
        ${generateArrayImports()}
        ${generateDirectImports()}
        ${generateApplyImports()}
        ${generateGetImports()}
        ${generateSetImports()}
        ${generateNewImports()}
        ${generateBoundImports()}
        `;

        // Trick: allImports değişkeninin sonuna ekleyebiliriz, çünkü WAT formatında importlar ve elemler top-leveldir.
        const topLevelDefinitions = `
        ${allImports}
        ${tableDef} 
        ${elemBlock} 
        `;

        // Init Bloklarını Birleştir
        // Sıralama: Assetler -> Ref Extern (Ağaç) -> Call Bound -> ...
        const combinedInitBlock = `
        ${stringInfrastructure.initBlock}

        ${assetsInitBlock}
        ${finalRefInitBlock}
        ${finalBoundInitCode}
        `;

        const extrafuncs = ``;

        // --- 6. ENJEKSİYON ---
        console.log("💉 Final kod enjekte ediliyor...");
        const finalWat = injectRuntimeLogic(
            processedCode,
            dataBlock,
            combinedInitBlock,
            "", // tableDef'i yukarıda topLevelDefinitions içine aldık veya burada birleştirebiliriz
            topLevelDefinitions, // Import parametresini "Top Level Definitions" olarak kullanıyoruz
            extrafuncs,
            `
                ${stringInfrastructure.bootstrapLocals}
                ${externInfrastructure.bootstrapLocals}
            `.trim()// Injector bu değişkenleri fonksiyonun başına ekleyecek
        );

        fs.writeFileSync(OUTPUT_FILE, wat4beauty(finalWat));
        console.log(`\n✅ BAŞARILI! Çıktı: ${OUTPUT_FILE}`);

    } catch (err) {
        console.error("\n💥 HATA:", err.message);
    }
}

main();