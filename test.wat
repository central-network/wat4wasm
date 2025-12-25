(module
    (import "console" "log" (func $self.console.log<ext> (param externref)))
    (import "console" "warn" (func $self.console.warn<f32> (param f32)))
    (import "console" "warn" (func $self.console.warn<i32> (param i32)))
    (import "Reflect" "get"         (func $self.Reflect.get<ext.ext>ext (param externref externref) (result externref) ))
    (import "Reflect" "set"         (func $self.Reflect.set<ext.i32.i32> (param externref i32 i32)))
    (import "Reflect" "apply"       (func $self.Reflect.apply<ext.ext.ext>ext (param externref externref externref) (result externref)))
    (import "Reflect" "construct"   (func $self.Reflect.construct<ext.ext>ext (param externref externref) (result externref)))
    (import "Array" "of"            (func $self.Array.of<ext>ext (param externref) (result externref)))
    (import "Array" "of"            (func $self.Array.of<i32>ext (param i32) (result externref)))
    (import "self" "Array"            (func $self.Array<>ext (param) (result externref)))
    (import "self" "self"           (global $self externref))
    (import "String" "fromCharCode" (global $self.String.fromCharCode externref))

    (func $Array
    
        (text "hello
            asd\"asd\" 11
        f1")
        (call $self.console.log<ext>)

        (string "helözgür
            asd(a)sd
            f2")
        (call $self.console.log<ext>)
        
        (string "hello")
        (call $self.console.log<ext>)

        (text "getPrototypeOf")
        (call $self.console.log<ext>)

        (string "özgür")
        (call $self.console.log<ext>)

        (string "get")
        (call $self.console.log<ext>)

        (text "get")
        (call $self.console.log<ext>)

        (text "getPrototypeOf")
        (call $self.console.log<ext>)

        (text "get")
        (call $self.console.log<ext>)

    )

    (data $filread "file://test-out.txt")
    (include "test-include.wat")

    (func $calc)
    (export "calc" (func $calc))
    (start $Array)

    (memory 1)
)