(module
    (import "console" "log" (func $self.console.log<f32> (param f32)))
    (ref.func $inlinefunction<f32>)

    (memory 1 10 shared)
    (data $filread "file://test-out.txt")
    (include "test-include.wat")
)