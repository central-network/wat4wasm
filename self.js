function self(match) {
    const path = match.blockName; // Örn: navigator.gpu
    let realpath = path;

    if (realpath.includes(":") === true) realpath = realpath.replaceAll(":", ".prototype.");
    if (realpath.startsWith("self") === false) realpath = `self.${realpath}`;

    const isGetter = realpath.endsWith("/get");
    const isSetter = realpath.endsWith("/set");
    let descriptorKey = "value";

    if (isGetter || isSetter) {
        realpath = realpath.substring(0, realpath.length - 4);
        if (isGetter) descriptorKey = "get";
        if (isSetter) descriptorKey = "set";
    }

    // Tip Analizi
    const isGlobalRef = (match.tagSubType === "ref"); // Kullanıcı 'ref' dediyse Global yapalım
    const parts = realpath.split(".");

    // Eğer basit primitive (i32 vb.) ve sığ derinlikse (self.length) IMPORT kullanmaya devam edebiliriz.
    // Ancak 'ref' (externref) ise ve derinlik ne olursa olsun, artık Global Fetch yapacağız.

    if (match.tagSubType.match(/^(i32|f32|i64|f64)$/) && parts.length <= 3) {
        // Primitif ve sığ importlar (Import Object ile gelenler)
        const [name, root = "self"] = parts.slice().reverse();
        return String(`
            (needed "${root}" "${name}" (global $${path} ${w4.longType[match.tagSubType]}))
            (global.get $${path})
        `);
    }

    // --- GLOBAL FETCH veya TABLE FETCH ---

    if (false === this.externref.has(path)) {
        let index = -1; // Global ise index yok

        // Eğer Table kullanacaksak (ext) indeks ayırt
        if (!isGlobalRef) {
            index = TableManager.reserveIndex();
        }

        const pathKeys = realpath.split(".");
        // Parent zinciri
        const realpaths = pathKeys.map((p, i, t) => t.slice(0, i).join(".")).slice(1);

        const needed = [`(needed "self" "self" (global $self externref))`];
        let valueGetter, descriptorSetter = "";

        // Getter/Setter Descriptor Mantığı (Reflect.getOwnPropertyDescriptor...)
        if (isGetter || isSetter) {
            valueGetter = `(local.get $${realpath}/${descriptorKey})`;
            descriptorSetter = `
            (oninit
                (local $${realpath} externref)
                (local $${realpath}/${descriptorKey} externref)

                (block $${realpath}
                    (local.set $${realpath}
                        (call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
                            (local.get $${realpaths.at(-1)})
                            (text "${pathKeys.at(-1)}")
                        )
                    )
                )
                
                (block $${realpath}/${descriptorKey}
                    (local.set $${realpath}/${descriptorKey}
                        (call $self.Reflect.get<ext.ext>ext
                            (local.get $${realpath})
                            (text "${descriptorKey}")
                        )
                    )
                )
            )`;

            // Reflect importlarını ekle
            needed.push(`(needed "Reflect" "get" (func $self.Reflect.get<ext.ext>ext (param externref externref) (result externref)))`);
            needed.push(`(needed "Reflect" "getOwnPropertyDescriptor" (func $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext (param externref externref) (result externref)))`);
        }
        else {
            // Standart Zincirleme
            realpaths.push(realpath);
            valueGetter = `(local.get $${realpath})`;
            needed.push(`(needed "Reflect" "get" (func $self.Reflect.get<ext.ext>ext (param externref externref) (result externref)))`);
        }

        // Init Kodunu İnşa Et
        let finalSetter = "";

        if (isGlobalRef) {
            // --- GLOBAL STRATEJİSİ ---
            // 1. init kodu çalışır, değeri bulur.
            // 2. global.set ile global değişkene yazar.
            finalSetter = `(global.set $${path} ${valueGetter})`;
        } else {
            // --- TABLE STRATEJİSİ ---
            finalSetter = TableManager.generateSetter(index, valueGetter);
        }

        const initCode = String()
            .concat(`(oninit (local $self externref) ${needed.join("\n")})`)
            .concat(realpaths.map((p, i, t) => `
            (oninit
                (local $${p} externref)
                (block $${p}
                    (local.set $${p}
                        (call $self.Reflect.get<ext.ext>ext 
                            (local.get $${t.at(i - 1)}) 
                            (text "${pathKeys[i]}")
                        )
                    )
                )
            )`).slice(1).join("\n"))
            .concat(descriptorSetter)
            .concat(`(oninit ${finalSetter})`);

        // Kayıt
        this.externref.set(path, {
            index,
            realpath,
            initCode,
            isGlobalRef // Bunu kaydediyoruz ki sonradan definition üretelim
        });
    }

    const refData = this.externref.get(path);

    if (isGlobalRef) {
        // Global Definition (Bunu main/boot sırasında header'a eklemelisin)
        // (needed_global ...) gibi bir tag ile dışarı fırlatabiliriz veya initCode içine yorum ekleriz.
        // Ama en temizi: 'needed' mekanizmanı kullanarak global tanımı enjekte etmek.

        return String(`
            ${refData.initCode}
            (needed "global_mut" "${path}" (global $${path} (mut externref) (ref.null extern)))
            (global.get $${path}) ;; ${path}
        `);
    } else {
        // Table Getter
        return String(`
            ${refData.initCode}
            ${TableManager.generateGetter(refData.index)} ;; ${path}
        `);
    }
}