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

        (apply $self.Math.random f32)
        (error<f32>)

        (call $self.Math.random f32)
        (warn<f32>)

        (apply $self.Math.random)
        (nop)

        (apply $self.Math.random ref)
        (drop)

        (construct $self.Uint8Array<i32>ref 
            (param
                (i32.const 3)
            )
        )
        (warn<ref>)

        (new $Uint8Array<i32> i32(4))
        (warn<ref>)

        (new $Number<f32> f32(4.4))
        (warn<ref>)

        (new $Worker<ref> (text "worker.js"))
        (warn<ref>)

        (construct $self.Worker<refx2>ref 
            (text "worker.js")
            (new $Object)
        )
        (warn<ref>)


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