(module
	(import "console" "warn"                     (func $warn                                              (param externref)))
	(import "console" "warn"                     (func $warn/i                                            (param i32)))
	(import "Array" "of"                         (func $self.Array.of<ext>ext                             (param externref) (result externref)))
	(import "self" "self"                        (global $self                                            externref))
	(import "Reflect" "get"                      (func $self.Reflect.get<ext.ext>ext                      (param externref externref) (result externref)))
	(import "Reflect" "get"                      (func $self.Reflect.get<ext.ext>i32                      (param externref externref) (result i32)))
	(import "Reflect" "set"                      (func $self.Reflect.set<ext.i32.i32>                     (param externref i32 i32) (result)))
	(import "Reflect" "apply"                    (func $self.Reflect.apply<ext.ext.ext>ext                (param externref externref externref) (result externref)))
	(import "Reflect" "construct"                (func $self.Reflect.construct<ext.ext>ext                (param externref externref) (result externref)))
	(import "String" "fromCharCode"              (global $self.String.fromCharCode                        externref))
	(import "Reflect" "getOwnPropertyDescriptor" (func $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext (param externref externref) (result externref)))

	(func $main
		(table.get $wat4wasm (i32.const 1)) ;; "GPUAdapter"

		(call $warn)
		(table.get $wat4wasm (i32.const 2)) ;; $self.GPUAdapter

		(call $warn)
		(table.get $wat4wasm (i32.const 3)) ;; $self.window

		(call $warn)
		(table.get $wat4wasm (i32.const 4)) ;; $self.GPUAdapter.prototype.requestDevice

		(call $warn)
		(table.get $wat4wasm (i32.const 5)) ;; $self.MessageEvent.prototype.data/get

		(call $warn)
		(global.get $self.location.origin)

		(call $warn)
		(table.get $wat4wasm (i32.const 6)) ;; $self.location.href

		(call $warn)
		(table.get $wat4wasm (i32.const 7)) ;; $self.length/set

		(call $warn)
		(table.get $wat4wasm (i32.const 8)) ;; $self.GPU.prototype.wgslLanguageFeatures/get

		(call $warn)
		(global.get $self.window.length)

		(call $warn/i)
	)
	(global $self.location.origin (mut externref) (ref.null extern))
	(global $self.window.length   (mut i32) (i32.const 0))
	(elem   $wat4wasm declare func $wat4wasm)
	(func   $wat4wasm ;; @tokbuga 💚
		(local $TextDecoder  externref)
		(local $decode       externref)
		(local $arguments    externref)
		(local $Uint8Array   externref)
		(local $view         externref)
		(local $buffer       externref)
		(local $byteLength   i32)
		(local $decodedText  externref)
		(local $value/i32    i32)
		(local $value/f32    f32)
		(local $value/i64    i64)
		(local $value/f64    f64)
		(local $value/ext    externref)
		(local $value/fun    funcref)
		(local $level/0      externref)
		(local $level/1      externref)
		(local $level/2      externref)
		(local $level/3      externref)
		(local $level/4      externref)

		(block $init
			(local.set $byteLength (i32.const 108))
			(local.set $level/0 (global.get $self))

			(block $TextDecoder
				(local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  0) (i32.const  84)) ;; T
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  1) (i32.const 101)) ;; e
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  2) (i32.const 120)) ;; x
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  3) (i32.const 116)) ;; t
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  4) (i32.const  68)) ;; D
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  5) (i32.const 101)) ;; e
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  6) (i32.const  99)) ;; c
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  7) (i32.const 111)) ;; o
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  8) (i32.const 100)) ;; d
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  9) (i32.const 101)) ;; e
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 10) (i32.const 114)) ;; r

				(local.set $TextDecoder
					(call $self.Reflect.construct<ext.ext>ext
						(call $self.Reflect.get<ext.ext>ext
							(global.get $self)
							(call $self.Reflect.apply<ext.ext.ext>ext
								(global.get $self.String.fromCharCode)
								(ref.null extern)
								(local.get $arguments)
							)
						)
						(global.get $self)
					)
				)
			)

			(block $TextDecoder:decode
				(local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  0) (i32.const 100)) ;; d
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  1) (i32.const 101)) ;; e
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  2) (i32.const  99)) ;; c
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  3) (i32.const 111)) ;; o
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  4) (i32.const 100)) ;; d
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  5) (i32.const 101)) ;; e

				(local.set $decode
					(call $self.Reflect.get<ext.ext>ext
						(local.get $TextDecoder)
						(call $self.Reflect.apply<ext.ext.ext>ext
							(global.get $self.String.fromCharCode)
							(ref.null extern)
							(local.get $arguments)
						)
					)
				)
			)

			(block $Uint8Array
				(local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  0) (i32.const  85)) ;; U
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  1) (i32.const 105)) ;; i
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  2) (i32.const 110)) ;; n
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  3) (i32.const 116)) ;; t
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  4) (i32.const  56)) ;; 8
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  5) (i32.const  65)) ;; A
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  6) (i32.const 114)) ;; r
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  7) (i32.const 114)) ;; r
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  8) (i32.const  97)) ;; a
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  9) (i32.const 121)) ;; y

				(local.set $Uint8Array
					(call $self.Reflect.get<ext.ext>ext
						(global.get $self)
						(call $self.Reflect.apply<ext.ext.ext>ext
							(global.get $self.String.fromCharCode)
							(ref.null extern)
							(local.get $arguments)
						)
					)
				)
			)

			(block $view
				(local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))

				(call $self.Reflect.set<ext.i32.i32>
					(local.get $arguments)
					(i32.const 0)

					(local.get $byteLength)
				)

				(local.set $view
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(local.get $arguments)
					)
				)
			)

			(block $memory.init
				(i32.const 0)
				(i32.const 0)
				(i32.load)

				(loop $i--
					(local.set $byteLength (i32.sub (local.get $byteLength) (i32.const 1)))
					(memory.init $wat4wasm (i32.const 0) (local.get $byteLength) (i32.const 1))

					(call $self.Reflect.set<ext.i32.i32>
						(local.get $view)
						(local.get $byteLength)
						(i32.load8_u (i32.const 0))
					)

					(br_if $i-- (local.get $byteLength))
				)
				(i32.store)
				(data.drop $wat4wasm)
			)

			(block $buffer
				(local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 0) (i32.const  98))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 117))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 102))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 3) (i32.const 102))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 4) (i32.const 101))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 5) (i32.const 114))

				(local.set $buffer
					(call $self.Reflect.get<ext.ext>ext
						(local.get $view)
						(call $self.Reflect.apply<ext.ext.ext>ext
							(global.get $self.String.fromCharCode)
							(ref.null extern)
							(local.get $arguments)
						)
					)
				)
			)
		)

		(block $text
			(local.set $arguments (call $self.Array.of<ext>ext (local.get $buffer)))
			(block $text<4:10> ;; "GPUAdapter"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 4))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 10))

				(local.set $decodedText
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $decode)
						(local.get $TextDecoder)
						(call $self.Array.of<ext>ext
							(call $self.Reflect.construct<ext.ext>ext
								(local.get $Uint8Array)
								(local.get $arguments)
							)
						)
					)
				)
				(table.set $wat4wasm (i32.const 1) (local.get $decodedText))
			)

			(block $text<14:6> ;; "window"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 14))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 6))

				(local.set $decodedText
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $decode)
						(local.get $TextDecoder)
						(call $self.Array.of<ext>ext
							(call $self.Reflect.construct<ext.ext>ext
								(local.get $Uint8Array)
								(local.get $arguments)
							)
						)
					)
				)
				(table.set $wat4wasm (i32.const 9) (local.get $decodedText))
			)

			(block $text<20:9> ;; "prototype"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 20))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 9))

				(local.set $decodedText
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $decode)
						(local.get $TextDecoder)
						(call $self.Array.of<ext>ext
							(call $self.Reflect.construct<ext.ext>ext
								(local.get $Uint8Array)
								(local.get $arguments)
							)
						)
					)
				)
				(table.set $wat4wasm (i32.const 10) (local.get $decodedText))
			)

			(block $text<29:13> ;; "requestDevice"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 29))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 13))

				(local.set $decodedText
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $decode)
						(local.get $TextDecoder)
						(call $self.Array.of<ext>ext
							(call $self.Reflect.construct<ext.ext>ext
								(local.get $Uint8Array)
								(local.get $arguments)
							)
						)
					)
				)
				(table.set $wat4wasm (i32.const 11) (local.get $decodedText))
			)

			(block $text<42:12> ;; "MessageEvent"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 42))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 12))

				(local.set $decodedText
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $decode)
						(local.get $TextDecoder)
						(call $self.Array.of<ext>ext
							(call $self.Reflect.construct<ext.ext>ext
								(local.get $Uint8Array)
								(local.get $arguments)
							)
						)
					)
				)
				(table.set $wat4wasm (i32.const 12) (local.get $decodedText))
			)

			(block $text<54:4> ;; "data"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 54))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 4))

				(local.set $decodedText
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $decode)
						(local.get $TextDecoder)
						(call $self.Array.of<ext>ext
							(call $self.Reflect.construct<ext.ext>ext
								(local.get $Uint8Array)
								(local.get $arguments)
							)
						)
					)
				)
				(table.set $wat4wasm (i32.const 13) (local.get $decodedText))
			)

			(block $text<58:3> ;; "get"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 58))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 3))

				(local.set $decodedText
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $decode)
						(local.get $TextDecoder)
						(call $self.Array.of<ext>ext
							(call $self.Reflect.construct<ext.ext>ext
								(local.get $Uint8Array)
								(local.get $arguments)
							)
						)
					)
				)
				(table.set $wat4wasm (i32.const 14) (local.get $decodedText))
			)

			(block $text<61:8> ;; "location"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 61))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 8))

				(local.set $decodedText
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $decode)
						(local.get $TextDecoder)
						(call $self.Array.of<ext>ext
							(call $self.Reflect.construct<ext.ext>ext
								(local.get $Uint8Array)
								(local.get $arguments)
							)
						)
					)
				)
				(table.set $wat4wasm (i32.const 15) (local.get $decodedText))
			)

			(block $text<69:6> ;; "origin"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 69))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 6))

				(local.set $decodedText
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $decode)
						(local.get $TextDecoder)
						(call $self.Array.of<ext>ext
							(call $self.Reflect.construct<ext.ext>ext
								(local.get $Uint8Array)
								(local.get $arguments)
							)
						)
					)
				)
				(table.set $wat4wasm (i32.const 16) (local.get $decodedText))
			)

			(block $text<75:4> ;; "href"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 75))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 4))

				(local.set $decodedText
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $decode)
						(local.get $TextDecoder)
						(call $self.Array.of<ext>ext
							(call $self.Reflect.construct<ext.ext>ext
								(local.get $Uint8Array)
								(local.get $arguments)
							)
						)
					)
				)
				(table.set $wat4wasm (i32.const 17) (local.get $decodedText))
			)

			(block $text<79:6> ;; "length"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 79))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 6))

				(local.set $decodedText
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $decode)
						(local.get $TextDecoder)
						(call $self.Array.of<ext>ext
							(call $self.Reflect.construct<ext.ext>ext
								(local.get $Uint8Array)
								(local.get $arguments)
							)
						)
					)
				)
				(table.set $wat4wasm (i32.const 18) (local.get $decodedText))
			)

			(block $text<85:3> ;; "set"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 85))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 3))

				(local.set $decodedText
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $decode)
						(local.get $TextDecoder)
						(call $self.Array.of<ext>ext
							(call $self.Reflect.construct<ext.ext>ext
								(local.get $Uint8Array)
								(local.get $arguments)
							)
						)
					)
				)
				(table.set $wat4wasm (i32.const 19) (local.get $decodedText))
			)

			(block $text<4:3> ;; "GPU"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 4))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 3))

				(local.set $decodedText
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $decode)
						(local.get $TextDecoder)
						(call $self.Array.of<ext>ext
							(call $self.Reflect.construct<ext.ext>ext
								(local.get $Uint8Array)
								(local.get $arguments)
							)
						)
					)
				)
				(table.set $wat4wasm (i32.const 20) (local.get $decodedText))
			)

			(block $text<88:20> ;; "wgslLanguageFeatures"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 88))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 20))

				(local.set $decodedText
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $decode)
						(local.get $TextDecoder)
						(call $self.Array.of<ext>ext
							(call $self.Reflect.construct<ext.ext>ext
								(local.get $Uint8Array)
								(local.get $arguments)
							)
						)
					)
				)
				(table.set $wat4wasm (i32.const 21) (local.get $decodedText))
			)
		)

		(block $self
			(block $self.GPUAdapter
				(block $self.GPUAdapter
					(local.set $value/ext
						(local.tee $level/1
							(call $self.Reflect.get<ext.ext>ext
								(local.get $level/0)
								(table.get $wat4wasm (i32.const 1)) ;; "GPUAdapter"
							)
						)
					)
					(table.set $wat4wasm (i32.const 2) (local.get $value/ext))
				)

				(block $self.GPUAdapter.prototype
					(local.set $level/2
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/1)
							(table.get $wat4wasm (i32.const 10)) ;; "prototype"
						)
					)
				)

				(block $self.GPUAdapter.prototype.requestDevice
					(local.set $value/ext
						(local.tee $level/3
							(call $self.Reflect.get<ext.ext>ext
								(local.get $level/2)
								(table.get $wat4wasm (i32.const 11)) ;; "requestDevice"
							)
						)
					)
					(table.set $wat4wasm (i32.const 4) (local.get $value/ext))
				)
			)

			(block $self.window
				(block $self.window
					(local.set $value/ext
						(local.tee $level/1
							(call $self.Reflect.get<ext.ext>ext
								(local.get $level/0)
								(table.get $wat4wasm (i32.const 9)) ;; "window"
							)
						)
					)
					(table.set $wat4wasm (i32.const 3) (local.get $value/ext))
				)

				(block $self.window.length
					(local.set $value/i32
						(call $self.Reflect.get<ext.ext>i32
							(local.get $level/1)
							(table.get $wat4wasm (i32.const 18)) ;; "length"
						)
					)
					(global.set $self.window.length (local.get $value/i32))
				)
			)

			(block $self.MessageEvent
				(block $self.MessageEvent
					(local.set $level/1
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/0)
							(table.get $wat4wasm (i32.const 12)) ;; "MessageEvent"
						)
					)
				)

				(block $self.MessageEvent.prototype
					(local.set $level/2
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/1)
							(table.get $wat4wasm (i32.const 10)) ;; "prototype"
						)
					)
				)

				(block $self.MessageEvent.prototype.data
					(local.set $level/3
						(call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
							(local.get $level/2)
							(table.get $wat4wasm (i32.const 13)) ;; "data"
						)
					)
				)

				(block $self.MessageEvent.prototype.data/get
					(local.set $level/4
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/3)
							(table.get $wat4wasm (i32.const 14)) ;; "get"
						)
					)
					(table.set $wat4wasm (i32.const 5) (local.get $level/4))
				)
			)

			(block $self.location
				(block $self.location
					(local.set $level/1
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/0)
							(table.get $wat4wasm (i32.const 15)) ;; "location"
						)
					)
				)

				(block $self.location.href
					(local.set $value/ext
						(local.tee $level/2
							(call $self.Reflect.get<ext.ext>ext
								(local.get $level/1)
								(table.get $wat4wasm (i32.const 17)) ;; "href"
							)
						)
					)
					(table.set $wat4wasm (i32.const 6) (local.get $value/ext))
				)

				(block $self.location.origin
					(local.set $value/ext
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/1)
							(table.get $wat4wasm (i32.const 16)) ;; "origin"
						)
					)
					(global.set $self.location.origin (local.get $value/ext))
				)
			)

			(block $self.length
				(block $self.length
					(local.set $level/1
						(call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
							(local.get $level/0)
							(table.get $wat4wasm (i32.const 18)) ;; "length"
						)
					)
				)

				(block $self.length/set
					(local.set $level/2
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/1)
							(table.get $wat4wasm (i32.const 19)) ;; "set"
						)
					)
					(table.set $wat4wasm (i32.const 7) (local.get $level/2))
				)
			)

			(block $self.GPU
				(block $self.GPU
					(local.set $level/1
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/0)
							(table.get $wat4wasm (i32.const 20)) ;; "GPU"
						)
					)
				)

				(block $self.GPU.prototype
					(local.set $level/2
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/1)
							(table.get $wat4wasm (i32.const 10)) ;; "prototype"
						)
					)
				)

				(block $self.GPU.prototype.wgslLanguageFeatures
					(local.set $level/3
						(call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
							(local.get $level/2)
							(table.get $wat4wasm (i32.const 21)) ;; "wgslLanguageFeatures"
						)
					)
				)

				(block $self.GPU.prototype.wgslLanguageFeatures/get
					(local.set $level/4
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/3)
							(table.get $wat4wasm (i32.const 14)) ;; "get"
						)
					)
					(table.set $wat4wasm (i32.const 8) (local.get $level/4))
				)
			)
		)

		(call $main))
	(data   $wat4wasm "\00\00\00\00\47\50\55\41\64\61\70\74\65\72\77\69\6e\64\6f\77\70\72\6f\74\6f\74\79\70\65\72\65\71\75\65\73\74\44\65\76\69\63\65\4d\65\73\73\61\67\65\45\76\65\6e\74\64\61\74\61\67\65\74\6c\6f\63\61\74\69\6f\6e\6f\72\69\67\69\6e\68\72\65\66\6c\65\6e\67\74\68\73\65\74\77\67\73\6c\4c\61\6e\67\75\61\67\65\46\65\61\74\75\72\65\73")
	(table  $wat4wasm 22 externref)
	(start  $wat4wasm)
	(global $wat4wasm             (mut externref) (ref.null extern))
	(memory $wat4wasm 1)
)