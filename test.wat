(module
    (data $boot.wasm "wasm://boot.wat")
    (data $worker.js "file://worker.js")

    (include "test/test-sub.wat")

    (func $main
        (data.size $boot.wasm)
        (call $self.console.warn<i32>)

        (text "özgür")
        (call $self.console.log<ext>)

        (new $Worker<ext>ext (text "worker.js"))
        (console $log<ext>)

        (new $Object)
        (console $log<ext>)

        (ref.func $elemreq)
        (console $log<fun>)

        (async
            (apply.ext 
                (self $navigator.gpu.requestAdapter<ext>) 
                (self $navigator.gpu<ext>)
                (array)
            )
            (then $onadapter
                (param $adapter externref)
                (console $warn<ext> (this))
            )
            (catch (ref.func $promise.catch))
            (finally 
                (param $promise externref)
                (console $log<ext> (this))
            )
        )

    )

    (func $elemreq)
    (func $promise.then0)
    (func $promise.then1)
    (func $promise.catch)
    (func $promise.finally)

    (memory 10)

    (start $main)
)