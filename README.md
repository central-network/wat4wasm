# wat4wasm

<p align="center">
  <br />
  <strong><code>wat4wasm</code></strong>
  <br />
  <br />
  sweet <em><strong>WebAssembly</strong></em> sugars
  <br />
  Designed to make you faster, smarter and aesthetically pleasing WebAssembly coder.
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License"></a>
  <img src="https://img.shields.io/badge/node-14.0.0-green.svg" alt="Node.js Version">
</p>

## BAŞLIK
İçerik

## Why wat4wasm?

Writing WebAssembly Text (WAT) often feels like stepping back in time. While the performance is futuristic, the developer experience is archaic. You manually manage indices, define every single import, and struggle with basic tasks like string handling or asynchronous flows.

**wat4wasm** changes the game.

It is a pre-compiler that treats WebAssembly as a first-class citizen of the JavaScript ecosystem. It introduces "syntactic sugars" and powerful macros that allow you to write WASM with the expressiveness of a high-level language.

**Core Philosophies:**
1.  **The Magic `$self`**: Access the entire JavaScript host environment (`window`, `console`, `DOM`, etc.) directly from WASM without writing a single manual import.
2.  **Modern Syntax**: Use `async/await`, `new` constructors, and dot-notation for property access.
3.  **Seamless Integration**: Embed files, compile other WAT modules inline, and auto-generate boilerplate.

It's not just a compiler; it's the bridge that makes WebAssembly fun to write. 
<br />
<br />
**Example for a few code transformations:**
<br />
<img src="ss-in2out.png?1">
<br />
<br />
<hr />

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
<p align="center">
  <a target="_blank" href="https://gemini.google.com/">Gemini</a> and <a target="_blank" href="https://github.com/tokbuga">Özgür</a> created with 💚
</p>