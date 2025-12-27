(module
	(import "Object" "is"           (func $self.Object.is<ext.ext>i32         (param externref externref) (result i32)))
	(import "self" "String"         (func $self.String<>ext                   (param) (result externref)))
	(import "Array" "of"            (func $self.Array.of<ext>ext              (param externref) (result externref)))
	(import "Reflect" "set"         (func $self.Reflect.set<ext.i32.i32>      (param externref i32 i32) (result)))
	(import "Reflect" "set"         (func $self.Reflect.set<ext.i32.ext>      (param externref i32 externref) (result)))
	(import "self" "Array"          (func $self.Array<>ext                    (param) (result externref)))
	(import "console" "log"         (func $self.console.log<ext.ext>          (param externref externref) (result)))
	(import "String" "fromCharCode" (global $self.String.fromCharCode         externref))
	(import "self" "self"           (global $self                             externref))
	(import "console" "log"         (func $self.console.log<i32>              (param i32) (result)))
	(import "console" "log"         (func $self.console.log<ext>              (param externref) (result)))
	(import "Reflect" "apply"       (func $self.Reflect.apply<ext.ext.ext>    (param externref externref externref) (result)))
	(import "Reflect" "apply"       (func $self.Reflect.apply<ext.ext.ext>ext (param externref externref externref) (result externref)))
	(import "Array" "of"            (func $self.Array.of<fun>ext              (param funcref) (result externref)))
	(import "Reflect" "construct"   (func $self.Reflect.construct<ext.ext>ext (param externref externref) (result externref)))
	(import "Reflect" "get"         (func $self.Reflect.get<ext.ext>ext       (param externref externref) (result externref)))
	(data $boot.wasm "\00\61\73\6d\01\00\00\00\01\1b\05\60\00\01\6f\60\03\6f\7f\7f\00\60\03\6f\6f\6f\01\6f\60\02\6f\6f\01\6f\60\00\00\02\72\07\04\73\65\6c\66\05\41\72\72\61\79\00\00\07\52\65\66\6c\65\63\74\03\73\65\74\00\01\07\52\65\66\6c\65\63\74\05\61\70\70\6c\79\00\02\04\73\65\6c\66\04\73\65\6c\66\03\6f\00\06\53\74\72\69\6e\67\0c\66\72\6f\6d\43\68\61\72\43\6f\64\65\03\6f\00\07\52\65\66\6c\65\63\74\09\63\6f\6e\73\74\72\75\63\74\00\03\07\52\65\66\6c\65\63\74\03\67\65\74\00\03\03\03\02\04\04\04\04\01\6f\00\01\05\03\01\00\01\06\06\01\6f\01\d0\6f\0b\08\01\06\09\05\01\03\00\01\06\0a\e6\02\02\02\00\0b\e0\02\02\05\6f\03\7f\02\40\23\00\02\6f\10\00\24\02\23\02\41\00\41\d4\00\10\01\23\02\41\01\41\e5\00\10\01\23\02\41\02\41\f8\00\10\01\23\02\41\03\41\f4\00\10\01\23\02\41\04\41\c4\00\10\01\23\02\41\05\41\e5\00\10\01\23\02\41\06\41\e3\00\10\01\23\02\41\07\41\ef\00\10\01\23\02\41\08\41\e4\00\10\01\23\02\41\09\41\e5\00\10\01\23\02\41\0a\41\f2\00\10\01\23\01\d0\6f\23\02\10\02\d0\6f\24\02\0b\10\04\23\00\10\03\21\00\20\00\02\6f\10\00\24\02\23\02\41\00\41\e4\00\10\01\23\02\41\01\41\e5\00\10\01\23\02\41\02\41\e3\00\10\01\23\02\41\03\41\ef\00\10\01\23\02\41\04\41\e4\00\10\01\23\02\41\05\41\e5\00\10\01\23\01\d0\6f\23\02\10\02\d0\6f\24\02\0b\10\04\21\01\23\00\02\6f\10\00\24\02\23\02\41\00\41\d5\00\10\01\23\02\41\01\41\e9\00\10\01\23\02\41\02\41\ee\00\10\01\23\02\41\03\41\f4\00\10\01\23\02\41\04\41\38\10\01\23\02\41\05\41\c1\00\10\01\23\02\41\06\41\f2\00\10\01\23\02\41\07\41\f2\00\10\01\23\02\41\08\41\e1\00\10\01\23\02\41\09\41\f9\00\10\01\23\01\d0\6f\23\02\10\02\d0\6f\24\02\0b\10\04\21\02\0b\41\00\41\00\28\02\00\02\40\0b\02\40\0b\02\40\0b\36\02\00\01\10\05\0b\0b\0b\01\01\08\30\30\30\30\30\30\30\30\00\f2\02\04\6e\61\6d\65\01\a4\01\07\00\0f\73\65\6c\66\2e\41\72\72\61\79\3c\3e\65\78\74\01\1d\73\65\6c\66\2e\52\65\66\6c\65\63\74\2e\73\65\74\3c\65\78\74\2e\69\33\32\2e\69\33\32\3e\02\22\73\65\6c\66\2e\52\65\66\6c\65\63\74\2e\61\70\70\6c\79\3c\65\78\74\2e\65\78\74\2e\65\78\74\3e\65\78\74\03\22\73\65\6c\66\2e\52\65\66\6c\65\63\74\2e\63\6f\6e\73\74\72\75\63\74\3c\65\78\74\2e\65\78\74\3e\65\78\74\04\1c\73\65\6c\66\2e\52\65\66\6c\65\63\74\2e\67\65\74\3c\65\78\74\2e\65\78\74\3e\65\78\74\05\01\61\06\08\77\61\74\34\77\61\73\6d\02\70\07\00\00\01\00\02\00\03\00\04\00\05\00\06\08\00\0b\74\65\78\74\44\65\63\6f\64\65\72\01\12\74\65\78\74\44\65\63\6f\64\65\72\2e\64\65\63\6f\64\65\02\0a\55\69\6e\74\38\41\72\72\61\79\03\09\61\72\67\75\6d\65\6e\74\73\04\0f\61\72\72\61\79\42\75\66\66\65\72\56\69\65\77\05\06\76\69\65\77\41\74\06\06\6f\66\66\73\65\74\07\06\6c\65\6e\67\74\68\05\0b\01\00\08\77\61\74\34\77\61\73\6d\07\2b\03\00\04\73\65\6c\66\01\18\73\65\6c\66\2e\53\74\72\69\6e\67\2e\66\72\6f\6d\43\68\61\72\43\6f\64\65\02\08\77\61\74\34\77\61\73\6d\08\0b\01\00\08\77\61\74\34\77\61\73\6d\09\0b\01\00\08\77\61\74\34\77\61\73\6d")
	(data $worker.js "\63\6f\6e\73\6f\6c\65\2e\6c\6f\67\28\73\65\6c\66\29")

	(func $test/test-sub-wat
		(table.get $wat4wasm (i32.const 22));; anoth ... me...

		(call $self.console.log<ext>)
	)
	(global $a        (mut i32) (i32.const 0))
	(global $b        (mut externref) (ref.null extern))
	(global $c        (mut funcref) (ref.null func))
	(global $d        (mut v128) (v128.const i32x4 0 0 0 0))

	(func $main
		(local $i i32)
		(local $d f32)
		(local $c externref)

		(local.tee $i (i32.add (local.get $i) (i32.const -1)))
		(call $self.console.log<i32>)

		(local.tee $i (i32.add (local.get $i) (i32.const +1)))
		(call $self.console.log<i32>)

		(local.set $i (i32.const -4))
		(local.set $d (f32.const -4.3))
		(local.set $d (f32.const +2.1))
		(if (global.get $b) (ref.is_null)
			(then nop)
		)
		(if (global.get $b) (table.get $wat4wasm (i32.const 34)) ;; $self.undefined<ext>

			(call $self.Object.is<ext.ext>i32)
			(then nop)
		)
		(if (global.get $b) (call $self.String<>ext) (call $self.Object.is<ext.ext>i32) (i32.eqz)
			(then nop)
		)
		(if (local.get $i) (i32.eqz)
			(then nop)
		)
		(if (local.get $d) (f32.const nan) (f32.eq)
			(then nop)
		)
		(i32.const 934)
		(call $self.console.log<i32>)
		(table.get $wat4wasm (i32.const 21));; özgür

		(call $self.console.log<ext>)

		(call $self.Reflect.construct<ext.ext>ext
			(table.get $wat4wasm (i32.const 5)) ;; $self.Worker<ext>ext<ext>

			(call $self.Array.of<ext>ext (table.get $wat4wasm (i32.const 20));; worker.js
			)
		)

		(call $self.console.log<ext>)

		(call $self.Reflect.apply<ext.ext.ext>
			(table.get $wat4wasm (i32.const 4)) ;; $self.Promise.prototype.finally<ext>

			(call $self.Reflect.apply<ext.ext.ext>ext
				(table.get $wat4wasm (i32.const 3)) ;; $self.Promise.prototype.catch<ext>

				(call $self.Reflect.apply<ext.ext.ext>ext
					(table.get $wat4wasm (i32.const 2)) ;; $self.Promise.prototype.then<ext>

					(call $self.Reflect.apply<ext.ext.ext>ext
						(table.get $wat4wasm (i32.const 2)) ;; $self.Promise.prototype.then<ext>

						(call $self.Reflect.apply<ext.ext.ext>ext
							(table.get $wat4wasm (i32.const 25)) ;; $self.GPU.prototype.requestAdapter<ext>
							(table.get $wat4wasm (i32.const 24)) ;; $self.navigator.gpu<ext>

							(call $self.Array<>ext)
						)

						(call $self.Array.of<fun>ext (ref.func $then_1057_68))
					)

					(call $self.Array.of<fun>ext (ref.func $then_1057_117))
				)

				(call $self.Array.of<fun>ext (ref.func $onasynccallfail))
			)

			(call $self.Array.of<fun>ext (ref.func $finally_1057_215))
		)
	)

	(func $onasynccallfail
		(param $error externref)

		(call $self.console.log<ext>
			(call $self.Reflect.construct<ext.ext>ext
				(table.get $wat4wasm (i32.const 1)) ;; $self.Error<ext>ext<ext>

				(call $self.Array.of<ext>ext (local.get 0))
			)
		)
	)
	(memory 10)
	(global $wat4wasm (mut externref) (ref.null extern))
	(table $wat4wasm 36 externref)
	(elem $wat4wasm declare func $wat4wasm $finally_1057_215 $onasynccallfail $then_1057_117 $then_1057_68)
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
			(block $decodeText/8:26

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 8))
				(local.set $length (i32.const 26))

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
						(local.get $arguments) ;; async ... ached
				))
			)

			(block $decodeText/34:25

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 34))
				(local.set $length (i32.const 25))

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
						(local.get $arguments) ;; async ... ached
				))
			)

			(block $decodeText/59:26

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 59))
				(local.set $length (i32.const 26))

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
						(local.get $arguments) ;; async ... ached
				))
			)

			(block $decodeText/85:6

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 85))
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

				(table.set $wat4wasm (i32.const 9)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; Worker
				))
			)

			(block $decodeText/19:7

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 19))
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

				(table.set $wat4wasm (i32.const 10)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; finally
				))
			)

			(block $decodeText/91:9

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 91))
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

				(table.set $wat4wasm (i32.const 11)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; prototype
				))
			)

			(block $decodeText/100:7

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 100))
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

				(table.set $wat4wasm (i32.const 12)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; Promise
				))
			)

			(block $decodeText/107:5

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 107))
				(local.set $length (i32.const 5))

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
						(local.get $arguments) ;; catch
				))
			)

			(block $decodeText/91:9

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 91))
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

				(table.set $wat4wasm (i32.const 14)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; prototype
				))
			)

			(block $decodeText/100:7

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 100))
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

				(table.set $wat4wasm (i32.const 15)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; Promise
				))
			)

			(block $decodeText/112:4

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 112))
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

				(table.set $wat4wasm (i32.const 16)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; then
				))
			)

			(block $decodeText/91:9

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 91))
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

				(table.set $wat4wasm (i32.const 17)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; prototype
				))
			)

			(block $decodeText/100:7

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 100))
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

				(table.set $wat4wasm (i32.const 18)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; Promise
				))
			)

			(block $decodeText/116:5

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 116))
				(local.set $length (i32.const 5))

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
						(local.get $arguments) ;; Error
				))
			)

			(block $decodeText/121:9

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 121))
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

				(table.set $wat4wasm (i32.const 20)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; worker.js
				))
			)

			(block $decodeText/130:7

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 130))
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

				(table.set $wat4wasm (i32.const 21)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; özgür
				))
			)

			(block $decodeText/137:15

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 137))
				(local.set $length (i32.const 15))

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

				(table.set $wat4wasm (i32.const 22)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; anoth ... me...
				))
			)

			(block $decodeText/152:14

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 152))
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

				(table.set $wat4wasm (i32.const 26)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; requestAdapter
				))
			)

			(block $decodeText/91:9

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 91))
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

				(table.set $wat4wasm (i32.const 27)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; prototype
				))
			)

			(block $decodeText/166:3

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 166))
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

				(table.set $wat4wasm (i32.const 28)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; GPU
				))
			)

			(block $decodeText/169:3

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 169))
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

				(table.set $wat4wasm (i32.const 29)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; gpu
				))
			)

			(block $decodeText/172:9

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 172))
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

				(table.set $wat4wasm (i32.const 30)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; navigator
				))
			)

			(block $decodeText/181:13

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 181))
				(local.set $length (i32.const 13))

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

				(table.set $wat4wasm (i32.const 31)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; requestDevice
				))
			)

			(block $decodeText/91:9

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 91))
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

				(table.set $wat4wasm (i32.const 32)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; prototype
				))
			)

			(block $decodeText/194:10

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 194))
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

				(table.set $wat4wasm (i32.const 33)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; GPUAdapter
				))
			)

			(block $decodeText/204:9

				(local.set $viewAt (i32.const 0))
				(local.set $offset (i32.const 204))
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

				(table.set $wat4wasm (i32.const 35)
					(call $self.Reflect.apply<ext.ext.ext>ext
						(local.get $textDecoder.decode)
						(local.get $textDecoder)
						(local.get $arguments) ;; undefined
				))
			)
		)

		(block $ontextready

			(block $self.Error<ext>ext<ext>.ref

				(table.set $wat4wasm (i32.const 1)
					(call $self.Reflect.get<ext.ext>ext
						(global.get $self)
						(table.get $wat4wasm (i32.const 19));; Error
						;; Error
					)
			))

			(block $self.Promise.prototype.then<ext>.ref

				(table.set $wat4wasm (i32.const 2)
					(call $self.Reflect.get<ext.ext>ext
						(call $self.Reflect.get<ext.ext>ext
							(call $self.Reflect.get<ext.ext>ext
								(global.get $self)
								(table.get $wat4wasm (i32.const 12));; Promise
								;; Promise
							)
							(table.get $wat4wasm (i32.const 11));; prototype

							;; prototype
						)
						(table.get $wat4wasm (i32.const 16));; then

						;; then
					)
			))

			(block $self.Promise.prototype.catch<ext>.ref

				(table.set $wat4wasm (i32.const 3)
					(call $self.Reflect.get<ext.ext>ext
						(call $self.Reflect.get<ext.ext>ext
							(call $self.Reflect.get<ext.ext>ext
								(global.get $self)
								(table.get $wat4wasm (i32.const 12));; Promise
								;; Promise
							)
							(table.get $wat4wasm (i32.const 11));; prototype

							;; prototype
						)
						(table.get $wat4wasm (i32.const 13));; catch

						;; catch
					)
			))

			(block $self.Promise.prototype.finally<ext>.ref

				(table.set $wat4wasm (i32.const 4)
					(call $self.Reflect.get<ext.ext>ext
						(call $self.Reflect.get<ext.ext>ext
							(call $self.Reflect.get<ext.ext>ext
								(global.get $self)
								(table.get $wat4wasm (i32.const 12));; Promise
								;; Promise
							)
							(table.get $wat4wasm (i32.const 11));; prototype

							;; prototype
						)
						(table.get $wat4wasm (i32.const 10));; finally

						;; finally
					)
			))

			(block $self.Worker<ext>ext<ext>.ref

				(table.set $wat4wasm (i32.const 5)
					(call $self.Reflect.get<ext.ext>ext
						(global.get $self)
						(table.get $wat4wasm (i32.const 9));; Worker
						;; Worker
					)
			))

			(block $self.GPUAdapter.prototype.requestDevice<ext>.ref

				(table.set $wat4wasm (i32.const 23)
					(call $self.Reflect.get<ext.ext>ext
						(call $self.Reflect.get<ext.ext>ext
							(call $self.Reflect.get<ext.ext>ext
								(global.get $self)
								(table.get $wat4wasm (i32.const 33));; GPUAdapter
								;; GPUAdapter
							)
							(table.get $wat4wasm (i32.const 27));; prototype

							;; prototype
						)
						(table.get $wat4wasm (i32.const 31));; requestDevice

						;; requestDevice
					)
			))

			(block $self.navigator.gpu<ext>.ref

				(table.set $wat4wasm (i32.const 24)
					(call $self.Reflect.get<ext.ext>ext
						(call $self.Reflect.get<ext.ext>ext
							(global.get $self)
							(table.get $wat4wasm (i32.const 30));; navigator
							;; navigator
						)
						(table.get $wat4wasm (i32.const 29));; gpu

						;; gpu
					)
			))

			(block $self.GPU.prototype.requestAdapter<ext>.ref

				(table.set $wat4wasm (i32.const 25)
					(call $self.Reflect.get<ext.ext>ext
						(call $self.Reflect.get<ext.ext>ext
							(call $self.Reflect.get<ext.ext>ext
								(global.get $self)
								(table.get $wat4wasm (i32.const 28));; GPU
								;; GPU
							)
							(table.get $wat4wasm (i32.const 27));; prototype

							;; prototype
						)
						(table.get $wat4wasm (i32.const 26));; requestAdapter

						;; requestAdapter
					)
			))

			(block $self.undefined<ext>.ref

				(table.set $wat4wasm (i32.const 34)
					(call $self.Reflect.get<ext.ext>ext
						(global.get $self)
						(table.get $wat4wasm (i32.const 35));; undefined
						;; undefined
					)
			))
		)

		(block $onexternready)
		;; restore zero heap value
		(i32.store (; stack stack ;))
		(nop)

		(call $main)
	)
	(data $wat4wasm "\30\30\30\30\30\30\30\30\61\73\79\6e\63\20\63\61\6c\6c\20\66\69\6e\61\6c\6c\79\20\72\65\61\63\68\65\64\61\73\79\6e\63\20\63\61\6c\6c\20\64\65\76\69\63\65\20\72\65\61\63\68\65\64\61\73\79\6e\63\20\63\61\6c\6c\20\61\64\61\70\74\65\72\20\72\65\61\63\68\65\64\57\6f\72\6b\65\72\70\72\6f\74\6f\74\79\70\65\50\72\6f\6d\69\73\65\63\61\74\63\68\74\68\65\6e\45\72\72\6f\72\77\6f\72\6b\65\72\2e\6a\73\c3\b6\7a\67\c3\bc\72\61\6e\6f\74\68\65\72\20\74\69\6d\65\2e\2e\2e\72\65\71\75\65\73\74\41\64\61\70\74\65\72\47\50\55\67\70\75\6e\61\76\69\67\61\74\6f\72\72\65\71\75\65\73\74\44\65\76\69\63\65\47\50\55\41\64\61\70\74\65\72\75\6e\64\65\66\69\6e\65\64")

	(func $then_1057_68
		(param $adapter externref)
		(result externref)

		(call $self.console.log<ext.ext>
			(local.get $adapter)
			(table.get $wat4wasm (i32.const 8));; async ... ached
		)

		(call $self.Reflect.apply<ext.ext.ext>ext
			(table.get $wat4wasm (i32.const 23)) ;; $self.GPUAdapter.prototype.requestDevice<ext>

			(local.get $adapter)
			(call $self.Array<>ext)
		)
	)

	(func $then_1057_117
		(param $device externref)

		(call $self.console.log<ext.ext>
			(local.get 0)
			(table.get $wat4wasm (i32.const 7));; async ... ached
		)
	)

	(func $finally_1057_215

		(call $self.console.log<ext>
			(table.get $wat4wasm (i32.const 6));; async ... ached
		)
	)
	(start $wat4wasm)
)