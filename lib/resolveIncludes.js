import fs from "fs";
import path from "path";

/**
 * WAT içeriğindeki (include "dosya_yolu") satırlarını bulur.
 * Node.js fs modülü ile dosyayı okur ve içeriği yerine koyar.
 * İç içe include'ları destekler (Recursive).
 * * @param {string} source - Kaynak kod
 * @returns {string} - Birleştirilmiş kod
 */
export function resolveIncludes(source) {
    // Regex: (include "dosya_yolu") yakalar
    const includeRegex = /\(include\s+"((?:[^"\\]|\\.)*)"\s*\)/g;

    let match;
    const replacements = [];

    // 1. Tüm include satırlarını bul
    while ((match = includeRegex.exec(source)) !== null) {
        replacements.push({
            start: match.index,
            end: match.index + match[0].length,
            filePath: match[1] // WAT içindeki dosya yolu
        });
    }

    // Include yoksa direkt dön (Recursion bitiş şartı)
    if (replacements.length === 0) {
        return source;
    }

    // 2. Tersten başlayarak değiştir
    for (let i = replacements.length - 1; i >= 0; i--) {
        const { start, end, filePath } = replacements[i];

        try {
            // Dosyayı senkron oku (Kendi işini kendi görüyor)
            // Not: Dosya yolu, çalışma dizinine (process.cwd()) göre aranır.
            const absolutePath = path.resolve(process.cwd(), filePath);

            console.log(`Checking dependency: ${filePath}`); // Bilgi verelim
            let fileContent = fs.readFileSync(absolutePath, "utf8");

            // ⚠️ Recursive: İçeri alınan dosya da işlenmeli
            fileContent = resolveIncludes(fileContent);

            // String birleştirme
            source = source.slice(0, start) + "\n" + fileContent + "\n" + source.slice(end);

        } catch (error) {
            console.error(`❌ Hata: '${filePath}' dosyası dahil edilemedi.`);
            // Hata fırlatmak yerine süreci durduruyoruz, çünkü include kritik.
            throw error;
        }
    }

    return source;
}