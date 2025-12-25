(module
	(import "console" "log"         (func $self.console.log<ext>              (param externref)))
	(import "console" "warn"        (func $self.console.warn<f32>             (param f32)))
	(import "console" "warn"        (func $self.console.warn<i32>             (param i32)))
	(import "Reflect" "get"         (func $self.Reflect.get<ext.ext>ext       (param externref externref) (result externref) ))
	(import "Reflect" "set"         (func $self.Reflect.set<ext.i32.i32>      (param externref i32 i32)))
	(import "Reflect" "apply"       (func $self.Reflect.apply<ext.ext.ext>ext (param externref externref externref) (result externref)))
	(import "Reflect" "construct"   (func $self.Reflect.construct<ext.ext>ext (param externref externref) (result externref)))
	(import "Array" "of"            (func $self.Array.of<ext>ext              (param externref) (result externref)))
	(import "Array" "of"            (func $self.Array.of<i32>ext              (param i32) (result externref)))
	(import "self" "Array"          (func $self.Array<>ext                    (param) (result externref)))
	(import "self" "self"           (global $self                             externref))
	(import "String" "fromCharCode" (global $self.String.fromCharCode         externref))

	(func $Array
		(table.get $wat4wasm (i32.const 4))
		(call $self.console.log<ext>)

		(block ;; "helöz ... sd f2"
			(result   externref)
			(global.set $wat4wasm (call $self.Array<>ext))

			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 0) (i32.const 104))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 1) (i32.const 101))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 2) (i32.const 108))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 3) (i32.const 246))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 4) (i32.const 122))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 5) (i32.const 103))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 6) (i32.const 252))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 7) (i32.const 114))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 8) (i32.const 10))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 9) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 10) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 11) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 12) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 13) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 14) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 15) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 16) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 17) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 18) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 19) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 20) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 21) (i32.const 97))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 22) (i32.const 115))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 23) (i32.const 100))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 24) (i32.const 40))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 25) (i32.const 97))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 26) (i32.const 41))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 27) (i32.const 115))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 28) (i32.const 100))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 29) (i32.const 10))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 30) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 31) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 32) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 33) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 34) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 35) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 36) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 37) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 38) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 39) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 40) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 41) (i32.const 32))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 42) (i32.const 102))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 43) (i32.const 50))

			(call $self.Reflect.apply<ext.ext.ext>ext
				(global.get $self.String.fromCharCode)
				(ref.null extern)
				(global.get $wat4wasm)
			)
		)

		(call $self.console.log<ext>)

		(block ;; "hello"
			(result   externref)
			(global.set $wat4wasm (call $self.Array<>ext))

			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 0) (i32.const 104))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 1) (i32.const 101))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 2) (i32.const 108))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 3) (i32.const 108))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 4) (i32.const 111))

			(call $self.Reflect.apply<ext.ext.ext>ext
				(global.get $self.String.fromCharCode)
				(ref.null extern)
				(global.get $wat4wasm)
			)
		)

		(call $self.console.log<ext>)
		(table.get $wat4wasm (i32.const 4))
		(call $self.console.log<ext>)

		(block ;; "özgür"
			(result   externref)
			(global.set $wat4wasm (call $self.Array<>ext))

			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 0) (i32.const 246))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 1) (i32.const 122))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 2) (i32.const 103))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 3) (i32.const 252))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 4) (i32.const 114))

			(call $self.Reflect.apply<ext.ext.ext>ext
				(global.get $self.String.fromCharCode)
				(ref.null extern)
				(global.get $wat4wasm)
			)
		)

		(call $self.console.log<ext>)

		(block ;; "get"
			(result   externref)
			(global.set $wat4wasm (call $self.Array<>ext))

			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 0) (i32.const 103))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 1) (i32.const 101))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 2) (i32.const 116))

			(call $self.Reflect.apply<ext.ext.ext>ext
				(global.get $self.String.fromCharCode)
				(ref.null extern)
				(global.get $wat4wasm)
			)
		)

		(call $self.console.log<ext>)
		(table.get $wat4wasm (i32.const 4))
		(call $self.console.log<ext>)
		(table.get $wat4wasm (i32.const 4))
		(call $self.console.log<ext>)
		(table.get $wat4wasm (i32.const 4))
		(call $self.console.log<ext>)
	)
	(data $filread "file://test-out.txt")
	;;(nop)

	(func $calc)
	(export "calc" (func $calc))
	(memory 1)
	(global $wat4wasm (mut externref) (ref.null extern))
	(table $wat4wasm 5 externref)
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
					(global.get $self) (block ;; "Uint8Array"
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
			(block $decodeText/8+=3

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

				(table.set $wat4wasm (i32.const 4)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments)
				))
			)

			(block $decodeText/11+=14

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 11))
				(local.set $length (i32.const 14))

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
						(local.get $arguments)
				))
			)

			(block $decodeText/25+=42

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 25))
				(local.set $length (i32.const 42))

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
						(local.get $arguments)
				))
			)
		)
		;; restore zero heap value
		(i32.store (; stack stack ;))
		(nop)

		(call $Array)
	)
	(data $wat4wasm "\30\30\30\30\30\30\30\30\67\65\74\67\65\74\50\72\6f\74\6f\74\79\70\65\4f\66\68\65\6c\6c\6f\0a\20\20\20\20\20\20\20\20\20\20\20\20\61\73\64\5c\22\61\73\64\5c\22\20\31\31\0a\20\20\20\20\20\20\20\20\66\31")
	(start $wat4wasm)
)