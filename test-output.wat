(module
	(import "self" "Array"                       (func $self.Array<>ext                                   (param) (result externref)))
	(import "Array" "of"                         (func $self.Array.of<i32>ext                             (param i32) (result externref)))
	(import "Reflect" "set"                      (func $self.Reflect.set<ext.i32.i32>                     (param externref i32 i32) (result)))
	(import "Array" "of"                         (func $self.Array.of<ext>ext                             (param externref) (result externref)))
	(import "Reflect" "apply"                    (func $self.Reflect.apply<ext.ext.ext>ext                (param externref externref externref) (result externref)))
	(import "Reflect" "get"                      (func $self.Reflect.get<ext.ext>f64                      (param externref externref) (result f64)))
	(import "Reflect" "getOwnPropertyDescriptor" (func $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext (param externref externref) (result externref)))
	(import "String" "fromCharCode"              (global $self.String.fromCharCode                        externref))
	(import "self" "self"                        (global $self                                            externref))
	(import "console" "log"                      (func $self.console.log<f64>                             (param f64) (result)))
	(import "console" "log"                      (func $self.console.log<ext>                             (param externref) (result)))
	(import "Reflect" "construct"                (func $self.Reflect.construct<ext.ext>ext                (param externref externref) (result externref)))
	(import "Reflect" "get"                      (func $self.Reflect.get<ext.ext>ext                      (param externref externref) (result externref)))
	(memory 1)
	(data $boot.wasm "\22\02\00\00\00\61\73\6d\01\00\00\00\01\1b\05\60\00\01\6f\60\03\6f\7f\7f\00\60\03\6f\6f\6f\01\6f\60\02\6f\6f\01\6f\60\00\00\02\72\07\04\73\65\6c\66\05\41\72\72\61\79\00\00\07\52\65\66\6c\65\63\74\03\73\65\74\00\01\07\52\65\66\6c\65\63\74\05\61\70\70\6c\79\00\02\04\73\65\6c\66\04\73\65\6c\66\03\6f\00\06\53\74\72\69\6e\67\0c\66\72\6f\6d\43\68\61\72\43\6f\64\65\03\6f\00\07\52\65\66\6c\65\63\74\09\63\6f\6e\73\74\72\75\63\74\00\03\07\52\65\66\6c\65\63\74\03\67\65\74\00\03\03\03\02\04\04\04\04\01\6f\00\01\05\03\01\00\01\06\06\01\6f\01\d0\6f\0b\08\01\06\09\05\01\03\00\01\06\0a\d7\02\02\02\00\0b\d1\02\02\05\6f\03\7f\02\40\23\00\02\6f\10\00\24\02\23\02\41\00\41\d4\00\10\01\23\02\41\01\41\e5\00\10\01\23\02\41\02\41\f8\00\10\01\23\02\41\03\41\f4\00\10\01\23\02\41\04\41\c4\00\10\01\23\02\41\05\41\e5\00\10\01\23\02\41\06\41\e3\00\10\01\23\02\41\07\41\ef\00\10\01\23\02\41\08\41\e4\00\10\01\23\02\41\09\41\e5\00\10\01\23\02\41\0a\41\f2\00\10\01\23\01\d0\6f\23\02\10\02\0b\10\04\23\00\10\03\21\00\20\00\02\6f\10\00\24\02\23\02\41\00\41\e4\00\10\01\23\02\41\01\41\e5\00\10\01\23\02\41\02\41\e3\00\10\01\23\02\41\03\41\ef\00\10\01\23\02\41\04\41\e4\00\10\01\23\02\41\05\41\e5\00\10\01\23\01\d0\6f\23\02\10\02\0b\10\04\21\01\23\00\02\6f\10\00\24\02\23\02\41\00\41\d5\00\10\01\23\02\41\01\41\e9\00\10\01\23\02\41\02\41\ee\00\10\01\23\02\41\03\41\f4\00\10\01\23\02\41\04\41\38\10\01\23\02\41\05\41\c1\00\10\01\23\02\41\06\41\f2\00\10\01\23\02\41\07\41\f2\00\10\01\23\02\41\08\41\e1\00\10\01\23\02\41\09\41\f9\00\10\01\23\01\d0\6f\23\02\10\02\0b\10\04\21\02\0b\41\00\41\00\28\02\00\02\40\0b\02\40\0b\36\02\00\01\10\05\0b\0b\0b\01\01\08\30\30\30\30\30\30\30\30")
	(data $worker.js "\11\00\00\00\63\6f\6e\73\6f\6c\65\2e\6c\6f\67\28\73\65\6c\66\29")

	(func $main
		(table.get $wat4wasm (i32.const 14))
		(call $self.console.log<ext>)
		(global.get $self.GPUAdapter.prototype.limits)
		(call $self.console.log<ext>)
		(global.get $self.navigator.geolocation.clearWatch.length<f64>)
		(call $self.console.log<f64>)
		(table.get $wat4wasm (i32.const 1))
		(call $self.console.log<ext>)
	)
	(global $wat4wasm                                          (mut externref) (ref.null extern))
	(table $wat4wasm 15 externref)
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
			(block $decodeText/8:3

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 8))
				(local.set $length (i32.const 3))

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
						(local.get $arguments) ;; get
				))
			)

			(block $decodeText/11:8

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 11))
				(local.set $length (i32.const 8))

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
						(local.get $arguments) ;; features
				))
			)

			(block $decodeText/19:9

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 19))
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

				(table.set $wat4wasm (i32.const 4)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; prototype
				))
			)

			(block $decodeText/28:10

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 28))
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
						(local.get $arguments) ;; GPUAdapter
				))
			)

			(block $decodeText/8:3

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 8))
				(local.set $length (i32.const 3))

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
						(local.get $arguments) ;; get
				))
			)

			(block $decodeText/38:6

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 38))
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

				(table.set $wat4wasm (i32.const 7)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; limits
				))
			)

			(block $decodeText/19:9

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 19))
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

				(table.set $wat4wasm (i32.const 8)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; prototype
				))
			)

			(block $decodeText/28:10

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 28))
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

				(table.set $wat4wasm (i32.const 9)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; GPUAdapter
				))
			)

			(block $decodeText/44:6

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 44))
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

				(table.set $wat4wasm (i32.const 10)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; length
				))
			)

			(block $decodeText/50:10

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 50))
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

				(table.set $wat4wasm (i32.const 11)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; clearWatch
				))
			)

			(block $decodeText/60:11

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 60))
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

				(table.set $wat4wasm (i32.const 12)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; geolocation
				))
			)

			(block $decodeText/71:9

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 71))
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

				(table.set $wat4wasm (i32.const 13)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; navigator
				))
			)

			(block $decodeText/80:7

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 80))
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

				(table.set $wat4wasm (i32.const 14)
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
									(table.get $wat4wasm (i32.const 13)) ;; navigator
								)
								(table.get $wat4wasm (i32.const 12)) ;; geolocation
							)
							(table.get $wat4wasm (i32.const 11)) ;; clearWatch
						)
						(table.get $wat4wasm (i32.const 10)) ;; length
					)
				)
			)

			(block $global/self.GPUAdapter.prototype.limits
				(global.set $self.GPUAdapter.prototype.limits
					(call $self.Reflect.get<ext.ext>ext
						(call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
							(call $self.Reflect.get<ext.ext>ext
								(call $self.Reflect.get<ext.ext>ext
									(global.get $self)
									(table.get $wat4wasm (i32.const 5)) ;; GPUAdapter
								)
								(table.get $wat4wasm (i32.const 4)) ;; prototype
							)
							(table.get $wat4wasm (i32.const 7)) ;; limits
						)
						(table.get $wat4wasm (i32.const 2)) ;; get
					)
				)
			)

			(block $ref.extern/self.GPUAdapter.prototype.features

				(table.set $wat4wasm (i32.const 1)
					(call $self.Reflect.get<ext.ext>ext
						(call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
							(call $self.Reflect.get<ext.ext>ext
								(call $self.Reflect.get<ext.ext>ext
									(global.get $self)
									(table.get $wat4wasm (i32.const 5)) ;; GPUAdapter
								)
								(table.get $wat4wasm (i32.const 4)) ;; prototype
							)
							(table.get $wat4wasm (i32.const 3)) ;; features
						)
						(table.get $wat4wasm (i32.const 2)) ;; get
					)
				)
			)
		)

		;; restore zero heap value
		(i32.store (; stack stack ;))
		(nop)

		(call $main)
	)
	(data $wat4wasm "\30\30\30\30\30\30\30\30\67\65\74\66\65\61\74\75\72\65\73\70\72\6f\74\6f\74\79\70\65\47\50\55\41\64\61\70\74\65\72\6c\69\6d\69\74\73\6c\65\6e\67\74\68\63\6c\65\61\72\57\61\74\63\68\67\65\6f\6c\6f\63\61\74\69\6f\6e\6e\61\76\69\67\61\74\6f\72\c3\b6\7a\67\c3\bc\72")
	(global $self.navigator.geolocation.clearWatch.length<f64> (mut f64) (f64.const 0))
	(global $self.GPUAdapter.prototype.limits                  (mut externref) (ref.null extern))
	(start $wat4wasm)
)