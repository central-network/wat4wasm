(module

    (func $main
        (text "özgür")
        (call $self.console.warn<ext>)

        (global.get $self.performance.memory.totalJSHeapSize<i32>)
        (call $self.console.log<i32>)


        (global.get $self.navigator.geolocation.clearWatch.length<f64>)
        (call $self.console.error<f64>)

    )

    (start $main)

)