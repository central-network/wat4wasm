(module
    (import "console" "log" (func $console.log (param externref)))

    (include "./test-sub.wat")

    (start $main
        (call $console.log
            (text "hello world!")
        )
    )
)