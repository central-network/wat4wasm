// lib/extractRefExtern.js
// Her referansın tablo ID'sini ve tam yolunu tutar
const REF_MAP = new Map();
// Init fonksiyonunda kullanılacak geçici değişkenler listesi
const BOOTSTRAP_LOCALS = new Set();

/**
 * (ref.extern $path) yapılarını işler.
 * 1. Path'leri toplar ve bir ağaç oluşturur.
 * 2. Kod içindeki kullanımları (table.get ID) ile değiştirir.
 * 3. Optimize edilmiş, gruplanmış Init kodu üretir.
 */
export function extractRefExtern(source, TableManager) {
    let result = source;

    // 1. Tüm benzersiz referansları bul
    // Regex: (ref.extern $self.A.B.C)
    const regex = /\(ref\.extern\s+(\$[\w\d_.]+)\)/g;
    let match;
    const paths = new Set();

    while ((match = regex.exec(source)) !== null) {
        paths.add(match[1]); // $self.Array.prototype.push
    }

    // 2. Tablo ID'lerini Ata ve Kodda Değiştir
    paths.forEach(path => {
        if (!REF_MAP.has(path)) {
            const id = TableManager.reserveIndex();
            REF_MAP.set(path, id);
        }

        const id = REF_MAP.get(path);
        // Kod içindeki değişimi yap: (ref.extern ...) -> (table.get ID)
        // NOT: (table.get (i32.const ID)) standardını kullanıyoruz.
        result = result.replaceAll(`(ref.extern ${path})`, TableManager.generateGetter(id));
    });

    return result;
}

/**
 * Referans Ağacı Düğümü
 */
class RefNode {
    constructor(name, parentVarName = null) {
        this.name = name; // Özellik adı (örn: "prototype")
        this.children = new Map(); // Alt düğümler
        this.tableId = null; // Eğer bu bir hedef referanssa ID'si
        this.varName = null; // Bu düğümü tutan local değişken adı
        this.parentVarName = parentVarName; // Üst düğümün değişken adı
    }
}

/**
 * Optimize Edilmiş Init Kodunu Üretir (Ağaç Bazlı)
 */
export function generateRefExternInfrastructure(TableManager) {
    if (REF_MAP.size === 0) return { initBlock: "", bootstrapLocals: "" };

    const root = new RefNode("root");
    const initInstructions = [];

    // 1. Ağacı İnşa Et
    REF_MAP.forEach((id, rawPath) => {
        // $self.Array.push -> ["self", "Array", "push"]
        const parts = rawPath.replace(/^\$/, "").split(".");
        let currentNode = root;
        let currentVarPath = "";

        parts.forEach((part, index) => {
            if (!currentNode.children.has(part)) {
                // Yeni düğüm için değişken ismi üret: $__ref_self_Array
                // Ancak "self" zaten global, ona özel muamele
                let varName;
                if (index === 0 && part === "self") {
                    varName = "$__ref_self"; // Başlangıç noktası
                } else {
                    currentVarPath += "_" + part;
                    varName = `$__ref${currentVarPath}`;
                }

                const newNode = new RefNode(part, currentNode.varName);
                newNode.varName = varName;
                currentNode.children.set(part, newNode);

                // Bu değişkeni kullanılacaklar listesine ekle (self hariç, o globalden gelir)
                if (index > 0) {
                    BOOTSTRAP_LOCALS.add(varName);
                }
            }
            currentNode = currentNode.children.get(part);
        });

        // Son düğüme Table ID'sini ata
        currentNode.tableId = id;
    });

    // 2. Ağacı Gez ve Kod Üret (DFS - Depth First Search)
    // Kuyruk yapısı ile de gezilebilir ama DFS hiyerarşi için iyidir.

    function traverse(node) {
        // Eğer bu düğüm "self" ise, onu initialize etmeye gerek yok (global.get ile alınır)
        // Ama biz yine de local'e alabiliriz veya doğrudan kullanırız.
        // Optimizasyon: $__ref_self değişkenini kullanmak yerine global.get $self kullanırız.

        // Çocukları gez
        node.children.forEach(child => {
            // Kod Üretimi: Parent'tan Child'ı al
            // Örn: local.set $Array (call Reflect.get (local.get $self) (text "Array"))

            let parentSource;
            if (child.parentVarName === "$__ref_self") {
                // Parent self ise globalden al
                parentSource = `(global.get $self)`;
            } else if (node.name === "root") {
                // Root'un doğrudan çocukları (self dışında bir şey varsa, örn: $Math)
                // Burası şimdilik "self" ile başladığımızı varsayıyor.
                parentSource = `(global.get $self)`;
            } else {
                // Parent local değişkende
                parentSource = `(local.get ${child.parentVarName})`;
            }

            // Child Self ise işlem yapma (zaten var), değilse Reflect.get yap
            if (child.name !== "self") {
                // NOT: Burada (text ...) kullanıyoruz! Pipeline sırası sayesinde işlenecek.
                const getCode = `
                (local.set ${child.varName} 
                    (call $self.Reflect.get<ref.ref>ref 
                        ${parentSource} 
                        (text "${child.name}")
                    )
                )`;
                initInstructions.push(getCode);
            }

            // Eğer bu düğüm bir hedef referans ise (yaprak veya ara düğüm), Tabloya kaydet
            if (child.tableId !== null) {
                // (table.set (i32.const ID) (local.get $Var))
                const saveCode = TableManager.generateSetter(child.tableId, `(local.get ${child.varName})`);
                initInstructions.push(saveCode);
            }

            // Derine in
            traverse(child);
        });
    }

    traverse(root);

    return {
        initBlock: `
        (block $ref.externef
            ${initInstructions.join("\n\n")}
        )
        `,
        bootstrapLocals: Array.from(BOOTSTRAP_LOCALS).map(name => `(local ${name} externref)`).join("\n")
    };
}

export function resetRefExternPool() {
    REF_MAP.clear();
    BOOTSTRAP_LOCALS.clear();
}