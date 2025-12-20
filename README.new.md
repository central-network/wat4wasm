# Wat4Wasm API & Syntax Sugar

This document defines the custom syntax ("sugar") supported by the `wat4wasm` pre-compiler.

## Core Elements
The compiler automatically injects the following 5 elements to manage the environment:
1. `(func $wat4wasm)`: The bootstrap function.
2. `(elem $wat4wasm)`: Declarations for indirect function calls.
3. `(data $wat4wasm)`: Data segment for text strings.
4. `(table $wat4wasm)`: Externref table.
5. `(start $wat4wasm)`: Entry point.

## 1. Type Aliases (Short Types)
Maps short type names to standard WASM types.
- `ext` -> `externref`
- `fun` -> `funcref`
- `i32`, `f32`, `i64`, `f64`, `v128` -> (Standard)

## 2. Global Access (`$self`)
Access properties of the host environment (e.g., `window`, `globalThis`) using `$self`.
- **Syntax**: `(global.get $self.path.to.prop)`
- **Compilation**:
  - Automatically generates `Reflect.get` chains.
  - Caches the result in a local or table if needed.
- **Example**: `(global.get $self.console)`

## 3. Function Calls with Generics (`<Types>`)
Call host functions with specific type signatures.
- **Syntax**: `(call $self.path.func <P1.P2>R)`
  - `P` = Param types (dot-separated)
  - `R` = Result type (optional)
- **Example**:
  - `(call $self.console.log <ext>ext ...)`
  - `(call $self.Math.random <>f32)`

## 4. `(text "...")` Literal
Injects a string into the data segment and returns an `externref` to a `String` object.
- **Syntax**: `(text "Hello World")`
- **Behavior**:
  - Encodes string to data segment.
  - On init, creates a `TextDecoder` and converts bytes to JS String.
  - Returns the `externref` index from the table.

## 5. `(include "path")`
Includes another WAT file.
- **Syntax**: `(include "foo.wat")`

## 6. Arrays & Reflection Wrappers
- `(array ...)`: Creates a JS Array from arguments.
- `(apply ...)`: Wrapper for `Reflect.apply`.
- `(construct ...)`: Wrapper for `Reflect.construct`.

## 7. Initialization
- `(oninit (block ...))`: Code to run during the `$wat4wasm` bootstrap phase.
