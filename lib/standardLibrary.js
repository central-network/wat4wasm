// lib/standardLibrary.js
let TableManager, InjectManager, ScopeManager;

export function setManagers(tableManager, injectManager, scopeManager) {
    TableManager = tableManager;
    InjectManager = injectManager;
    ScopeManager = scopeManager;
}

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