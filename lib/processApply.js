// lib/processApply.js

/**
 * (apply ...) yapısını işler.
 * Format: (apply (Signature) (Target) (This) (Args))
 * Dönüşüm: (call $self.Reflect.apply<ref.ref.ref> (Target) (This) (Args))
 * Not: Signature kısmı Reflect.apply için kullanılmaz, atılır.
 */
export function processApply(source) {
    let result = "";
    let i = 0;

    while (i < source.length) {
        // (apply kelimesini ara (ve peşinden boşluk/parantez gelmeli)
        if (source.substring(i).match(/^\(apply[\s(]/)) {
            // 1. Apply bloğunun tamamını çıkar (Dış parantezler dahil)
            const { block, endPointer } = extractBalancedBlock(source, i);

            // 2. İçeriği parse et (Dış parantezleri atıp içindekileri ayır)
            // block: "(apply (type...) (local.get 1) ... )"
            const innerContent = block.slice(6, -1).trim(); // "(apply" (6 harf) ve sondaki ")" atılır

            // Argümanları ayır: [(type...), (target...), (this...), (args...)]
            const expressions = parseSExpressions(innerContent);

            if (expressions.length < 4) {
                // Eğer eksik argüman varsa hata vermeyelim, olduğu gibi bırakalım (belki kullanıcı başka bir şey kastediyordur)
                console.warn("⚠️ Uyarı: (apply ...) bloğu eksik argüman içeriyor, atlanıyor.");
                result += block;
            } else {
                // 3. Parçaları Ata (Positional Mapping)
                // expressions[0] -> Signature (type/param) -> ATILIR (Şimdilik)
                // expressions[1] -> Target
                // expressions[2] -> This
                // expressions[3] -> Args (Array)

                const target = expressions[1];
                const thisArg = expressions[2];
                const args = expressions[3];

                // 4. Yeni çağrıyı oluştur
                const newCall = `
                (call $self.Reflect.apply<ref.ref.ref> 
                    ${target}
                    ${thisArg}
                    ${args}
                )`;

                result += newCall;
            }

            // Pointer'ı bloğun sonuna taşı
            i = endPointer;
        } else {
            // Apply değilse karakteri olduğu gibi ekle
            result += source[i];
            i++;
        }
    }

    return result;
}

/**
 * YARDIMCI: İç içe parantezleri sayarak bloğu komple çıkarır.
 */
function extractBalancedBlock(source, startIndex) {
    let depth = 0;
    let endIndex = startIndex;
    let started = false;

    for (let i = startIndex; i < source.length; i++) {
        const char = source[i];
        if (char === '(') {
            depth++;
            started = true;
        } else if (char === ')') {
            depth--;
        }

        if (started && depth === 0) {
            endIndex = i + 1;
            break;
        }
    }

    return {
        block: source.substring(startIndex, endIndex),
        endPointer: endIndex
    };
}

/**
 * YARDIMCI: Bir string içindeki en üst seviye (top-level) S-expression'ları dizi olarak döner.
 * Örn: "(param i32) (local.get 1)" -> ["(param i32)", "(local.get 1)"]
 */
function parseSExpressions(content) {
    const expressions = [];
    let depth = 0;
    let currentExpr = "";
    let inExpr = false;

    for (let i = 0; i < content.length; i++) {
        const char = content[i];

        // Boşlukları atla (eğer parantez içinde değilsek)
        if (!inExpr && /\s/.test(char)) continue;

        if (char === '(') {
            if (depth === 0) inExpr = true;
            depth++;
        }

        if (inExpr) {
            currentExpr += char;
        }

        if (char === ')') {
            depth--;
            if (depth === 0) {
                expressions.push(currentExpr);
                currentExpr = "";
                inExpr = false;
            }
        }
    }
    return expressions;
}