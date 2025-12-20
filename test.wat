(module

    (import "console" "warn" (func $warn (param externref)))
    (import "console" "warn" (func $warn/i (param i32)))
    (import "console" "warn" (func $warn/f.e (param funcref externref) (result)))

    (func $main

        (call $self.console.warn<ext>
            (array
                (param ext ext ext ext f32 i32)
                (result ext)
                (ref.func $self.GPUAdapter:requestDevice)
                (ref.extern $self.console.warn)
                (global.get $self.console.warn)
                (ref.extern $self.location.origin)
                (call $self.Math.random<>f32)
                (call $self.requestAnimationFrame<fun>i32 
                    (ref.func $onanimationframe<f32>)
                )
            )
        )

        (apply
            (param fun ext ext)
            (result)

            (ref.func $self.console.log<ext.ext>)
            (null)
            (array
                (param fun ext)
                (result ext)

                (ref.func $self.console.warn)
                (ref.extern $self.console.warn)
            )
        )

    )

    (func $onanimationframe<f32>
        (param $epoch f32)
        (call $self.console.log<f32> (this))
    )

    (start $main)

    (data $testing "wasm://test/sub-folder/test-sub.wat")
)