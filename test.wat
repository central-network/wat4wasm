(module

    (import "console" "warn" (func $warn (param externref)))
    (import "console" "warn" (func $warn/i (param i32)))

    (func $main

        (text "GPUAdapter")
        (call $warn)

        (table.get $self.GPUAdapter)
        (call $warn)

        (table.get $self.window)
        (call $warn)

        (table.get $self.GPUAdapter:requestDevice)
        (call $warn)

        (table.get $self.MessageEvent:data[get])
        (call $warn)

        (global.get $self.location.origin)
        (call $warn)

        (table.get $self.location.href)
        (call $warn)

        (table.get $self.length[set])
        (call $warn)

        (table.get $self.GPU:wgslLanguageFeatures[get])
        (call $warn)

        (global.get $self.window.length i32)
        (call $warn/i)

    )

    (start $main)
)