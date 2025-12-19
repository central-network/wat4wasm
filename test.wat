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

        (array
            (param ext ext i32 ext ext i32)
            (result i32)

            (global.get $self.window.clientInformation)
            (global.get $self.window.clientInformation.appName)
            (global.get $self.window.clientInformation.cpuPerformance i32)
            (global.get $self.window.alert)
            (table.get $self.window.name)
            (global.get $self.window.length i32)
        )
        (call $warn)

    )

    (start $main)
)