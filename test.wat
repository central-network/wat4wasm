(module

    (func $main
        (text "özgür")
        (call $self.console.warn<ext>)

        (global.get $self.GPUAdapter:limits[get])
        (call $self.console.log<ext>)

        (global.get $self.navigator.geolocation.clearWatch.length<f64>)
        (call $self.console.error<f64>)

        (ref.extern $self.GPUAdapter:features[get])
        (call $self.console.warn<ext>)
    )

    (start $main)

)