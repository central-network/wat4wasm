let TableManager, InjectManager;

export class ScopeManager {
    // Tekilleştirme için Set kullanıyoruz.
    // Aynı import stringi 10 kere gelse de burada 1 kere saklanır.
    static definitions = new Set();

    static setManagers(tableManager, injectManager) {
        TableManager = tableManager;
        InjectManager = injectManager;
    }

    /**
     * Modül seviyesinde bir tanım ekler.
     * @param {string} def - Örn: (import "env" "log" ...) veya (elem ...)
     */
    static add(def) {
        if (def && def.trim()) {
            this.definitions.add(def.trim());
        }
    }

    /**
     * Temizlik
     */
    static reset() {
        this.definitions.clear();
    }

    /**
     * WAT kodunu günceller. Eksik tanımları modülün başına enjekte eder.
     * @param {string} source - WAT kodu
     * @returns {string} - Güncellenmiş WAT kodu
     */
    static updateWAT(source) {
        let newSource = source;
        const missingDefs = [];

        // 1. Kontrol Et: Kodun içinde zaten var mı?
        // String.includes() basit ve hızlıdır. 
        // Eğer çok karmaşık whitespace (boşluk) farkları varsa regex gerekebilir 
        // ama makrolarımız standart çıktı ürettiği için bu genelde yeterlidir.
        this.definitions.forEach(def => {
            if (!newSource.includes(def)) {
                missingDefs.push(def);
            }
        });

        // Eklenecek bir şey yoksa aynen dön
        if (missingDefs.length === 0) {
            return newSource;
        }

        // 2. Enjeksiyon Noktasını Bul
        // Tanımları (module ...) satırının hemen altına eklemek en güvenlisidir.
        // WebAssembly'de Importlar en başta olmalıdır.
        const moduleRegex = /\(module\s*/;
        const match = newSource.match(moduleRegex);

        if (match) {
            const insertionPoint = match.index + match[0].length;
            const blockToInject = "\n  ;; --- ScopeManager Injections ---\n  " +
                missingDefs.join("\n  ") +
                "\n";

            const before = newSource.substring(0, insertionPoint);
            const after = newSource.substring(insertionPoint);

            newSource = before + blockToInject + after;
        } else {
            // Eğer (module) yoksa (snippet olabilir), en başa ekle
            newSource = missingDefs.join("\n") + "\n" + newSource;
        }

        return newSource;
    }
}