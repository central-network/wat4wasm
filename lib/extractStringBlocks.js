// lib/extractStringBlocks.js
import { TableManager } from "./TableManager.js";

const STRING_POOL = [];

/**
 * 1. ADIM: (string "...") bloklarını bul, tabloya kaydet ve getter ile değiştir.
 */
export function extractStringBlocks(watSource) {
    const stringRegex = /\(string\s+"((?:[^"\\]|\\.)*)"\s*\)/gs;

    return watSource.replace(stringRegex, (match, rawContent) => {
        let entry = STRING_POOL.find(e => e.rawContent === rawContent);

        // Eğer havuzda yoksa (Deduplication)
        if (!entry) {
            // 1. Tablodan yer ayırt
            const tableIndex = TableManager.reserveIndex();

            // 2. Metni parse et
            let realStr;
            try { realStr = JSON.parse(`"${rawContent}"`); }
            catch (e) { realStr = rawContent; }

            // 3. Karakterleri "call Reflect.set" komutlarına çevir
            const charSetters = realStr.split('').map((char, charIndex) => {
                const charCode = char.charCodeAt(0);
                // Not: Burada $__str_tmp adında geçici bir local kullanacağız
                return `        (call $self.Reflect.set<ref.i32.i32> (local.get $__str_tmp) (i32.const ${charIndex}) (i32.const ${charCode}))`;
            }).join('\n');

            // 4. Start fonksiyonu içinde çalışacak kod bloğunu hazırla
            // Block (result externref) kullanarak işlemi izole ediyoruz
            const constructionCode = `
        (block 
            (result externref)
            ;; A. Boş Array oluştur (arguments)
            (local.set $__str_tmp 
                (call $self.Reflect.ownKeys<ref>ref (global.get $self.String.fromCharCode))
            )
            ;; B. Karakterleri doldur
            ${charSetters}
            ;; C. String'i oluştur ve bloğun sonucu olarak döndür
            (call $self.Reflect.apply<ref.ref.ref>ref 
                (global.get $self.String.fromCharCode) 
                (ref.null externref) 
                (local.get $__str_tmp)
            )
        )
        `;

            // 5. Tabloya yazma emri: (table.set INDEX (BLOCK...))
            const initCode = TableManager.generateSetter(tableIndex, constructionCode);

            entry = { rawContent, tableIndex, initCode };
            STRING_POOL.push(entry);
        }

        // Yerine (table.get ...) koy
        return TableManager.generateGetter(entry.tableIndex);
    });
}

/**
 * 2. ADIM: Start fonksiyonuna ve Modüle eklenecekleri döndür
 */
export function generateStringInfrastructure() {
    if (STRING_POOL.length === 0) {
        return { imports: "", initBlock: "", bootstrapLocals: "" };
    }

    // A. Importlar
    const imports = `
    ;; --- String API Imports ---
    (import "Reflect" "ownKeys" (func $self.Reflect.ownKeys<ref>ref (param externref) (result externref))) 
    (import "Reflect" "set" (func $self.Reflect.set<ref.i32.i32> (param externref i32 i32))) 
    (import "Reflect" "apply" (func $self.Reflect.apply<ref.ref.ref>ref (param externref externref externref) (result externref))) 
    (import "String" "fromCharCode" (global $self.String.fromCharCode externref))
    `;

    // B. Init Kodları (Hepsini birleştir)
    const initBlock = STRING_POOL.map(s => s.initCode).join("\n");

    // C. Bootstrap fonksiyonu için gerekli geçici değişken
    // String oluştururken argümanları tutmak için buna ihtiyacımız var.
    const bootstrapLocals = `(local $__str_tmp externref)`;

    return { imports, initBlock, bootstrapLocals };
}

export function resetStringPool() {
    STRING_POOL.length = 0;
}