(module
	(import "console" "log"         (func $self.console.log<ext>              (param externref)))
	(import "console" "warn"        (func $self.console.warn<f32>             (param f32)))
	(import "console" "warn"        (func $self.console.warn<fun>             (param funcref)))
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
	(data $filetest "\23\06\00\00\00\61\73\6d\01\00\00\00\01\35\0b\60\01\6f\00\60\01\7d\00\60\01\70\00\60\01\7f\00\60\02\6f\6f\01\6f\60\03\6f\7f\7f\00\60\03\6f\6f\6f\01\6f\60\01\6f\01\6f\60\01\7f\01\6f\60\00\01\6f\60\00\00\02\c3\01\0d\07\63\6f\6e\73\6f\6c\65\03\6c\6f\67\00\00\07\63\6f\6e\73\6f\6c\65\04\77\61\72\6e\00\01\07\63\6f\6e\73\6f\6c\65\04\77\61\72\6e\00\02\07\63\6f\6e\73\6f\6c\65\04\77\61\72\6e\00\03\07\52\65\66\6c\65\63\74\03\67\65\74\00\04\07\52\65\66\6c\65\63\74\03\73\65\74\00\05\07\52\65\66\6c\65\63\74\05\61\70\70\6c\79\00\06\07\52\65\66\6c\65\63\74\09\63\6f\6e\73\74\72\75\63\74\00\04\05\41\72\72\61\79\02\6f\66\00\07\05\41\72\72\61\79\02\6f\66\00\08\04\73\65\6c\66\05\41\72\72\61\79\00\09\04\73\65\6c\66\04\73\65\6c\66\03\6f\00\06\53\74\72\69\6e\67\0c\66\72\6f\6d\43\68\61\72\43\6f\64\65\03\6f\00\03\04\03\0a\0a\0a\04\04\01\6f\00\01\05\03\01\00\01\06\06\01\6f\01\d0\6f\0b\07\08\01\04\63\61\6c\63\00\0c\08\01\0d\09\05\01\03\00\01\0d\0a\c7\05\03\f1\02\00\02\6f\10\0a\24\02\23\02\41\00\41\e8\00\10\05\23\02\41\01\41\e5\00\10\05\23\02\41\02\41\ec\00\10\05\23\02\41\03\41\ec\00\10\05\23\02\41\04\41\ef\00\10\05\23\02\41\05\41\0a\10\05\23\02\41\06\41\20\10\05\23\02\41\07\41\20\10\05\23\02\41\08\41\20\10\05\23\02\41\09\41\20\10\05\23\02\41\0a\41\20\10\05\23\02\41\0b\41\20\10\05\23\02\41\0c\41\20\10\05\23\02\41\0d\41\20\10\05\23\02\41\0e\41\20\10\05\23\02\41\0f\41\20\10\05\23\02\41\10\41\20\10\05\23\02\41\11\41\20\10\05\23\02\41\12\41\e1\00\10\05\23\02\41\13\41\f3\00\10\05\23\02\41\14\41\e4\00\10\05\23\02\41\15\41\dc\00\10\05\23\02\41\16\41\22\10\05\23\02\41\17\41\e1\00\10\05\23\02\41\18\41\f3\00\10\05\23\02\41\19\41\e4\00\10\05\23\02\41\1a\41\dc\00\10\05\23\02\41\1b\41\22\10\05\23\02\41\1c\41\20\10\05\23\02\41\1d\41\31\10\05\23\02\41\1e\41\31\10\05\23\02\41\1f\41\0a\10\05\23\02\41\20\41\20\10\05\23\02\41\21\41\20\10\05\23\02\41\22\41\20\10\05\23\02\41\23\41\20\10\05\23\02\41\24\41\20\10\05\23\02\41\25\41\20\10\05\23\02\41\26\41\20\10\05\23\02\41\27\41\20\10\05\23\02\41\28\41\e6\00\10\05\23\02\41\29\41\31\10\05\23\01\d0\6f\23\02\10\06\0b\10\00\0b\02\00\0b\ce\02\02\05\6f\03\7f\02\40\23\00\02\6f\10\0a\24\02\23\02\41\00\41\d4\00\10\05\23\02\41\01\41\e5\00\10\05\23\02\41\02\41\f8\00\10\05\23\02\41\03\41\f4\00\10\05\23\02\41\04\41\c4\00\10\05\23\02\41\05\41\e5\00\10\05\23\02\41\06\41\e3\00\10\05\23\02\41\07\41\ef\00\10\05\23\02\41\08\41\e4\00\10\05\23\02\41\09\41\e5\00\10\05\23\02\41\0a\41\f2\00\10\05\23\01\d0\6f\23\02\10\06\0b\10\04\23\00\10\07\21\00\20\00\02\6f\10\0a\24\02\23\02\41\00\41\e4\00\10\05\23\02\41\01\41\e5\00\10\05\23\02\41\02\41\e3\00\10\05\23\02\41\03\41\ef\00\10\05\23\02\41\04\41\e4\00\10\05\23\02\41\05\41\e5\00\10\05\23\01\d0\6f\23\02\10\06\0b\10\04\21\01\23\00\02\6f\10\0a\24\02\23\02\41\00\41\d5\00\10\05\23\02\41\01\41\e9\00\10\05\23\02\41\02\41\ee\00\10\05\23\02\41\03\41\f4\00\10\05\23\02\41\04\41\38\10\05\23\02\41\05\41\c1\00\10\05\23\02\41\06\41\f2\00\10\05\23\02\41\07\41\f2\00\10\05\23\02\41\08\41\e1\00\10\05\23\02\41\09\41\f9\00\10\05\23\01\d0\6f\23\02\10\06\0b\10\04\21\02\0b\41\00\41\00\28\02\00\02\40\0b\36\02\00\01\10\0b\0b\0b\0b\01\01\08\30\30\30\30\30\30\30\30\00\97\04\04\6e\61\6d\65\01\bb\02\0e\00\15\73\65\6c\66\2e\63\6f\6e\73\6f\6c\65\2e\6c\6f\67\3c\65\78\74\3e\01\16\73\65\6c\66\2e\63\6f\6e\73\6f\6c\65\2e\77\61\72\6e\3c\66\33\32\3e\02\16\73\65\6c\66\2e\63\6f\6e\73\6f\6c\65\2e\77\61\72\6e\3c\66\75\6e\3e\03\16\73\65\6c\66\2e\63\6f\6e\73\6f\6c\65\2e\77\61\72\6e\3c\69\33\32\3e\04\1c\73\65\6c\66\2e\52\65\66\6c\65\63\74\2e\67\65\74\3c\65\78\74\2e\65\78\74\3e\65\78\74\05\1d\73\65\6c\66\2e\52\65\66\6c\65\63\74\2e\73\65\74\3c\65\78\74\2e\69\33\32\2e\69\33\32\3e\06\22\73\65\6c\66\2e\52\65\66\6c\65\63\74\2e\61\70\70\6c\79\3c\65\78\74\2e\65\78\74\2e\65\78\74\3e\65\78\74\07\22\73\65\6c\66\2e\52\65\66\6c\65\63\74\2e\63\6f\6e\73\74\72\75\63\74\3c\65\78\74\2e\65\78\74\3e\65\78\74\08\15\73\65\6c\66\2e\41\72\72\61\79\2e\6f\66\3c\65\78\74\3e\65\78\74\09\15\73\65\6c\66\2e\41\72\72\61\79\2e\6f\66\3c\69\33\32\3e\65\78\74\0a\0f\73\65\6c\66\2e\41\72\72\61\79\3c\3e\65\78\74\0b\05\41\72\72\61\79\0c\04\63\61\6c\63\0d\08\77\61\74\34\77\61\73\6d\02\7e\0e\00\00\01\00\02\00\03\00\04\00\05\00\06\00\07\00\08\00\09\00\0a\00\0b\00\0c\00\0d\08\00\0b\74\65\78\74\44\65\63\6f\64\65\72\01\12\74\65\78\74\44\65\63\6f\64\65\72\2e\64\65\63\6f\64\65\02\0a\55\69\6e\74\38\41\72\72\61\79\03\09\61\72\67\75\6d\65\6e\74\73\04\0f\61\72\72\61\79\42\75\66\66\65\72\56\69\65\77\05\06\76\69\65\77\41\74\06\06\6f\66\66\73\65\74\07\06\6c\65\6e\67\74\68\05\0b\01\00\08\77\61\74\34\77\61\73\6d\07\2b\03\00\04\73\65\6c\66\01\18\73\65\6c\66\2e\53\74\72\69\6e\67\2e\66\72\6f\6d\43\68\61\72\43\6f\64\65\02\08\77\61\74\34\77\61\73\6d\08\0b\01\00\08\77\61\74\34\77\61\73\6d\09\0b\01\00\08\77\61\74\34\77\61\73\6d")

	(func $Array
		(table.get $wat4wasm (i32.const 4))
		(call $self.console.log<ext>)
		(ref.func $wat4wasm)

		(call $self.console.warn<fun>)
		(table.get $wat4wasm (i32.const 4))
		(call $self.console.log<ext>)
		(table.get $wat4wasm (i32.const 4))
		(call $self.console.log<ext>)
		(table.get $wat4wasm (i32.const 4))
		(call $self.console.log<ext>)
		(table.get $wat4wasm (i32.const 4))
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

			(block $decodeText/25+=7

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 25))
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

				(table.set $wat4wasm (i32.const 4)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments)
				))
			)

			(block $decodeText/32+=5

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 32))
				(local.set $length (i32.const 5))

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

			(block $decodeText/37+=46

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 37))
				(local.set $length (i32.const 46))

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

			(block $decodeText/83+=42

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 83))
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
	(data $wat4wasm "\30\30\30\30\30\30\30\30\67\65\74\67\65\74\50\72\6f\74\6f\74\79\70\65\4f\66\c3\b6\7a\67\c3\bc\72\68\65\6c\6c\6f\68\65\6c\c3\b6\7a\67\c3\bc\72\0a\20\20\20\20\20\20\20\20\20\20\20\20\61\73\64\28\61\29\73\64\0a\20\20\20\20\20\20\20\20\20\20\20\20\66\32\68\65\6c\6c\6f\0a\20\20\20\20\20\20\20\20\20\20\20\20\61\73\64\5c\22\61\73\64\5c\22\20\31\31\0a\20\20\20\20\20\20\20\20\66\31")
	(start $wat4wasm)
)