// lib/cleanComments.js

/**
 * WAT kodundaki yorum satırlarını temizler.
 * - Satır içi yorumlar: ;; ...
 * - Blok yorumlar: (; ... ;)
 * * ÖNEMLİ: Bu fonksiyon, string/text blokları işlendikten SONRA çalıştırılmalıdır.
 * Aksi takdirde string içindeki ";;" ifadelerini yorum sanıp silebilir.
 */
export function cleanComments(source) {
    let cleaned = source;

    // 1. Blok Yorumları Temizle (; ... ;)
    // [\s\S]*? -> Satır sonları dahil her şeyi, en kısa şekilde (non-greedy) yakala
    cleaned = cleaned.replace(/\(\;[\s\S]*?\;\)/g, " ");

    // 2. Satır İçi Yorumları Temizle ;; ...
    // $ -> Satır sonuna kadar olan her şeyi al
    // gm -> Global ve Multiline modu
    cleaned = cleaned.replace(/;;.*$/gm, " ");

    return cleaned;
}