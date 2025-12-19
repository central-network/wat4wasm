(module

    (import "console" "warn" (func $warn (param externref)))

    (func $main

        (text "GPUAdapter")
        (call $warn)

        (table.get $self.GPUAdapter)
        (call $warn)

        (table.get $self.GPUAdapter:requestDevice)
        (call $warn)

        (table.get $self.MessageEvent:data[getter])
        (call $warn)

        (global.get $self.location.origin)
        (call $warn)

        (table.get $self.location.href)
        (call $warn)

        (table.get $self.GPU:wgslLanguageFeatures[get])
        (call $warn)

    )

    (start $main)
)