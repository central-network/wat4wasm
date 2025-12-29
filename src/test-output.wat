(module
	(import "self" "self"                        (global $self                                            externref))
	(import "self" "Array"                       (func $self.Array<>ext                                   (param) (result externref)))
	(import "location" "origin"                  (global $self.location.origin<ext>                       externref))
	(import "String" "fromCharCode"              (global $self.String.fromCharCode                        externref))
	(import "Reflect" "set"                      (func $self.Reflect.set<ext.i32.i32>                     (param externref i32 i32) (result)))
	(import "performance" "interactionCount"     (global $self.performance.interactionCount<i32>          i32))
	(import "Reflect" "set"                      (func $self.Reflect.set<ext.i32.ext>                     (param externref i32 externref) (result)))
	(import "Reflect" "get"                      (func $self.Reflect.get<ext.ext>ext                      (param externref externref) (result externref)))
	(import "Reflect" "construct"                (func $self.Reflect.construct<ext.ext>ext                (param externref externref) (result externref)))
	(import "Reflect" "apply"                    (func $self.Reflect.apply<ext.ext.ext>ext                (param externref externref externref) (result externref)))
	(import "Reflect" "getOwnPropertyDescriptor" (func $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext (param externref externref) (result externref)))

	(func $01-basic
		(global.get $self.location.origin<ext>)
		(drop)

	)

	(func $03-extern-of-number
		(global.get $self.performance.eventCounts.size<ext>)
		(drop)

	)

	(func $04-number-of-number
		(global.get $self.performance.interactionCount<i32>)
		(drop)

	)

	(func $05-accessor-of-object
		(global.get $self.Performance.prototype.interactionCount/get)
		(drop)

	)

	(func $06-prototype-keyword-from-<:>-symbol
		(global.get $self.Performance.prototype.timeOrigin/get)
		(drop)

	)
	(global $wat4wasm                                        (mut externref) (ref.null extern))
	(table $wat4wasm 12 externref)
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
							(global.set $wat4wasm (ref.null extern))
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
						(global.set $wat4wasm (ref.null extern))
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
						(global.set $wat4wasm (ref.null extern))
					)
				)
			)
		)

		;;secure zero heap for memory.init
		(i32.const 0)
		(i32.load (i32.const 0))
		;; offset and value stacked now

		(block $oninit
			(block $decodeText/4:4

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 4))
				(local.set $length (i32.const 4))

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.i32>
					(local.get $arguments) (i32.const 0) (local.get $length)
				)

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(local.get $arguments)
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

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.ext>
					(local.get $arguments)
					(i32.const 0)

					(local.get $arrayBufferView)
				)

				(table.set $wat4wasm (i32.const 1)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; size
				))
			)

			(block $decodeText/8:11

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 8))
				(local.set $length (i32.const 11))

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.i32>
					(local.get $arguments) (i32.const 0) (local.get $length)
				)

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(local.get $arguments)
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

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.ext>
					(local.get $arguments)
					(i32.const 0)

					(local.get $arrayBufferView)
				)

				(table.set $wat4wasm (i32.const 2)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; eventCounts
				))
			)

			(block $decodeText/19:11

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 19))
				(local.set $length (i32.const 11))

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.i32>
					(local.get $arguments) (i32.const 0) (local.get $length)
				)

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(local.get $arguments)
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

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.ext>
					(local.get $arguments)
					(i32.const 0)

					(local.get $arrayBufferView)
				)

				(table.set $wat4wasm (i32.const 3)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; performance
				))
			)

			(block $decodeText/30:3

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 30))
				(local.set $length (i32.const 3))

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.i32>
					(local.get $arguments) (i32.const 0) (local.get $length)
				)

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(local.get $arguments)
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

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.ext>
					(local.get $arguments)
					(i32.const 0)

					(local.get $arrayBufferView)
				)

				(table.set $wat4wasm (i32.const 4)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; get
				))
			)

			(block $decodeText/33:20

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 33))
				(local.set $length (i32.const 20))

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.i32>
					(local.get $arguments) (i32.const 0) (local.get $length)
				)

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(local.get $arguments)
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

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.ext>
					(local.get $arguments)
					(i32.const 0)

					(local.get $arrayBufferView)
				)

				(table.set $wat4wasm (i32.const 5)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; inter ... t/get
				))
			)

			(block $decodeText/53:9

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 53))
				(local.set $length (i32.const 9))

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.i32>
					(local.get $arguments) (i32.const 0) (local.get $length)
				)

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(local.get $arguments)
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

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.ext>
					(local.get $arguments)
					(i32.const 0)

					(local.get $arrayBufferView)
				)

				(table.set $wat4wasm (i32.const 6)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; prototype
				))
			)

			(block $decodeText/62:11

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 62))
				(local.set $length (i32.const 11))

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.i32>
					(local.get $arguments) (i32.const 0) (local.get $length)
				)

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(local.get $arguments)
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

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.ext>
					(local.get $arguments)
					(i32.const 0)

					(local.get $arrayBufferView)
				)

				(table.set $wat4wasm (i32.const 7)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; Performance
				))
			)

			(block $decodeText/30:3

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 30))
				(local.set $length (i32.const 3))

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.i32>
					(local.get $arguments) (i32.const 0) (local.get $length)
				)

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(local.get $arguments)
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

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.ext>
					(local.get $arguments)
					(i32.const 0)

					(local.get $arrayBufferView)
				)

				(table.set $wat4wasm (i32.const 8)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; get
				))
			)

			(block $decodeText/73:14

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 73))
				(local.set $length (i32.const 14))

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.i32>
					(local.get $arguments) (i32.const 0) (local.get $length)
				)

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(local.get $arguments)
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

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.ext>
					(local.get $arguments)
					(i32.const 0)

					(local.get $arrayBufferView)
				)

				(table.set $wat4wasm (i32.const 9)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; timeOrigin/get
				))
			)

			(block $decodeText/53:9

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 53))
				(local.set $length (i32.const 9))

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.i32>
					(local.get $arguments) (i32.const 0) (local.get $length)
				)

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(local.get $arguments)
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

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.ext>
					(local.get $arguments)
					(i32.const 0)

					(local.get $arrayBufferView)
				)

				(table.set $wat4wasm (i32.const 10)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; prototype
				))
			)

			(block $decodeText/62:11

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 62))
				(local.set $length (i32.const 11))

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.i32>
					(local.get $arguments) (i32.const 0) (local.get $length)
				)

				(local.set $arrayBufferView
					(call $self.Reflect.construct<ext.ext>ext
						(local.get $Uint8Array)
						(local.get $arguments)
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

				(local.set $arguments (call $self.Array<>ext))

				(call $self.Reflect.set<ext.i32.ext>
					(local.get $arguments)
					(i32.const 0)

					(local.get $arrayBufferView)
				)

				(table.set $wat4wasm (i32.const 11)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; Performance
				))
			)
		)

		(block $ontextready
			(block $global/self.Performance.prototype.timeOrigin/get
				(global.set $self.Performance.prototype.timeOrigin/get
					(call $self.Reflect.get<ext.ext>ext
						(call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
							(call $self.Reflect.get<ext.ext>ext
								(call $self.Reflect.get<ext.ext>ext
									(global.get $self)
									(table.get $wat4wasm (i32.const 7));; Performance
									;; Performance
								)
								(table.get $wat4wasm (i32.const 6));; prototype

								;; prototype
							)
							(table.get $wat4wasm (i32.const 9));; timeOrigin/get

							;; timeOrigin/get
						)
						(table.get $wat4wasm (i32.const 4));; get

						;; get
					)
				)
			)

			(block $global/self.Performance.prototype.interactionCount/get
				(global.set $self.Performance.prototype.interactionCount/get
					(call $self.Reflect.get<ext.ext>ext
						(call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
							(call $self.Reflect.get<ext.ext>ext
								(call $self.Reflect.get<ext.ext>ext
									(global.get $self)
									(table.get $wat4wasm (i32.const 7));; Performance
									;; Performance
								)
								(table.get $wat4wasm (i32.const 6));; prototype

								;; prototype
							)
							(table.get $wat4wasm (i32.const 5));; inter ... t/get

							;; interactionCount/get
						)
						(table.get $wat4wasm (i32.const 4));; get

						;; get
					)
				)
			)

			(block $global/self.performance.eventCounts.size<ext>
				(global.set $self.performance.eventCounts.size<ext>
					(call $self.Reflect.get<ext.ext>ext
						(call $self.Reflect.get<ext.ext>ext
							(call $self.Reflect.get<ext.ext>ext
								(global.get $self)
								(table.get $wat4wasm (i32.const 3));; performance
								;; performance
							)
							(table.get $wat4wasm (i32.const 2));; eventCounts

							;; eventCounts
						)
						(table.get $wat4wasm (i32.const 1));; size

						;; size
					)
				)
			)
		)
		;; restore zero heap value
		(i32.store (; stack stack ;))
		(nop)
	)
	(data $wat4wasm "\57\00\00\00\73\69\7a\65\65\76\65\6e\74\43\6f\75\6e\74\73\70\65\72\66\6f\72\6d\61\6e\63\65\67\65\74\69\6e\74\65\72\61\63\74\69\6f\6e\43\6f\75\6e\74\2f\67\65\74\70\72\6f\74\6f\74\79\70\65\50\65\72\66\6f\72\6d\61\6e\63\65\74\69\6d\65\4f\72\69\67\69\6e\2f\67\65\74")
	(start $wat4wasm)
	(memory $wat4wasm 1)
	(global $self.Performance.prototype.timeOrigin/get       (mut externref) (ref.null extern))
	(global $self.Performance.prototype.interactionCount/get (mut externref) (ref.null extern))
	(global $self.performance.eventCounts.size<ext>          (mut externref) (ref.null extern))
)