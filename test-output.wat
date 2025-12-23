(module
	(import "console" "log"  (func $self.console.log<f32>  (param f32)))
	(import "console" "warn" (func $self.console.warn<f32> (param f32)))
	;; developer
	(memory 1 10 shared)

	(func $Array
		(global.get $self.history.length<i32>)
	)
	(data $filread "file://test-out.txt")
	(data (i32.const 0) "\1a\2b\ff\ee")
	;; $wat4wasm
	(global $wat4wasm (mut extern) (ref.null externref))
	(table $wat4wasm externref)
	(func $wat4wasm
		(local $TextDecoder externref)
		(local $arguments externref)

		(call $self.Reflect.set<ext.i32.fun> (local.get $arguments) (i32.const 0) (i32.const 25))
		(call $self.Reflect.set<ext.v128.fun.i64.f64.ext>fun.i64.f64.ext (local.get $arguments) (i32.const 0) (i32.const 25))

		(block $prepare
			(block $TextDecoder
				(local.set $arguments (call $self.Array<i32>ext (i32.const 0)))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 0) (i32.const 25))

				(local.set $TextDecoder
					(call $self.Reflect.construct<ext.ext>ext
						(call $self.Reflect.get<ext.ext>ext
							(global.get $self)
							(call $self.Reflect.apply<ext.ext.ext>ext
								(global.get $self.String.fromCharCode<ext>)
								(ref.null externref)
								(local.get $arguments)
							)
						)
						(global.get $self)
					)
				)
			)
		)

		(call $main)
		(call $main2)
	)
	(elem $wat4wasm declare func $wat4wasm)
	(data $wat4wasm "\00\00\00\00")
	(start $wat4wasm)
)
