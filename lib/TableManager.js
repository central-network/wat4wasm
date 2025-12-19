// lib/TableManager.js

// Tablomuzun sabit adı (Prompt'ta belirttiğin gibi)
const TABLE_NAME = "$wat4wasm";
let InjectManager, ScopeManager;


// İndex sayacı. 0. index'i atlamak için 1'den başlatıyoruz.
// (Index 0 genelde null/boş referans kontrolü için güvenli limandır)
let currentIndex = 1;

export const TableManager = {
    setManagers(injectManager, scopeManager) {
        InjectManager = injectManager;
        ScopeManager = scopeManager;
    },

    updateWAT(source) {
        return source;
    },

    /**
     * 1. Index Rezervasyonu:
     * Tabloda boş bir koltuk ayırır ve koltuk numarasını (index) döner.
     * @returns {number} - Rezerve edilen index
     */
    reserveIndex() {
        const id = currentIndex;
        currentIndex++;
        return id;
    },

    /**
     * 2. Getter Çağrısı:
     * Verilen index'teki değeri okumak için gereken WAT kodunu üretir.
     * @param {number} index - Okunacak index
     * @returns {string} - (table.get ...) kodu
     */
    generateGetter(index) {
        return `(table.get ${TABLE_NAME} (i32.const ${index}))`;
    },

    /**
     * 3. Setter Çağrısı:
     * Verilen index'e bir değer (externref) yazmak için gereken WAT kodunu üretir.
     * @param {number} index - Yazılacak index
     * @param {string} valueWat - Yazılacak değerin WAT kodu (Örn: local.get $a)
     * @returns {string} - (table.set ...) kodu
     */
    generateSetter(index, valueWat, lineArgs = false) {
        if (!lineArgs) {
            return `(table.set ${TABLE_NAME} (i32.const ${index.toString().padStart(2, " ")}) ${valueWat})`;
        }
        return `(table.set ${TABLE_NAME} 
        (i32.const ${index})
        ${valueWat.trim()}
        )`;
    },

    /**
     * 4. Tablo Tanımı:
     * Şu ana kadar rezerve edilen toplam boyuta göre tabloyu tanımlar.
     * Min ve Max değerleri eşitlenir.
     * @returns {string} - (table ...) tanımı
     */
    generateTableDefinition() {
        // Eğer currentIndex 5 ise; 1, 2, 3, 4 kullanılmış demektir.
        // Boyutun en az 5 olması gerekir (0..4 arası erişim için).
        const size = currentIndex;
        return `(table  ${TABLE_NAME} ${size} externref)`;
    },

    /**
     * Yardımcı: Testler için sayacı sıfırlar.
     */
    reset() {
        currentIndex = 1;
    }
};