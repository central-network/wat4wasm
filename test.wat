(module
    (data $boot.wasm "wasm://boot.wat")
    (data $worker.js "file://worker.js")

    (func $main
        (data.size $boot.wasm)
        (call $self.console.warn<i32>)

        (text "özgür")
        (call $self.console.log<ext>)

        (ref.extern $self.Worker<ext>)    
        (console $log<ext>)

        (new $Worker<ext>ext    
            (text "worker.js")
        )
        (console $log<ext>)

        (new $Number)
        (console $warn<ext>)

        (new $Object)
        (console $log<ext>)

        (ref.func $elemreq)
        (console $log<fun>)

        (table.get $wat4wasm (i32.const 3))
        (console $error<ext>)
    )

    (func $elemreq)

    (memory 10)

    (start $main)
)