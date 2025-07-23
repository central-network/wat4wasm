(module $test

    (import "console" "warn" (func $warn<ref> (param externref)))
    (import "self" "self" (global $self externref))

    (include "./test-sub.wat")

    (start $main
    
    )
)