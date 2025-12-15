// lib/standardLibrary.js

export function getStandardImports() {
    return (`
    (import "self" "self" (global $self externref))
    (import "self" "Array" (func $self.Array<>ref (param) (result externref)))
    `);
}

export function processSimpleMacros(source) {
    return source
        .replaceAll("(null)", "(ref.null extern)")
        .replaceAll("(self)", "(global.get $self)")
        .replaceAll("(this)", "(local.get 0)");
}