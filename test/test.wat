(module 
    (data $module "wasm://boot.wat")
    (data $script "file://test_worker.js")

    (include "test-sub.wat")
    
    (main $init
        (text "me") i32(1) f32(2.2) i64(4) f64(1)
        (console $warn<ext.i32.f32.i64.f64>)
        
        (async
            (reflect $apply<ext.ext.ext>ext 
                (ref.extern $self.WebAssembly.instantiate<ext>) 
                (ref.extern $self.WebAssembly<ext>) 
                (array $of<ext.ext>ext 
                    (data.view $module)
                    (self)
                )
            )
            (then $oninstance
                (param $instantiate <Object>)

                (console $log<ext.ext> 
                    (reflect $get<ext.ext>ext (this) (text "module"))
                    (reflect $get<ext.ext>ext (this) (text "instance"))
                )
            )
            (catch ref.func $onwasmfailure)
            (finally $finallyblock
                (console $log<ext> (self))
            )
        )
    )

    (func $onwasmfailure
        (param $error externref)
        
        (console $error<ext.ext.ext>
            (local.get $error)
            (lget $error)
            (this)
        )
    )
)




















