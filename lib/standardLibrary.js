// lib/standardLibrary.js

export function getStandardImports() {
    return `
    ;; --- Standard Library Imports ---
    (import "self" "self" (global $self externref))
    
    (import "Reflect" "apply" (func $self.Reflect.apply<ref.ref.ref> (param externref externref externref) (result externref)))
    (import "Reflect" "get" (func $self.Reflect.get<ref.ref>ref (param externref externref) (result externref)))
    (import "Reflect" "get" (func $self.Reflect.get<ref.i32>i32 (param externref i32) (result i32)))
    (import "Reflect" "set" (func $self.Reflect.set<ref.ref.i32> (param externref externref i32)))
    (import "Reflect" "construct" (func $self.Reflect.construct<ref.ref>ref (param externref externref) (result externref)))

    ;; YENİ: Descriptor alıcı (Getter/Setter'lara erişmek için şart)
    (import "Reflect" "getOwnPropertyDescriptor" (func $self.Reflect.getOwnPropertyDescriptor<ref.ref>ref (param externref externref) (result externref)))
    `;
}

export function processSimpleMacros(source) {
    return source
        .replaceAll("(null)", "(ref.null extern)")
        .replaceAll("(self)", "(global.get $self)")
        .replaceAll("(this)", "(local.get 0)");
}