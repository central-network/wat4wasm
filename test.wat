(module
    (data $boot.wasm "wasm://boot.wat")
    (data $worker.js "file://worker.js")

    (func $main
        (data.size $boot.wasm)
        (call $self.console.warn<i32>)

        (text "özgür")
        (call $self.console.log<ext>)

        (self $navigator.geolocation)
        (console $log<ext>)

        (self $GPUAdapter:features[get])
        (console $log<ext>)

        (data.size $boot.wasm)
        (console $warn<i32>)

        (data.view $boot.wasm)
        (console $warn<ext>)

        (apply.ext
            (self $WebAssembly.instantiate)
            (self $WebAssembly)
            (array $of<ext.ext>ext
                (data.view $boot.wasm)
                (self)
            )
        )
        (console $warn<ext>)

        (apply.i32
            (self $setTimeout)
            (null)
            (array)
        )
        (console $warn<i32>)

        (reflect $construct<ext.ext>ext
            (self $Worker)
            (object)
        )
        (console $log<ext>)

    )

    (memory 10)

    (start $main)
)