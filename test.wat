(module
    (import "console" "log" (func $log<ref> (param externref)))
    (import "console" "log" (func $log<f32> (param f32)))

    (include "./test-sub.wat")

    (global $self.screen.width f32)
    (global $self.location.origin externref)
    (global $self.MessageEvent.prototype.data/get externref)
    (global $self.Worker:onmessage/set externref)

    (global $ANY_TEXT_GLOBAL "any text global")

    (memory 10 10 shared)

    (start $main
        (call $log<ref> (text "interal text converted to table.get!"))
        (call $log<ref> (global.get $self.location.origin))
        (call $log<f32> (global.get $self.screen.width))
        (call $log<ref> (global.get $self.MessageEvent.prototype.data/get))
        (call $log<ref> (global.get $self.Worker:onmessage/set))
        (call $log<ref> (global.get $ANY_TEXT_GLOBAL))
    )
)