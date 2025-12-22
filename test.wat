(module
    (import "console" "log" (func $self.console.log<f32> (param f32)))
    (ref.func $inlinefunction<f32>)

    (memory 1)
    (data $filread "file://test-out.txt")
    (include "test-include.wat")
)