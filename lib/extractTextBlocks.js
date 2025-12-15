// Encoder ve Offset Ayarları
const encoder = new TextEncoder();
let currentOffset = 0; // 0-3 arası boyut bilgisi için rezerve

// Havuzumuz
export const TEXT_POOL = [];

/**
 * 1. ADIM: Metinleri Ayıkla ve Havuza At
 */
export function extractTextBlocks(watSource, TableManager) {
    const textRegex = /\(text\s+"((?:[^"\\]|\\.)*)"\s*\)/gs;

    return watSource.replaceAll(textRegex, (match, rawContent) => {
        let entry = TEXT_POOL.find(e => e.rawContent === rawContent);

        if (!entry) {
            const tableIndex = TableManager.reserveIndex();

            // Metin temizliği (Escape karakterlerini çöz)
            let realString;
            try { realString = JSON.parse(`"${rawContent}"`); }
            catch (e) { realString = rawContent; }

            const buffer = encoder.encode(realString); // Uint8Array döner
            const length = buffer.length;
            const offset = currentOffset;

            // Start fonksiyonu için kod
            const decodeCall = `
            (block (result externref)
                (call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 1) (i32.const ${offset}))
                (call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 2) (i32.const ${length}))

                (call $self.Reflect.set<ref.i32.ref> 
                    (local.get $__decode_args__) 
                    (i32.const 0) 
                    (call $self.Reflect.construct<ref.ref>ref 
                        (local.get $self.Uint8Array) 
                        (local.get $__newviewargs__)
                    )
                )

                (call $self.Reflect.apply<ref.ref.ref>ref 
                    (local.get $__decode_func__)
                    (local.get $__new_decoder__)
                    (local.get $__decode_args__)
                )
            )
            `;
            const initCode = TableManager.generateSetter(tableIndex, decodeCall, true);

            entry = { rawContent, offset, length, tableIndex, buffer, initCode };
            TEXT_POOL.push(entry);

            currentOffset += length;
        }

        return TableManager.generateGetter(entry.tableIndex);
    });
}

/**
 * 2. ADIM: Veri Bloklarını ve Başlangıç Kodlarını Oluştur
 * Bu fonksiyon, tüm işlem bittikten sonra çağrılmalı.
 */
export function generateTextSections() {
    // Toplam boyutu hesapla (Son elemanın bitiş yeri)
    // Eğer havuz boşsa en az 4 byte (Header için) olmalı
    let totalLength = currentOffset + 4;
    if (totalLength % 4) {
        totalLength += 4 - (totalLength % 4);
    }

    // 1. Ana Buffer'ı Oluştur
    const buffer = new ArrayBuffer(totalLength);
    const view = new Uint8Array(buffer);

    // 2. İlk 4 Byte'a Toplam Uzunluğu Yaz (Little Endian)
    // Bu sayede WASM içinden belleğin toplam dolu boyutunu okuyabilirsin.
    new DataView(buffer, 0, 4).setUint32(
        0, currentOffset, true
    );

    // 3. Metinleri Byte Byte Yerleştir
    TEXT_POOL.forEach(t => {
        // t.buffer zaten Uint8Array, direkt set edebiliriz
        view.set(t.buffer, t.offset);
    });

    // 4. Hex String Oluştur (WAT Formatı İçin: \00\ff...)
    // map ile her byte'ı hex yap, aralarına \ koy.
    // Başlangıçtaki \ işaretini template literal içinde ekliyoruz.
    const hexData = Array.from(view)
        .map(c => c.toString(16).padStart(2, '0'))
        .join("\\");

    // 5. Blokları Döndür
    return {
        // Passive Data Segment: (data $isim "...")
        // Bunu aktif yapmak için start fonksiyonunda (memory.init) kullanman gerekebilir
        // veya memory 0 offset'ine kopyalamak için (data (i32.const 0) "...") yapabilirsin.
        // Senin isteğine sadık kalarak passive/named data formatında veriyorum:
        dataBlock: `(data $wat4wasm "\\${hexData}")`,

        // Start fonksiyonuna eklenecek satırlar
        initBlock: `(block $decodeText
            ${TEXT_POOL.map(t => t.initCode).join("\n\n")}
        )
        `
    };
}

export function resetTextPool() {
    TEXT_POOL.length = 0;
    currentOffset = 4;
}