# wat4wasm

<p align="center">
  <br />
  <strong><code>wat4wasm</code></strong>
  <br />
  A zero-dependency, runtime WebAssembly compiler and preprocessor for JavaScript.
  <br />
  Write <strong>enhanced</strong> .wat code with imports, file inclusions, and asset embedding—compile it directly in the browser or Node.js.
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License"></a>
  <img src="https://img.shields.io/badge/node-14.0.0-green.svg" alt="Node.js Version">
  <img src="https://img.shields.io/badge/size-tiny-orange.svg" alt="Size">
</p>

---

## Why wat4wasm?

Standard WebAssembly text format (`.wat`) tools are often heavy, require complex build chains (wabt, emscripten), or don't run natively in the browser.

**wat4wasm** is designed for runtime flexibility. It allows you to:
1.  **Skip the build step:** Compile `.wat` strings to executable `Wasm` instances instantly at runtime.
2.  **Write less boilerplate:** Use "Syntactic Sugar" for auto-imports, file inclusions, and data embedding.
3.  **Bridge JS & Wasm easily:** Call JavaScript functions directly from Wasm without manually constructing complex import objects.

## Key Features

-   ✨ **Auto-Imports via `$self`:** Call JavaScript functions directly using the `$self` namespace. `wat4wasm` automatically generates the necessary imports.
-   📦 **File Inclusion:** Modularize your code using `(include "path/to/file.wat")`.
-   🖼️ **Asset Embedding:** Embed binary files (images, json, models) directly into Wasm memory using `(data $id "path/to/file.png")`.
-   🚀 **Runtime Compilation:** Runs anywhere JavaScript runs (Browser & Node.js).
-   🧠 **Zero Dependencies:** No heavy binaries, no huge node_modules.

## Installation

~~~bash
npm install wat4wasm
~~~

## Usage

`wat4wasm` exposes a static `WatCompiler` class. Since it supports file I/O (for includes/data), the compilation is asynchronous.

~~~javascript
import { WatCompiler } from "wat4wasm";

// 1. Write Enhanced WAT Code
const source = `
  ;; Include other wat files
  (include "./math_utils.wat")

  ;; Embed a binary file into memory
  (data $icon "./assets/icon.png")

  (func $main (export "main")
    ;; Call JS functions directly! 
    ;; Syntax: $self.object.method<paramTypes>returnType
    
    ;; Example: console.log(42)
    (call $self.console.log<i32> (i32.const 42))
    
    ;; Example: Math.random() -> returns f32
    (call $self.Math.random<>f32) 
    drop
  )
`;

// 2. Define a Loader (Environment Specific)
// This tells the compiler how to resolve "include" and "data" paths.
const loader = async (path) => {
    // Node.js Example:
    const fs = require('fs/promises');
    return fs.readFile(path); 
    
    // Browser Example:
    // return fetch(path).then(res => res.arrayBuffer());
};

// 3. Compile!
const wasmBuffer = await WatCompiler.compile(source, { loader });

// 4. Run
const module = await WebAssembly.instantiate(wasmBuffer, {
    // The compiler generates 'self' imports, so we provide the environment
    self: window // or global in Node
});

module.instance.exports.main();
~~~

## Enhanced Syntax Reference

`wat4wasm` extends the standard WAT format with three powerful directives. These are processed before the standard compilation.

### 1. Auto-Imports (`$self`)

Instead of manually declaring `(import "env" "log" ...)` at the top of your file, you can use the `$self` namespace inline.

**Syntax:** `$self.path.to.function<paramTypes>returnType`

* **path.to.function**: Maps to the JavaScript object hierarchy provided in the import object.
* **<paramTypes>**: `i32`, `f32`, `f64`, etc. Empty `<>` means no parameters.
* **returnType**: Optional. `i32`, `f32`, etc. Omit if void.

**Examples:**

~~~wat
;; Calls self.alert(i32)
(call $self.alert<i32> (i32.const 1))

;; Calls self.Math.pow(f32, f32) -> f32
(call $self.Math.pow<f32f32>f32 (local.get $base) (local.get $exp))
~~~

### 2. File Inclusion (`include`)

Pastes the content of another `.wat` file at the current position. Handled recursively.

**Syntax:** `(include "path/string")`

~~~wat
(module
  (include "./headers.wat")
  (include "./utils/math.wat")
  
  (func $start ...)
)
~~~

### 3. Data Embedding (`data`)

Reads a file via the `loader`, converts it to a byte array, and embeds it into the Wasm `data` section.

**Syntax:** `(data $variableName "path/string")`

~~~wat
;; Embeds 'image.png' at a managed offset
(data $myImage "./image.png")

(func $test
  ;; $myImage is replaced by the memory offset (i32.const OFFSET)
  (call $process_image (i32.const $myImage)) 
)
~~~

## API Reference

### `WatCompiler.compile(source, options)`

* **`source`** (String): The enhanced WAT source code.
* **`options`** (Object):
    * **`loader`** (Function): `async (path: string) => Promise<Uint8Array | string>`. Required if using `include` or `data`.
* **Returns**: `Promise<Uint8Array>` containing the compiled binary Wasm.

## License

MIT