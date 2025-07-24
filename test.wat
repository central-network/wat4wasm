(module
    (include "./test-sub.wat")

    (global $self.screen.width f32)
    (global $self.Math externref)
    (global $self.Math.max externref)
    (global $self.location.origin externref)
    (global $self.console.warn externref)
    (global $self.MessageEvent.prototype.data/get externref)
    (global $self.Worker:onmessage/set externref)

    (global $ANY_TEXT_GLOBAL "any text global")

    (memory 10 10 shared)

    (start $main
        (log<ref> (text "interal text converted to table.get!"))
        (log<ref> (global.get $self.location.origin))
        (log<f32> (global.get $self.screen.width))
        (log<ref> (global.get $self.MessageEvent.prototype.data/get))
        (log<ref> (global.get $self.Worker:onmessage/set))
        (warn<ref> (global.get $ANY_TEXT_GLOBAL))


        (apply $self.Math.max<i32x3.f32>i32 
            (self)
            (param
                (i32.const 2)
                (i32.const 4)
                (i32.const 5)
                (f32.const 1122.2)
            )
        )
        (error<i32>)
        
        (call $self.requestAnimationFrame<fun>
            (func $inlinefunction<f32>
                (param $performance.now f32)

                (log<ref.f32>
                    (text "animation frame ready:") 
                    (local.get $performance.now)
                )
            )
        )
    )
)