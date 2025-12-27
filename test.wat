(module
    (data $boot.wasm "wasm://boot.wat")
    (data $worker.js "file://worker.js")

    (include "test/test-sub.wat")

    (global $a mut i32)
    (global $b mut ext)
    (global $c mut fun)
    (global $d mut vec)

    (func $main
        (local $i i32)
        (local $d f32)
        (local $c ext)

        (ltee -- $i)
        (call $self.console.log<i32>)

        (ltee ++ $i)
        (call $self.console.log<i32>)

        (lset $i i32(- 4))
        (lset $d f32(- 4.3))
        (lset $d f32(+ 2.1))

        (if (gget $b == null) 
            (then nop)
        )

        (if (gget $b == undefined) 
            (then nop)
        )

        (if (gget $b != "") 
            (then nop)
        )

        (if (lget $i == 0) 
            (then nop)
        )

        (if (lget $d == nan) 
            (then nop)
        )

        (data.size $boot.wasm)
        (call $self.console.log<i32>)

        (text "özgür")
        (call $self.console.log<ext>)

        (new $Worker<ext>ext (text "worker.js"))
        (console $log<ext>)

        (async
            (reflect $apply<ext.ext.ext>ext 
                (self $GPU:requestAdapter) 
                (self $navigator.gpu)
                (array)
            )
            (then $ongpuadapter
                (param $adapter <GPUAdapter>)
                (result <Promise>)

                (console $log<ext.ext> 
                    (lget $adapter)
                    (text "async call adapter reached")
                )
                
                (reflect $apply<ext.ext.ext>ext 
                    (self $GPUAdapter:requestDevice) 
                    (lget $adapter)
                    (array)
                )
            )
            (then $ongpudevice
                (param $device <GPUDevice>)

                (console $log<ext.ext> 
                    (this)
                    (text "async call device reached")
                )
            )
            (catch ref.func $onasynccallfail)
            (finally 
                (console $log<ext> 
                    (text "async call finally reached")
                )
            )
        )
    )

    (func $onasynccallfail
        (param $error <Error>)
        
        (console $log<ext>
            (new $Error<ext>ext (this))
        )
    )

    (memory 10)
    (start $main)
)