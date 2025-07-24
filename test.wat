(module
    (include "./test-sub.wat")

    (global $self.screen.width f32)
    (global $self.location.origin externref)
    (global $self.MessageEvent.prototype.data/get externref)
    (global $self.Worker:onmessage/set externref)

    (global $ANY_TEXT_GLOBAL "any text global")

    (memory 10 10 shared)

    (start $main
        (call $self.console.log<ref> (text "interal text converted to table.get!"))
        (call $self.console.log<ref> (global.get $self.location.origin))
        (call $self.console.log<f32> (global.get $self.screen.width))
        (call $self.console.log<ref> (global.get $self.MessageEvent.prototype.data/get))
        (call $self.console.log<ref> (global.get $self.Worker:onmessage/set))
        (call $self.console.log<ref> (global.get $ANY_TEXT_GLOBAL))


        (call $self.console.error<ref>
            (call $self.Array.of<i32x3.f32>ref
                (i32.const 2)
                (i32.const 4)
                (i32.const 5)
                (f32.const 2.2)
            )
        )


    )
)