// lib/InjectManager.js
let TableManager, ScopeManager;

export class InjectManager {
    // Statik depolama alanları
    static locals = new Map(); // (local $name type)
    static instructions = [];  // Kod satırları

    // Bootstrap fonksiyonumuzun sabit adı
    static BOOTSTRAP_FUNC_NAME = "$__wat4wasm_bootstrap";

    static setManagers(tableManager, scopeManager) {
        TableManager = tableManager;
        ScopeManager = scopeManager;
    }

    /**
     * Start fonksiyonuna enjekte edilecek bir instruction ekler.
     * @param {string} codeLine - Örn: (call $init)
     */
    static addInstruction(codeLine) {
        if (codeLine = codeLine.trim()) {
            if (this.instructions.includes(codeLine) === false) {
                this.instructions.push(codeLine);
            }
        }
    }

    /**
     * Start fonksiyonunda kullanılacak bir yerel değişken tanımlar.
     * @param {string} name - Örn: $idx
     * @param {string} type - Örn: i32
     */
    static addLocal(name, type = "externref") {
        if (name.startsWith("$")) {
            name = name.substring(1);
        }

        // Aynı isimde tekrar eklenirse tipini güncelleriz (veya aynısı kalır)
        if (this.locals.has(name)) {
            throw "Local name is used before: " + name
        };

        this.locals.set(name, type);
    }

    /**
     * Tüm birikenleri temizler (Pipeline başında çağrılmalı).
     */
    static reset() {
        this.locals.clear();
        this.instructions = [];
    }

    /**
     * Verilen WAT kodundaki bootstrap fonksiyonunu siler ve
     * biriken verilerle yenisini oluşturup enjekte eder.
     * @param {string} source - WAT kodu
     * @returns {string} - Güncellenmiş WAT kodu
     */
    static updateWAT(source) {
        let newSource = source;
        const funcName = this.BOOTSTRAP_FUNC_NAME;

        // 1. Önceki Bootstrap Fonksiyonunu Temizle (Varsa)
        // Regex: (func $__wat4wasm_bootstrap ... ) bloğunu bulmaya çalışır.
        // Not: Regex ile iç içe parantezleri tam bulmak zordur ama 
        // bootstrap fonksiyonumuz genelde düz yapıda olacağı için basit bir yaklaşım kullanıyoruz.
        // Daha güvenlisi için 'extractBalancedBlock' mantığını buraya da taşıyabiliriz.

        // Basit temizlik: Start komutunu ve fonksiyonu sil
        const startRegex = new RegExp(`\\(start\\s+${funcName.replace('$', '\\$')}\\)`, 'g');
        newSource = newSource.replace(startRegex, '');

        // Fonksiyon tanımını bulmak için basit bir string araması yapalım
        // (func $name ... )
        const funcSignature = `(func ${funcName}`;
        const funcIndex = newSource.indexOf(funcSignature);

        if (funcIndex !== -1) {
            // Fonksiyon bloğunu bulup silelim
            const { endPointer } = this._extractBalancedBlock(newSource, funcIndex);
            const before = newSource.substring(0, funcIndex);
            const after = newSource.substring(endPointer);
            newSource = before + after;
        }

        // 2. Yeni Bootstrap Fonksiyonunu Oluştur
        // Eğer eklenecek bir şey yoksa boş fonksiyon oluşturmaya gerek yok
        if (this.instructions.length === 0 && this.locals.size === 0) {
            return newSource;
        }

        let funcBody = `(func ${funcName}\n`;

        // Localleri ekle
        this.locals.forEach((type, name) => {
            funcBody += `    (local $${name} ${type})\n`;
        });

        // Boşluk bırak
        if (this.locals.size > 0) funcBody += "\n";

        // Talimatları ekle
        this.instructions.forEach(line => {
            funcBody += `    ${line}\n`;
        });

        funcBody += `  )`; // Fonksiyonu kapat

        // 3. Koda Enjekte Et
        // Modülün sonundaki ')' karakterinden hemen önceye ekleyelim
        const lastParenIndex = newSource.lastIndexOf(')');
        if (lastParenIndex !== -1) {
            const beforeLast = newSource.substring(0, lastParenIndex);
            const afterLast = newSource.substring(lastParenIndex);

            // Hem fonksiyonu hem de start komutunu ekliyoruz
            const startCommand = `(start ${funcName})`;
            newSource = beforeLast + `\n  ${funcBody}\n  ${startCommand}\n` + afterLast;
        }

        return newSource;
    }

    /**
     * Yardımcı: Dengeli parantez bloğu bulucu (Basitleştirilmiş)
     * Sınıf içinde private helper olarak çalışır.
     */
    static _extractBalancedBlock(source, startIndex) {
        let depth = 0;
        let endIndex = startIndex;
        let started = false;
        for (let i = startIndex; i < source.length; i++) {
            const char = source[i];
            if (char === '(') { depth++; started = true; }
            else if (char === ')') { depth--; }
            if (started && depth === 0) { endIndex = i + 1; break; }
        }
        return { endPointer: endIndex };
    }
}