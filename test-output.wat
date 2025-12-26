(module
	(import "Array" "of"            (func $self.Array.of<i32>ext              (param i32) (result externref)))
	(import "Array" "of"            (func $self.Array.of<ext>ext              (param externref) (result externref)))
	(import "self" "Array"          (func $self.Array<>ext                    (param) (result externref)))
	(import "Reflect" "set"         (func $self.Reflect.set<ext.i32.i32>      (param externref i32 i32) (result)))
	(import "Reflect" "apply"       (func $self.Reflect.apply<ext.ext.ext>ext (param externref externref externref) (result externref)))
	(import "Reflect" "get"         (func $self.Reflect.get<ext.ext>f64       (param externref externref) (result f64)))
	(import "Reflect" "get"         (func $self.Reflect.get<ext.ext>i32       (param externref externref) (result i32)))
	(import "String" "fromCharCode" (global $self.String.fromCharCode         externref))
	(import "self" "self"           (global $self                             externref))
	(import "console" "warn"        (func $self.console.warn<ext>             (param externref) (result)))
	(import "console" "log"         (func $self.console.log<i32>              (param i32) (result)))
	(import "console" "error"       (func $self.console.error<f64>            (param f64) (result)))
	(import "Reflect" "construct"   (func $self.Reflect.construct<ext.ext>ext (param externref externref) (result externref)))
	(import "Reflect" "get"         (func $self.Reflect.get<ext.ext>ext       (param externref externref) (result externref)))

	(func $main
		(table.get $wat4wasm (i32.const 8))
		(call $self.console.warn<ext>)
		(global.get $self.performance.memory.totalJSHeapSize<i32>)
		(call $self.console.log<i32>)
		(global.get $self.navigator.geolocation.clearWatch.length<f64>)
		(call $self.console.error<f64>)
	)
	(global $wat4wasm                                          (mut externref) (ref.null extern))
	(table $wat4wasm 9 externref)
	(elem $wat4wasm declare func $wat4wasm)
	(func $wat4wasm
		(local $textDecoder externref)
		(local $textDecoder.decode externref)
		(local $Uint8Array externref)
		(local $arguments externref)
		(local $arrayBufferView externref)
		(local $viewAt i32)
		(local $offset i32)
		(local $length i32)

		(block $prepare
			(local.set $textDecoder
				(call $self.Reflect.construct<ext.ext>ext
					(call $self.Reflect.get<ext.ext>ext
						(global.get $self)

						(block ;; "TextDecoder"
							(result   externref)
							(global.set $wat4wasm (call $self.Array<>ext))

							(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 0) (i32.const 84))
							(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 1) (i32.const 101))
							(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 2) (i32.const 120))
							(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 3) (i32.const 116))
							(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 4) (i32.const 68))
							(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 5) (i32.const 101))
							(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 6) (i32.const 99))
							(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 7) (i32.const 111))
							(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 8) (i32.const 100))
							(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 9) (i32.const 101))
							(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 10) (i32.const 114))

							(call $self.Reflect.apply<ext.ext.ext>ext
								(global.get $self.String.fromCharCode)
								(ref.null extern)
								(global.get $wat4wasm)
							)
						)
					)
					(global.get $self)
				)
			)

			(local.set $textDecoder.decode
				(call $self.Reflect.get<ext.ext>ext
					(local.get $textDecoder)

					(block ;; "decode"
						(result   externref)
						(global.set $wat4wasm (call $self.Array<>ext))

						(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 0) (i32.const 100))
						(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 1) (i32.const 101))
						(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 2) (i32.const 99))
						(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 3) (i32.const 111))
						(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 4) (i32.const 100))
						(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 5) (i32.const 101))

						(call $self.Reflect.apply<ext.ext.ext>ext
							(global.get $self.String.fromCharCode)
							(ref.null extern)
							(global.get $wat4wasm)
						)
					)
				)
			)

			(local.set $Uint8Array
				(call $self.Reflect.get<ext.ext>ext
					(global.get $self)

					(block ;; "Uint8Array"
						(result   externref)
						(global.set $wat4wasm (call $self.Array<>ext))

						(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 0) (i32.const 85))
						(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 1) (i32.const 105))
						(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 2) (i32.const 110))
						(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 3) (i32.const 116))
						(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 4) (i32.const 56))
						(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 5) (i32.const 65))
						(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 6) (i32.const 114))
						(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 7) (i32.const 114))
						(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 8) (i32.const 97))
						(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 9) (i32.const 121))

						(call $self.Reflect.apply<ext.ext.ext>ext
							(global.get $self.String.fromCharCode)
							(ref.null extern)
							(global.get $wat4wasm)
						)
					)
				)
			)
		)

		;;secure zero heap for memory.init
		(i32.const 0)
		(i32.load (i32.const 0))
		;; offset and value stacked now

		(block $oninit
			(block $decodeText/8:15

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 8))
				(local.set $length (i32.const 15))

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(call $self.Array.of<i32>ext (local.get $length))
					)
				)

				(loop $length--
					(if (local.get $length)
						(then
							(memory.init $wat4wasm
								(i32.const 0)

								(local.get $offset)
								(i32.const 1)
							)

							(call $self.Reflect.set<ext.i32.i32>
								(local.get $arrayBufferView)
								(local.get $viewAt)
								(i32.load8_u (i32.const 0))
							)

							(local.set $viewAt (i32.add (local.get $viewAt) (i32.const 1)))
							(local.set $offset (i32.add (local.get $offset) (i32.const 1)))
							(local.set $length (i32.sub (local.get $length) (i32.const 1)))

							(br $length--)
						)
					)
				)

				(local.set $arguments
					(call $self.Array.of<ext>ext
						(local.get $arrayBufferView)
					)
				)

				(table.set $wat4wasm (i32.const 1)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; total ... pSize
				))
			)

			(block $decodeText/23:6

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 23))
				(local.set $length (i32.const 6))

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(call $self.Array.of<i32>ext (local.get $length))
					)
				)

				(loop $length--
					(if (local.get $length)
						(then
							(memory.init $wat4wasm
								(i32.const 0)

								(local.get $offset)
								(i32.const 1)
							)

							(call $self.Reflect.set<ext.i32.i32>
								(local.get $arrayBufferView)
								(local.get $viewAt)
								(i32.load8_u (i32.const 0))
							)

							(local.set $viewAt (i32.add (local.get $viewAt) (i32.const 1)))
							(local.set $offset (i32.add (local.get $offset) (i32.const 1)))
							(local.set $length (i32.sub (local.get $length) (i32.const 1)))

							(br $length--)
						)
					)
				)

				(local.set $arguments
					(call $self.Array.of<ext>ext
						(local.get $arrayBufferView)
					)
				)

				(table.set $wat4wasm (i32.const 2)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; memory
				))
			)

			(block $decodeText/29:11

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 29))
				(local.set $length (i32.const 11))

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(call $self.Array.of<i32>ext (local.get $length))
					)
				)

				(loop $length--
					(if (local.get $length)
						(then
							(memory.init $wat4wasm
								(i32.const 0)

								(local.get $offset)
								(i32.const 1)
							)

							(call $self.Reflect.set<ext.i32.i32>
								(local.get $arrayBufferView)
								(local.get $viewAt)
								(i32.load8_u (i32.const 0))
							)

							(local.set $viewAt (i32.add (local.get $viewAt) (i32.const 1)))
							(local.set $offset (i32.add (local.get $offset) (i32.const 1)))
							(local.set $length (i32.sub (local.get $length) (i32.const 1)))

							(br $length--)
						)
					)
				)

				(local.set $arguments
					(call $self.Array.of<ext>ext
						(local.get $arrayBufferView)
					)
				)

				(table.set $wat4wasm (i32.const 3)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; performance
				))
			)

			(block $decodeText/40:6

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 40))
				(local.set $length (i32.const 6))

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(call $self.Array.of<i32>ext (local.get $length))
					)
				)

				(loop $length--
					(if (local.get $length)
						(then
							(memory.init $wat4wasm
								(i32.const 0)

								(local.get $offset)
								(i32.const 1)
							)

							(call $self.Reflect.set<ext.i32.i32>
								(local.get $arrayBufferView)
								(local.get $viewAt)
								(i32.load8_u (i32.const 0))
							)

							(local.set $viewAt (i32.add (local.get $viewAt) (i32.const 1)))
							(local.set $offset (i32.add (local.get $offset) (i32.const 1)))
							(local.set $length (i32.sub (local.get $length) (i32.const 1)))

							(br $length--)
						)
					)
				)

				(local.set $arguments
					(call $self.Array.of<ext>ext
						(local.get $arrayBufferView)
					)
				)

				(table.set $wat4wasm (i32.const 4)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; length
				))
			)

			(block $decodeText/46:10

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 46))
				(local.set $length (i32.const 10))

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(call $self.Array.of<i32>ext (local.get $length))
					)
				)

				(loop $length--
					(if (local.get $length)
						(then
							(memory.init $wat4wasm
								(i32.const 0)

								(local.get $offset)
								(i32.const 1)
							)

							(call $self.Reflect.set<ext.i32.i32>
								(local.get $arrayBufferView)
								(local.get $viewAt)
								(i32.load8_u (i32.const 0))
							)

							(local.set $viewAt (i32.add (local.get $viewAt) (i32.const 1)))
							(local.set $offset (i32.add (local.get $offset) (i32.const 1)))
							(local.set $length (i32.sub (local.get $length) (i32.const 1)))

							(br $length--)
						)
					)
				)

				(local.set $arguments
					(call $self.Array.of<ext>ext
						(local.get $arrayBufferView)
					)
				)

				(table.set $wat4wasm (i32.const 5)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; clearWatch
				))
			)

			(block $decodeText/56:11

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 56))
				(local.set $length (i32.const 11))

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(call $self.Array.of<i32>ext (local.get $length))
					)
				)

				(loop $length--
					(if (local.get $length)
						(then
							(memory.init $wat4wasm
								(i32.const 0)

								(local.get $offset)
								(i32.const 1)
							)

							(call $self.Reflect.set<ext.i32.i32>
								(local.get $arrayBufferView)
								(local.get $viewAt)
								(i32.load8_u (i32.const 0))
							)

							(local.set $viewAt (i32.add (local.get $viewAt) (i32.const 1)))
							(local.set $offset (i32.add (local.get $offset) (i32.const 1)))
							(local.set $length (i32.sub (local.get $length) (i32.const 1)))

							(br $length--)
						)
					)
				)

				(local.set $arguments
					(call $self.Array.of<ext>ext
						(local.get $arrayBufferView)
					)
				)

				(table.set $wat4wasm (i32.const 6)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; geolocation
				))
			)

			(block $decodeText/67:9

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 67))
				(local.set $length (i32.const 9))

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(call $self.Array.of<i32>ext (local.get $length))
					)
				)

				(loop $length--
					(if (local.get $length)
						(then
							(memory.init $wat4wasm
								(i32.const 0)

								(local.get $offset)
								(i32.const 1)
							)

							(call $self.Reflect.set<ext.i32.i32>
								(local.get $arrayBufferView)
								(local.get $viewAt)
								(i32.load8_u (i32.const 0))
							)

							(local.set $viewAt (i32.add (local.get $viewAt) (i32.const 1)))
							(local.set $offset (i32.add (local.get $offset) (i32.const 1)))
							(local.set $length (i32.sub (local.get $length) (i32.const 1)))

							(br $length--)
						)
					)
				)

				(local.set $arguments
					(call $self.Array.of<ext>ext
						(local.get $arrayBufferView)
					)
				)

				(table.set $wat4wasm (i32.const 7)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; navigator
				))
			)

			(block $decodeText/76:7

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 76))
				(local.set $length (i32.const 7))

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(call $self.Array.of<i32>ext (local.get $length))
					)
				)

				(loop $length--
					(if (local.get $length)
						(then
							(memory.init $wat4wasm
								(i32.const 0)

								(local.get $offset)
								(i32.const 1)
							)

							(call $self.Reflect.set<ext.i32.i32>
								(local.get $arrayBufferView)
								(local.get $viewAt)
								(i32.load8_u (i32.const 0))
							)

							(local.set $viewAt (i32.add (local.get $viewAt) (i32.const 1)))
							(local.set $offset (i32.add (local.get $offset) (i32.const 1)))
							(local.set $length (i32.sub (local.get $length) (i32.const 1)))

							(br $length--)
						)
					)
				)

				(local.set $arguments
					(call $self.Array.of<ext>ext
						(local.get $arrayBufferView)
					)
				)

				(table.set $wat4wasm (i32.const 8)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; özgür
				))
			)
		)

		(block $ontextready
			(block $global/self.navigator.geolocation.clearWatch.length<f64>
				(global.set $self.navigator.geolocation.clearWatch.length<f64>
					(call $self.Reflect.get<ext.ext>f64
						(call $self.Reflect.get<ext.ext>ext
							(call $self.Reflect.get<ext.ext>ext
								(call $self.Reflect.get<ext.ext>ext
									(global.get $self)
									(table.get $wat4wasm (i32.const 7)) ;; navigator
								)
								(table.get $wat4wasm (i32.const 6)) ;; geolocation
							)
							(table.get $wat4wasm (i32.const 5)) ;; clearWatch
						)
						(table.get $wat4wasm (i32.const 4)) ;; length
					)
				)
			)

			(block $global/self.performance.memory.totalJSHeapSize<i32>
				(global.set $self.performance.memory.totalJSHeapSize<i32>
					(call $self.Reflect.get<ext.ext>i32
						(call $self.Reflect.get<ext.ext>ext
							(call $self.Reflect.get<ext.ext>ext
								(global.get $self)
								(table.get $wat4wasm (i32.const 3)) ;; performance
							)
							(table.get $wat4wasm (i32.const 2)) ;; memory
						)
						(table.get $wat4wasm (i32.const 1)) ;; totalJSHeapSize
					)
				)
			)
		)

		;; restore zero heap value
		(i32.store (; stack stack ;))
		(nop)

		(call $main)
	)
	(data $wat4wasm "\30\30\30\30\30\30\30\30\74\6f\74\61\6c\4a\53\48\65\61\70\53\69\7a\65\6d\65\6d\6f\72\79\70\65\72\66\6f\72\6d\61\6e\63\65\6c\65\6e\67\74\68\63\6c\65\61\72\57\61\74\63\68\67\65\6f\6c\6f\63\61\74\69\6f\6e\6e\61\76\69\67\61\74\6f\72\c3\b6\7a\67\c3\bc\72")
	(memory $wat4wasm 1)
	(global $self.navigator.geolocation.clearWatch.length<f64> (mut f64) (f64.const 0))
	(global $self.performance.memory.totalJSHeapSize<i32>      (mut i32) (i32.const 0))
	(start $wat4wasm)
)