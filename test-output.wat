(module
	(import "console" "log" (func $self.console.log<f32> (param f32)))
	(memory 1 10 shared)
	(data $filread "file://test-out.txt"})
	(data (i32.const 0) "\1a\2b\ff\ee"})
	(ref.func $inlinefunction<f32>)
)
