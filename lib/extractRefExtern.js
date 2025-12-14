// lib/extractRefExtern.js
import { TableManager } from "./TableManager.js";

const REF_POOL = [];

export function extractRefExtern(watSource) {
    const regex = /\(ref\.extern\s+(\$self[^\s)]*)\)/g;

    return watSource.replace(regex, (match, fullPath) => {
        let entry = REF_POOL.find(e => e.rawContent === fullPath);

        if (!entry) {
            const tableIndex = TableManager.reserveIndex();
            // Yeni ve güçlü parser'ımızı çağırıyoruz
            const constructionCode = generateTraversalCode(fullPath);
            const initCode = TableManager.generateSetter(tableIndex, constructionCode);
            entry = { rawContent: fullPath, tableIndex, initCode };
            REF_POOL.push(entry);
        }
        return TableManager.generateGetter(entry.tableIndex);
    });
}

function generateTraversalCode(pathStr) {
    // 1. $self temizliği
    let cleanPath = pathStr.replace("$self", "");
    if (cleanPath.startsWith(".")) cleanPath = cleanPath.substring(1);

    // 2. ÖZEL DURUM: TypedArray Alias'ı
    // Eğer yol TypedArray ile başlıyorsa veya içeriyorsa değiştiriyoruz.
    // Kullanıcı self.TypedArray:set dediyse -> self.Uint8Array.__proto__:set olur.
    cleanPath = cleanPath.replace("TypedArray", "Uint8Array.__proto__");

    // 3. ÖZEL DURUM: Prototype Kısayolu (:)
    // Memory:grow -> Memory.prototype.grow
    cleanPath = cleanPath.replaceAll(":", ".prototype.");

    // 4. Parçala ve Yönet
    // Noktaya göre ayırıyoruz. Slash (/) varsa o son parçada kalıyor şimdilik.
    let parts = cleanPath.split(".").filter(p => p.length > 0);

    let code = `
        (block (result externref)
            (local.set $__ref_tmp (global.get $self))
    `;

    // 5. Adım Adım İlerleme (Son parça hariç)
    const lastIndex = parts.length - 1;

    for (let i = 0; i < lastIndex; i++) {
        const part = parts[i];
        code += `
            (local.set $__ref_tmp 
                (call $self.Reflect.get<ref.ref>ref 
                    (local.get $__ref_tmp) 
                    (string "${part}")
                )
            )
        `;
    }

    // 6. FİNAL VURUŞU (Son Parça Analizi)
    let lastPart = parts[lastIndex];

    // '/get' kontrolü (Descriptor Mode)
    if (lastPart.endsWith("/get")) {
        // "byteLength/get" -> propertyName: "byteLength"
        const propertyName = lastPart.replace("/get", "");

        code += `
            ;; --- Descriptor Mode: ${propertyName}/get ---
            ;; 1. Descriptor'ı al: Reflect.getOwnPropertyDescriptor(target, prop)
            (local.set $__ref_tmp 
                (call $self.Reflect.getOwnPropertyDescriptor<ref.ref>ref
                    (local.get $__ref_tmp)
                    (string "${propertyName}")
                )
            )
            ;; 2. Getter fonksiyonunu çek: Reflect.get(descriptor, "get")
            (local.set $__ref_tmp
                (call $self.Reflect.get<ref.ref>ref
                    (local.get $__ref_tmp)
                    (string "get")
                )
            )
        `;
    } else {
        // Normal Erişim (Reflect.get)
        code += `
            (local.set $__ref_tmp 
                (call $self.Reflect.get<ref.ref>ref 
                    (local.get $__ref_tmp) 
                    (string "${lastPart}")
                )
            )
        `;
    }

    code += `
            (local.get $__ref_tmp)
        )`;

    return code;
}

export function generateRefExternInfrastructure() {
    if (REF_POOL.length === 0) return { initBlock: "", bootstrapLocals: "" };
    const initBlock = REF_POOL.map(r => r.initCode).join("\n");
    const bootstrapLocals = `(local $__ref_tmp externref)`;
    return { initBlock, bootstrapLocals };
}

export function resetRefExternPool() {
    REF_POOL.length = 0;
}