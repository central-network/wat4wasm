(module
    (import "console" "log" (func $self.console.log<f32> (param f32)))
    (import "console" "warn" (func $self.console.warn<f32> (param f32)))
    (import "console" "warn" (func $self.console.warn<i32> (param i32)))

    (func $Array
    
        (string "hello
            asd\"asd\" 11
        f1")
        (drop)

        (string "helözgür
            asd(a)sd
            f2")
        (drop)
        
        (string "hello")
        (drop)

        (string "getPrototypeOf")
        (drop)

        (string "özgür")
        (drop)

        (string "şık")
        (drop)

        (string "get")
        (drop)
    )

    (data $filread "file://test-out.txt")
    (include "test-include.wat")
    (start $Array)

    (func $calc)
    (export "calc" (func $calc))
)