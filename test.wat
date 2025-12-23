(module
    (ref.func $inlinefunction<f32>)

    (func $Array
    
        (global.get $self.history.length<i32>)
    )

    (memory 1 10 shared)
    (data $filread "file://test-out.txt")
    (import "console" "log" (func $self.console.log<f32> (param f32)))
    (include "test-include.wat")
    (import "console" "warn" (func $self.console.warn<f32> (param f32)))

    (start $main)
    (start $main2)
)