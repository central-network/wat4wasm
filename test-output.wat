(module
	(import "Reflect" "getOwnPropertyDescriptor" (func $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext (param externref externref) (result externref)))
	(import "Array" "of"                         (func $self.Array.of<ext.ext>ext                         (param externref externref) (result externref)))
	(import "console" "warn"                     (func $self.console.warn<ext>                            (param externref) (result)))
	(import "Reflect" "apply"                    (func $self.Reflect.apply<ext.ext.ext>i32                (param externref externref externref) (result i32)))
	(import "self" "Object"                      (func $self.Object<>ext                                  (param) (result externref)))
	(import "Reflect" "set"                      (func $self.Reflect.set<ext.i32.ext>                     (param externref i32 externref) (result)))
	(import "Reflect" "apply"                    (func $self.Reflect.apply<ext.ext.ext>ext                (param externref externref externref) (result externref)))
	(import "String" "fromCharCode"              (global $self.String.fromCharCode                        externref))
	(import "self" "self"                        (global $self                                            externref))
	(import "console" "warn"                     (func $self.console.warn<i32>                            (param i32) (result)))
	(import "console" "log"                      (func $self.console.log<ext>                             (param externref) (result)))
	(import "Reflect" "get"                      (func $self.Reflect.get<ext.ext>ext                      (param externref externref) (result externref)))
	(import "self" "Array"                       (func $self.Array<>ext                                   (param) (result externref)))
	(import "Reflect" "construct"                (func $self.Reflect.construct<ext.ext>ext                (param externref externref) (result externref)))
	(import "Reflect" "set"                      (func $self.Reflect.set<ext.i32.i32>                     (param externref i32 i32) (result)))
	(data $boot.wasm "\00\61\73\6d\01\00\00\00\01\1b\05\60\00\01\6f\60\03\6f\7f\7f\00\60\03\6f\6f\6f\01\6f\60\02\6f\6f\01\6f\60\00\00\02\72\07\04\73\65\6c\66\05\41\72\72\61\79\00\00\07\52\65\66\6c\65\63\74\03\73\65\74\00\01\07\52\65\66\6c\65\63\74\05\61\70\70\6c\79\00\02\04\73\65\6c\66\04\73\65\6c\66\03\6f\00\06\53\74\72\69\6e\67\0c\66\72\6f\6d\43\68\61\72\43\6f\64\65\03\6f\00\07\52\65\66\6c\65\63\74\09\63\6f\6e\73\74\72\75\63\74\00\03\07\52\65\66\6c\65\63\74\03\67\65\74\00\03\03\03\02\04\04\04\04\01\6f\00\01\05\03\01\00\01\06\06\01\6f\01\d0\6f\0b\08\01\06\09\05\01\03\00\01\06\0a\e6\02\02\02\00\0b\e0\02\02\05\6f\03\7f\02\40\23\00\02\6f\10\00\24\02\23\02\41\00\41\d4\00\10\01\23\02\41\01\41\e5\00\10\01\23\02\41\02\41\f8\00\10\01\23\02\41\03\41\f4\00\10\01\23\02\41\04\41\c4\00\10\01\23\02\41\05\41\e5\00\10\01\23\02\41\06\41\e3\00\10\01\23\02\41\07\41\ef\00\10\01\23\02\41\08\41\e4\00\10\01\23\02\41\09\41\e5\00\10\01\23\02\41\0a\41\f2\00\10\01\23\01\d0\6f\23\02\10\02\d0\6f\24\02\0b\10\04\23\00\10\03\21\00\20\00\02\6f\10\00\24\02\23\02\41\00\41\e4\00\10\01\23\02\41\01\41\e5\00\10\01\23\02\41\02\41\e3\00\10\01\23\02\41\03\41\ef\00\10\01\23\02\41\04\41\e4\00\10\01\23\02\41\05\41\e5\00\10\01\23\01\d0\6f\23\02\10\02\d0\6f\24\02\0b\10\04\21\01\23\00\02\6f\10\00\24\02\23\02\41\00\41\d5\00\10\01\23\02\41\01\41\e9\00\10\01\23\02\41\02\41\ee\00\10\01\23\02\41\03\41\f4\00\10\01\23\02\41\04\41\38\10\01\23\02\41\05\41\c1\00\10\01\23\02\41\06\41\f2\00\10\01\23\02\41\07\41\f2\00\10\01\23\02\41\08\41\e1\00\10\01\23\02\41\09\41\f9\00\10\01\23\01\d0\6f\23\02\10\02\d0\6f\24\02\0b\10\04\21\02\0b\41\00\41\00\28\02\00\02\40\0b\02\40\0b\02\40\0b\36\02\00\01\10\05\0b\0b\0b\01\01\08\30\30\30\30\30\30\30\30\00\f2\02\04\6e\61\6d\65\01\a4\01\07\00\0f\73\65\6c\66\2e\41\72\72\61\79\3c\3e\65\78\74\01\1d\73\65\6c\66\2e\52\65\66\6c\65\63\74\2e\73\65\74\3c\65\78\74\2e\69\33\32\2e\69\33\32\3e\02\22\73\65\6c\66\2e\52\65\66\6c\65\63\74\2e\61\70\70\6c\79\3c\65\78\74\2e\65\78\74\2e\65\78\74\3e\65\78\74\03\22\73\65\6c\66\2e\52\65\66\6c\65\63\74\2e\63\6f\6e\73\74\72\75\63\74\3c\65\78\74\2e\65\78\74\3e\65\78\74\04\1c\73\65\6c\66\2e\52\65\66\6c\65\63\74\2e\67\65\74\3c\65\78\74\2e\65\78\74\3e\65\78\74\05\01\61\06\08\77\61\74\34\77\61\73\6d\02\70\07\00\00\01\00\02\00\03\00\04\00\05\00\06\08\00\0b\74\65\78\74\44\65\63\6f\64\65\72\01\12\74\65\78\74\44\65\63\6f\64\65\72\2e\64\65\63\6f\64\65\02\0a\55\69\6e\74\38\41\72\72\61\79\03\09\61\72\67\75\6d\65\6e\74\73\04\0f\61\72\72\61\79\42\75\66\66\65\72\56\69\65\77\05\06\76\69\65\77\41\74\06\06\6f\66\66\73\65\74\07\06\6c\65\6e\67\74\68\05\0b\01\00\08\77\61\74\34\77\61\73\6d\07\2b\03\00\04\73\65\6c\66\01\18\73\65\6c\66\2e\53\74\72\69\6e\67\2e\66\72\6f\6d\43\68\61\72\43\6f\64\65\02\08\77\61\74\34\77\61\73\6d\08\0b\01\00\08\77\61\74\34\77\61\73\6d\09\0b\01\00\08\77\61\74\34\77\61\73\6d")
	(data $worker.js "\63\6f\6e\73\6f\6c\65\2e\6c\6f\67\28\73\65\6c\66\29")

	(func $main
		(i32.const 934)
		(call $self.console.warn<i32>)
		(table.get $wat4wasm (i32.const 4))
		(call $self.console.log<ext>)
		(table.get $wat4wasm (i32.const 10))
		(call $self.console.log<ext>)
		(table.get $wat4wasm (i32.const 9))
		(call $self.console.log<ext>)
		(i32.const 934)
		(call $self.console.warn<i32>)
		(table.get $wat4wasm (i32.const 1))
		(call $self.console.warn<ext>)

		(call $self.Reflect.apply<ext.ext.ext>ext
			(table.get $wat4wasm (i32.const 8))
			(table.get $wat4wasm (i32.const 7))
			(call $self.Array.of<ext.ext>ext
				(table.get $wat4wasm (i32.const 1))
				(global.get $self)
			)
		)

		(call $self.console.warn<ext>)

		(call $self.Reflect.apply<ext.ext.ext>i32
			(table.get $wat4wasm (i32.const 6))
			(ref.null extern)

			(call $self.Array<>ext)
		)

		(call $self.console.warn<i32>)

		(call $self.Reflect.construct<ext.ext>ext
			(table.get $wat4wasm (i32.const 5))
			(call $self.Object<>ext)
		)

		(call $self.console.log<ext>)
	)
	(memory 10)
	(global $wat4wasm (mut externref) (ref.null extern))
	(table $wat4wasm 22 externref)
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
			(block $decodeText/8:10

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 8))
				(local.set $length (i32.const 10))

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
						(local.get $arguments) ;; Uint8Array
				))
			)

			(block $decodeText/18:7

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 18))
				(local.set $length (i32.const 7))

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
						(local.get $arguments) ;; özgür
				))
			)

			(block $decodeText/25:11

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 25))
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
						(local.get $arguments) ;; geolocation
				))
			)

			(block $decodeText/36:9

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 36))
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

				(table.set $wat4wasm (i32.const 12)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; navigator
				))
			)

			(block $decodeText/45:3

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 45))
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

				(table.set $wat4wasm (i32.const 13)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; get
				))
			)

			(block $decodeText/48:8

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 48))
				(local.set $length (i32.const 8))

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

				(table.set $wat4wasm (i32.const 14)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; features
				))
			)

			(block $decodeText/56:9

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 56))
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

				(table.set $wat4wasm (i32.const 15)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; prototype
				))
			)

			(block $decodeText/65:10

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 65))
				(local.set $length (i32.const 10))

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

				(table.set $wat4wasm (i32.const 16)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; GPUAdapter
				))
			)

			(block $decodeText/75:11

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 75))
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

				(table.set $wat4wasm (i32.const 17)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; instantiate
				))
			)

			(block $decodeText/86:11

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 86))
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

				(table.set $wat4wasm (i32.const 18)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; WebAssembly
				))
			)

			(block $decodeText/86:11

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 86))
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

				(table.set $wat4wasm (i32.const 19)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; WebAssembly
				))
			)

			(block $decodeText/97:10

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 97))
				(local.set $length (i32.const 10))

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

				(table.set $wat4wasm (i32.const 20)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; setTimeout
				))
			)

			(block $decodeText/107:6

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 107))
				(local.set $length (i32.const 6))

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

				(table.set $wat4wasm (i32.const 21)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; Worker
				))
			)
		)

		(block $ontextready
			(block $ref.extern/self.Uint8Array<ext>

				(table.set $wat4wasm (i32.const 2)
					(call $self.Reflect.get<ext.ext>ext
						(global.get $self)
						(table.get $wat4wasm (i32.const 3)) ;; Uint8Array
					)
				)
			)

			(block $ref.extern/self.Worker<ext>

				(table.set $wat4wasm (i32.const 5)
					(call $self.Reflect.get<ext.ext>ext
						(global.get $self)
						(table.get $wat4wasm (i32.const 21)) ;; Worker
					)
				)
			)

			(block $ref.extern/self.setTimeout<ext>

				(table.set $wat4wasm (i32.const 6)
					(call $self.Reflect.get<ext.ext>ext
						(global.get $self)
						(table.get $wat4wasm (i32.const 20)) ;; setTimeout
					)
				)
			)

			(block $ref.extern/self.WebAssembly<ext>

				(table.set $wat4wasm (i32.const 7)
					(call $self.Reflect.get<ext.ext>ext
						(global.get $self)
						(table.get $wat4wasm (i32.const 18)) ;; WebAssembly
					)
				)
			)

			(block $ref.extern/self.WebAssembly.instantiate<ext>

				(table.set $wat4wasm (i32.const 8)
					(call $self.Reflect.get<ext.ext>ext
						(call $self.Reflect.get<ext.ext>ext
							(global.get $self)
							(table.get $wat4wasm (i32.const 18)) ;; WebAssembly
						)
						(table.get $wat4wasm (i32.const 17)) ;; instantiate
					)
				)
			)

			(block $ref.extern/self.GPUAdapter.prototype.features

				(table.set $wat4wasm (i32.const 9)
					(call $self.Reflect.get<ext.ext>ext
						(call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
							(call $self.Reflect.get<ext.ext>ext
								(call $self.Reflect.get<ext.ext>ext
									(global.get $self)
									(table.get $wat4wasm (i32.const 16)) ;; GPUAdapter
								)
								(table.get $wat4wasm (i32.const 15)) ;; prototype
							)
							(table.get $wat4wasm (i32.const 14)) ;; features
						)
						(table.get $wat4wasm (i32.const 13)) ;; get
					)
				)
			)

			(block $ref.extern/self.navigator.geolocation<ext>

				(table.set $wat4wasm (i32.const 10)
					(call $self.Reflect.get<ext.ext>ext
						(call $self.Reflect.get<ext.ext>ext
							(global.get $self)
							(table.get $wat4wasm (i32.const 12)) ;; navigator
						)
						(table.get $wat4wasm (i32.const 11)) ;; geolocation
					)
				)
			)
		)

		(block $onexternready

			(table.set $wat4wasm (i32.const 1)

				(block $data_view_of<boot.wasm>
					(result externref)
					(global.set $wat4wasm (call $self.Array<>ext))

					(call $self.Reflect.set<ext.i32.i32>
						(global.get $wat4wasm) (i32.const 0) (i32.const 934)
					)
					(global.set $wat4wasm
						(call $self.Reflect.construct<ext.ext>ext
							(table.get $wat4wasm (i32.const 2))
							(global.get $wat4wasm)
						)
					)
					(if (i32.const 934)
						(then
							(i32.const 0)
							(i64.load (i32.const 0))

							(block $copy
								(i32.store (i32.const 0) (i32.const 934))

								(loop $i--
									(if (i32.atomic.rmw.sub (i32.const 0) (i32.const 1))
										(then
											(memory.init $boot.wasm
												(i32.const 4)
												(i32.load (i32.const 0))
												(i32.const 1)
											)

											(call $self.Reflect.set<ext.i32.i32>
												(global.get $wat4wasm)
												(i32.load (i32.const 0))
												(i32.load8_u (i32.const 4))
											)

											(br $i--)
										)
									)
								)
							)
							(i64.store (; stack stack ;))
						)
					)
					(global.get $wat4wasm)
					(global.set $wat4wasm (ref.null extern))
				)
			)
		)

		;; restore zero heap value
		(i32.store (; stack stack ;))
		(nop)

		(call $main)
	)
	(data $wat4wasm "\30\30\30\30\30\30\30\30\55\69\6e\74\38\41\72\72\61\79\c3\b6\7a\67\c3\bc\72\67\65\6f\6c\6f\63\61\74\69\6f\6e\6e\61\76\69\67\61\74\6f\72\67\65\74\66\65\61\74\75\72\65\73\70\72\6f\74\6f\74\79\70\65\47\50\55\41\64\61\70\74\65\72\69\6e\73\74\61\6e\74\69\61\74\65\57\65\62\41\73\73\65\6d\62\6c\79\73\65\74\54\69\6d\65\6f\75\74\57\6f\72\6b\65\72")
	(start $wat4wasm)
)