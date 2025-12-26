(module
    (memory 1)
    
    (data $boot.wasm "wasm://boot.wat")
    (data $worker.js "file://worker.js")

    (func $main
        (text "özgür")
        (call $self.console.log<ext>)

        (global.get $self.GPUAdapter:limits[get])
        (call $self.console.log<ext>)

        (global.get $self.navigator.geolocation.clearWatch.length<f64>)
        (call $self.console.log<f64>)

        (ref.extern $self.GPUAdapter:features[get])
        (call $self.console.log<ext>)
    )

    (start $main)
)