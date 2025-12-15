// lib/extractStringBlocks.js
const STRING_POOL = [];
let TableManager, InjectManager, ScopeManager;

export function setManagers(tableManager, injectManager, scopeManager) {
    TableManager = tableManager;
    InjectManager = injectManager;
    ScopeManager = scopeManager;
}

/**
 * 1. ADIM: (string "...") bloklarını bul, tabloya kaydet ve getter ile değiştir.
 */
export function extractStringBlocks(watSource) {
    const stringRegex = /\(string\s+"((?:[^"\\]|\\.)*)"\s*\)/gs;

    return watSource.replaceAll(stringRegex, (match, rawContent) => {
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
                return `(call $self.Reflect.set<ref.i32.i32> (local.get $__str_tmp) (i32.const ${charIndex}) (i32.const ${charCode}))`;
            }).join('\n');

            // 4. Start fonksiyonu içinde çalışacak kod bloğunu hazırla
            // Block (result externref) kullanarak işlemi izole ediyoruz
            const constructionCode = `
        (block 
            (result externref)
            
            ;; A. Boş Array oluştur (arguments)
            (local.set $__str_tmp 
                (call $self.Reflect.ownKeys<ref>ref 
                    (global.get $self.String.fromCharCode)
                )
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
        //return { imports: "", initBlock: "", bootstrapLocals: "" };
    }

    // A. Importlar
    const imports = `
    (import "String" "fromCharCode" (global $self.String.fromCharCode externref))
    (import "self" "Array" (global $self.Array<>ref (param) (result externref)))
    (import "Reflect" "get" (func $self.Reflect.get<ref.ref>ref (param externref externref) (result externref)))
    (import "Reflect" "set" (func $self.Reflect.set<ref.i32.i32> (param externref i32 i32) (result)))
    (import "Reflect" "set" (func $self.Reflect.set<ref.i32.ref> (param externref i32 externref) (result)))
    (import "Reflect" "apply" (func $self.Reflect.apply<ref.ref.ref>ref (param externref externref externref) (result externref)))
    (import "Reflect" "construct" (func $self.Reflect.construct<ref.ref>ref (param externref externref) (result externref)))
    `;

    const stringify = str => `(block 
        (result externref)
        (local.set $__char__codes__ (call $self.Array<>ref))

        ${str.split('').map((char, charIndex) => {
        const charCode = char.charCodeAt(0);
        // Not: Burada $__str_tmp adında geçici bir local kullanacağız
        return `
    (call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const ${charIndex}) (i32.const ${charCode}))`;
    }).join('').trim()
        }

        (call $self.Reflect.apply<ref.ref.ref>ref 
            (global.get $self.String.fromCharCode) 
            (ref.null externref) 
            (local.get $__char__codes__)
        )
    )`;

    // B. Init Kodları (Hepsini birleştir)
    const initBlock = `${STRING_POOL.map(s => s.initCode).join("\n").trim()}
    (block $TextDecoder        
        (local.set $__new_decoder__
            (call $self.Reflect.construct<ref.ref>ref
                (call $self.Reflect.get<ref.ref>ref
                    (global.get $self)
                    ${stringify("TextDecoder")}
                )
                (global.get $self)
            )
        )

        (local.set $__decode_func__
            (call $self.Reflect.get<ref.ref>ref
                (local.get $__new_decoder__)
                ${stringify("decode")}
            )   
        )

        (local.set $__heap_backup__ 
            (i32.load (i32.const 0))
        )

        (memory.init $wat4wasm
            (i32.const 0)
            (i32.const 0)
            (i32.const 4)
        )

        (local.set $__data_offset__ (i32.const 4))
        (local.set $__text_offset__ (i32.const 0))
        (local.set $__text_length__ (i32.load (i32.const 0)))
        (local.set $__newviewargs__ (call $self.Array<>ref))

        (call $self.Reflect.set<ref.i32.i32>
            (local.get $__newviewargs__)
            (i32.const 0) 
            (local.get $__text_length__)
        )

        (local.set $__buffer_view__
            (call $self.Reflect.construct<ref.ref>ref
                (call $self.Reflect.get<ref.ref>ref
                    (global.get $self)
                    ${stringify("Uint8Array")}
                )
                (local.get $__newviewargs__)
            )
        )

        (loop $length--
            (memory.init $wat4wasm
                (i32.const 0) 
                (local.get $__data_offset__) 
                (i32.const 1)
            )

            (call $self.Reflect.set<ref.i32.i32>
                (local.get $__buffer_view__) 
                (local.get $__text_offset__) 
                (i32.load8_u (i32.const 0))
            )

            (local.set $__data_offset__
                (i32.add 
                    (local.get $__data_offset__) 
                    (i32.const 1)
                )
            )

            (local.set $__text_offset__
                (i32.add
                    (local.get $__text_offset__)
                    (i32.const 1)
                )
            )

            (br_if $length--
                (local.tee $__text_length__
                    (i32.sub 
                        (local.get $__text_length__) 
                        (i32.const 1)
                    )
                )
            )
        )

        (data.drop $wat4wasm)
        (i32.store (local.get $__heap_backup__))

        (call $self.Reflect.set<ref.i32.ref>
            (local.get $__newviewargs__)
            (i32.const 0) 
            (call $self.Reflect.get<ref.ref>ref
                (local.get $__buffer_view__)
                ${stringify("buffer")}
            )
        )

        (local.set $__decode_args__ (call $self.Array<>ref))
    )
    `;

    // C. Bootstrap fonksiyonu için gerekli geçici değişken
    // String oluştururken argümanları tutmak için buna ihtiyacımız var.
    const bootstrapLocals = `
    (local $__new_decoder__ externref)
    (local $__decode_func__ externref)
    (local $__buffer_view__ externref)
    (local $__heap_backup__ externref)
    (local $__data_length__ externref)
    (local $__data_offset__ externref)
    (local $__text_offset__ externref)
    (local $__newviewargs__ externref)
    (local $__decode_args__ externref)
    (local $__char__codes__ externref)
    (local $_bind_function_ externref)
    (local $_func_argument_ externref)
    (local $self.Uint8Array externref)`;

    return { imports, initBlock, bootstrapLocals };
}

export function resetStringPool() {
    STRING_POOL.length = 0;
}