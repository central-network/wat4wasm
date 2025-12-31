(module 
    (data $module "wasm://boot.wat")
    (data $script "file://test_worker.js")

    (include "test-sub.wat")
    
    (main $init
        (text "me") i32(1) f32(2.2) i64(4) f64(1)
        (console $warn<ext.i32.f32.i64.f64>)
        
        (async
            (reflect $apply<ext.ext.ext>ext 
                (self $GPU:requestAdapter<ext>) 
                (self $navigator.gpu<ext>) 
                (array $of<ext>ext 
                    (object)
                )
            )
            (then $onadapterinlinefunction
                (param $adapter <GPUAdapter>)
                (console $log<ext> (local.get $adapter))
            )
            (catch ref.func $onrequestfailure)
            (finally $finallyblock
                (console $log<ext> (self))
            )
        )
    )

    (func $onrequestfailure
        (param $error externref)
        
        (console $error<ext.ext.ext>
            (local.get $error)
            (lget $error)
            (this)
        )
    )
)




















