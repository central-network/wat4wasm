(module
    (include "./test-sub.wat")

    (global $self.screen.width f32)
    (global $self.location.origin externref)
    (global $self.console.warn externref)
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

        (call $self.requestAnimationFrame<fun>
            (ref.func $onanimationframe<f32>)
        )

        (call $self.setTimeout<fun.i32>
            (ref.func $ontimeout)
            (i32.const 1000)
        )
    )

    (func $onanimationframe<f32>
        (param $performance.now f32)
        (call $self.console.log<ref.f32>
            (text "animation frame ready:") 
            (local.get $performance.now)
        )
    )

    (func $ontimeout
        (call $self.console.warn<ref> 
            (text "timer done, 1000ms passed..")
        )
    )
)