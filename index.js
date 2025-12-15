import wat4beauty from "wat4beauty"
import fs from "fs";

import { TableManager } from "./lib/TableManager.js";
import { InjectManager } from "./lib/InjectManager.js";
import { ScopeManager } from "./lib/ScopeManager.js";

import { setManagers as setManagers_resolveIncludes, resolveIncludes } from "./lib/resolveIncludes.js";
import { setManagers as setManagers_cleanComments, cleanComments } from "./lib/cleanComments.js";
import { setManagers as setManagers_standardLibrary, processSimpleMacros, getStandardImports } from "./lib/standardLibrary.js";
import { setManagers as setManagers_extractRefExtern, extractRefExtern, generateRefExternInfrastructure, resetRefExternPool } from "./lib/extractRefExtern.js";
import { setManagers as setManagers_extractTextBlocks, extractTextBlocks, generateTextSections, resetTextPool } from "./lib/extractTextBlocks.js";
import { setManagers as setManagers_extractStringBlocks, extractStringBlocks, generateStringInfrastructure, resetStringPool } from "./lib/extractStringBlocks.js";
import { setManagers as setManagers_injector, injectRuntimeLogic } from "./lib/injector.js";
import { setManagers as setManagers_processCustomTypes, processCustomTypes, resetCustomTypes } from "./lib/processCustomTypes.js";
import { setManagers as setManagers_processArrays, processArrays, generateArrayImports, resetArrayImports } from "./lib/processArrays.js";
import { setManagers as setManagers_processCallDirect, processCallDirect, generateDirectImports, resetDirectImports } from "./lib/processCallDirect.js";
import { setManagers as setManagers_processApply, processApply, generateApplyImports, resetApplyImports } from "./lib/processApply.js";
import { setManagers as setManagers_processGet, processGet, generateGetImports, resetGetImports } from "./lib/processGet.js";
import { setManagers as setManagers_processSet, processSet, generateSetImports, resetSetImports } from "./lib/processSet.js";
import { setManagers as setManagers_processNew, processNew, generateNewImports, resetNewImports } from "./lib/processNew.js";
import { setManagers as setManagers_processCallBound, processCallBound, generateBoundImports, generateBoundInitCodes, resetCallBound } from "./lib/processCallBound.js";
import { setManagers as setManagers_processRefFunc, processRefFunc } from "./lib/processRefFunc.js";

const ENTRY_FILE = "test.wat";
const OUTPUT_FILE = "output.wat";

function main() {
    try {
        console.log("🚀 Wat4Wasm: Derleme Başladı (Recursive Processing Mode)...\n");
        if (!fs.existsSync(ENTRY_FILE)) throw new Error("Dosya yok!");
        let rawCode = fs.readFileSync(ENTRY_FILE, "utf8");

        // --- 1. RESET ---
        // Her şeyi sıfırla ki üst üste binmesin (Idempotency)
        TableManager.reset();
        InjectManager.reset();

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

        TableManager.setManagers(InjectManager, ScopeManager);
        InjectManager.setManagers(TableManager, ScopeManager);
        ScopeManager.setManagers(TableManager, InjectManager);

        setManagers_resolveIncludes(TableManager, InjectManager, ScopeManager);
        setManagers_cleanComments(TableManager, InjectManager, ScopeManager);
        setManagers_standardLibrary(TableManager, InjectManager, ScopeManager);
        setManagers_extractRefExtern(TableManager, InjectManager, ScopeManager);
        setManagers_extractTextBlocks(TableManager, InjectManager, ScopeManager);
        setManagers_extractStringBlocks(TableManager, InjectManager, ScopeManager);
        setManagers_injector(TableManager, InjectManager, ScopeManager);
        setManagers_processCustomTypes(TableManager, InjectManager, ScopeManager);
        setManagers_processArrays(TableManager, InjectManager, ScopeManager);
        setManagers_processCallDirect(TableManager, InjectManager, ScopeManager);
        setManagers_processApply(TableManager, InjectManager, ScopeManager);
        setManagers_processGet(TableManager, InjectManager, ScopeManager);
        setManagers_processSet(TableManager, InjectManager, ScopeManager);
        setManagers_processNew(TableManager, InjectManager, ScopeManager);
        setManagers_processCallBound(TableManager, InjectManager, ScopeManager);
        setManagers_processRefFunc(TableManager, InjectManager, ScopeManager);

        let processedCode = rawCode;

        processedCode = resolveIncludes(processedCode);
        processedCode = processSimpleMacros(processedCode);
        processedCode = cleanComments(processedCode);
        processedCode = processCustomTypes(processedCode);
        processedCode = processCallBound(processedCode, extractRefExtern);
        processedCode = extractRefExtern(processedCode);
        processedCode = processCallDirect(processedCode);
        processedCode = processApply(processedCode);
        processedCode = processGet(processedCode);
        processedCode = processSet(processedCode);
        processedCode = processNew(processedCode);
        processedCode = processArrays(processedCode);
        processedCode = extractTextBlocks(processedCode);
        processedCode = extractStringBlocks(processedCode);
        processedCode = extractTextBlocks(processedCode);
        processedCode = processRefFunc(processedCode);

        generateRefExternInfrastructure();
        generateBoundInitCodes();
        generateTextSections();

        processedCode = TableManager.updateWAT(processedCode);
        processedCode = InjectManager.updateWAT(processedCode);
        processedCode = ScopeManager.updateWAT(processedCode);

        // --- 5. ÇIKTI BİRLEŞTİRME ---
        // Text/Data bölümünü oluştur (Artık hem ana koddan hem init kodlarından gelenler burada)

        const stringInfrastructure = generateStringInfrastructure();
        const tableDef = TableManager.generateTableDefinition();

        // Tüm Importları Topla
        const allImports = `
        ${getStandardImports()}
        ${stringInfrastructure.imports}
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
        `;

        // Init Bloklarını Birleştir
        // Sıralama: Assetler -> Ref Extern (Ağaç) -> Call Bound -> ...
        const combinedInitBlock = `
        ${stringInfrastructure.initBlock}
        `;

        const extrafuncs = ``;

        // --- 6. ENJEKSİYON ---
        console.log("💉 Final kod enjekte ediliyor...");
        const finalWat = injectRuntimeLogic(
            processedCode,
            combinedInitBlock,
            "", // tableDef'i yukarıda topLevelDefinitions içine aldık veya burada birleştirebiliriz
            topLevelDefinitions, // Import parametresini "Top Level Definitions" olarak kullanıyoruz
            extrafuncs,
            `
                ${stringInfrastructure.bootstrapLocals}
            `.trim()// Injector bu değişkenleri fonksiyonun başına ekleyecek
        );

        fs.writeFileSync(OUTPUT_FILE, wat4beauty(finalWat));
        console.log(`\n✅ BAŞARILI! Çıktı: ${OUTPUT_FILE}`);

    } catch (err) {
        console.error("\n💥 HATA:", err.message);
    }
}

main();