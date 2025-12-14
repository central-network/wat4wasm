// lib/processCustomTypes.js

/**
 * Bu modül (type $name (param ...)) tanımlarını işler.
 * Bu tanımlar sanaldır; yani WAT kodunda derlenmez, sadece yerine konulur.
 */

const TYPE_DEFINITIONS = new Map();

export function processCustomTypes(watSource) {
    // 1. ADIM: Tanımları Bul ve Hafızaya Al
    // Regex: (type $isim (param ...)) yapısını yakalar.
    // Grub 1: $isim
    // Grub 2: (param ...) bloğunun tamamı
    const definitionRegex = /\(type\s+(\$[\w\d_.\-]+)\s+(\(param\s+[^)]+\))\)/g;

    let cleanSource = watSource;
    let match;

    // matchAll veya while döngüsü ile hepsini bulalım
    while ((match = definitionRegex.exec(watSource)) !== null) {
        const typeName = match[1];
        const paramBlock = match[2];

        // Hafızaya kaydet
        TYPE_DEFINITIONS.set(typeName, paramBlock);
    }

    // 2. ADIM: Tanım Satırlarını Koddan Sil
    // Replace işlemi ile tanımları boşlukla değiştiriyoruz.
    cleanSource = cleanSource.replaceAll(definitionRegex, "");

    // 3. ADIM: Kullanım Yerlerini Değiştir
    // Kodun içinde (type $sugar) geçen yerleri bulup, (param i32 i32) ile değiştiriyoruz.
    // Not: TYPE_DEFINITIONS map'ini döngüye alıyoruz.
    TYPE_DEFINITIONS.forEach((paramBlock, typeName) => {
        // (type $isim) kullanımını arayan regex
        // Parantezleri kaçış karakteriyle belirtiyoruz: \(type \$isim\)
        // $ işareti regex'te özel anlam taşıdığı için escape edilmeli
        const usageKey = `(type ${typeName})`;

        // Hepsini değiştir
        cleanSource = cleanSource.replaceAll(usageKey, paramBlock);
    });

    return cleanSource;
}

// Test için reset fonksiyonu
export function resetCustomTypes() {
    TYPE_DEFINITIONS.clear();
}