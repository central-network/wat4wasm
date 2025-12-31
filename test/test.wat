(module 
    (data $module "wasm://boot.wat")
    (data $script "file://test_worker.js")

    (include "test-sub.wat")
    
    (main $init
        (text "hello world")
        (console $log<ext>)
        
        (async
            (reflect $apply<ext.ext.ext>ext 
                (self $GPU:requestAdapter<ext>) 
                (self $navigator.gpu<ext>) 
                (array)
            )
            (then $onadapter
                (param $adapter <GPUAdapter>)
                (console $log<ext> (this))
            )
        )
    )
)




















