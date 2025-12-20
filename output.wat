(module
	(import "console" "warn"               (func $warn                                      (param externref)))
	(import "console" "warn"               (func $warn/i                                    (param i32)))
	(import "console" "warn"               (func $warn/f.e                                  (param funcref externref) (result)))
	(import "Array" "of"                   (func $self.Array.of<ext>ext                     (param externref) (result externref)))
	(import "Array" "of"                   (func $self.Array.of<fun.ext>ext                 (param funcref externref) (result externref)))
	(import "Array" "of"                   (func $self.Array.of<ext.ext.ext.ext.f32.i32>ext (param externref externref externref externref f32 i32) (result externref)))
	(import "self" "self"                  (global $self                                    externref))
	(import "Math" "random"                (func $self.Math.random<>f32                     (param) (result f32)))
	(import "console" "log"                (func $self.console.log<f32>                     (param f32) (result)))
	(import "console" "log"                (func $self.console.log<ext.ext>                 (param externref externref) (result)))
	(import "Reflect" "get"                (func $self.Reflect.get<ext.ext>ext              (param externref externref) (result externref)))
	(import "Reflect" "set"                (func $self.Reflect.set<ext.i32.i32>             (param externref i32 i32) (result)))
	(import "console" "warn"               (func $self.console.warn                         (param) (result)))
	(import "console" "warn"               (func $self.console.warn<ext>                    (param externref) (result)))
	(import "Reflect" "apply"              (func $self.Reflect.apply<fun.ext.ext>           (param funcref externref externref) (result)))
	(import "Reflect" "apply"              (func $self.Reflect.apply<ext.ext.ext>ext        (param externref externref externref) (result externref)))
	(import "Reflect" "construct"          (func $self.Reflect.construct<ext.ext>ext        (param externref externref) (result externref)))
	(import "String" "fromCharCode"        (global $self.String.fromCharCode                externref))
	(import "prototype" "requestDevice"    (func $self.GPUAdapter.prototype.requestDevice   (param) (result)))
	(import "self" "requestAnimationFrame" (func $self.requestAnimationFrame<fun>i32        (param funcref) (result i32)))

	(func $main

		(call $self.console.warn<ext>
			(call $self.Array.of<ext.ext.ext.ext.f32.i32>ext
				(global.get $self.GPUAdapter.prototype.requestDevice)
				(table.get $wat4wasm (i32.const 1)) ;; $self.console.warn
				(global.get $self.console.warn)
				(table.get $wat4wasm (i32.const 2)) ;; $self.location.origin

				(call $self.Math.random<>f32)
				(call $self.requestAnimationFrame<fun>i32
					(ref.func $onanimationframe<f32>)
				)
			)
		)

		(call $self.Reflect.apply<fun.ext.ext>
			(ref.func $self.console.log<ext.ext>)
			(ref.null extern)

			(call $self.Array.of<fun.ext>ext
				(ref.func $self.console.warn)
				(table.get $wat4wasm (i32.const 1)) ;; $self.console.warn
			)
		)
	)

	(func $onanimationframe<f32>
		(param $epoch f32)

		(call $self.console.log<f32> (local.get 0))
	)
	(data $testing "\00\61\73\6d\01\00\00\00\01\1c\05\60\01\6f\01\6f\60\02\6f\6f\01\6f\60\03\6f\7f\7f\00\60\03\6f\6f\6f\01\6f\60\00\00\02\70\07\05\41\72\72\61\79\02\6f\66\00\00\04\73\65\6c\66\04\73\65\6c\66\03\6f\00\07\52\65\66\6c\65\63\74\03\67\65\74\00\01\07\52\65\66\6c\65\63\74\03\73\65\74\00\02\07\52\65\66\6c\65\63\74\05\61\70\70\6c\79\00\03\07\52\65\66\6c\65\63\74\09\63\6f\6e\73\74\72\75\63\74\00\01\06\53\74\72\69\6e\67\0c\66\72\6f\6d\43\68\61\72\43\6f\64\65\03\6f\00\03\03\02\04\04\04\04\01\6f\00\0b\05\03\01\00\01\06\10\03\6f\01\d0\6f\0b\6f\01\d0\6f\0b\6f\01\d0\6f\0b\08\01\06\09\05\01\03\00\01\06\0c\01\01\0a\8f\04\02\07\00\41\0a\25\00\1a\0b\84\04\0a\06\6f\01\7f\01\6f\01\7f\01\7d\01\7e\01\7c\01\6f\01\70\01\6f\02\40\41\c4\00\21\06\23\00\21\0e\02\40\d0\6f\10\00\21\02\20\02\41\00\41\d4\00\10\02\20\02\41\01\41\e5\00\10\02\20\02\41\02\41\f8\00\10\02\20\02\41\03\41\f4\00\10\02\20\02\41\04\41\c4\00\10\02\20\02\41\05\41\e5\00\10\02\20\02\41\06\41\e3\00\10\02\20\02\41\07\41\ef\00\10\02\20\02\41\08\41\e4\00\10\02\20\02\41\09\41\e5\00\10\02\20\02\41\0a\41\f2\00\10\02\23\00\23\01\d0\6f\20\02\10\03\10\01\23\00\10\04\21\00\0b\02\40\d0\6f\10\00\21\02\20\02\41\00\41\e4\00\10\02\20\02\41\01\41\e5\00\10\02\20\02\41\02\41\e3\00\10\02\20\02\41\03\41\ef\00\10\02\20\02\41\04\41\e4\00\10\02\20\02\41\05\41\e5\00\10\02\20\00\23\01\d0\6f\20\02\10\03\10\01\21\01\0b\02\40\d0\6f\10\00\21\02\20\02\41\00\41\d5\00\10\02\20\02\41\01\41\e9\00\10\02\20\02\41\02\41\ee\00\10\02\20\02\41\03\41\f4\00\10\02\20\02\41\04\41\38\10\02\20\02\41\05\41\c1\00\10\02\20\02\41\06\41\f2\00\10\02\20\02\41\07\41\f2\00\10\02\20\02\41\08\41\e1\00\10\02\20\02\41\09\41\f9\00\10\02\23\00\23\01\d0\6f\20\02\10\03\10\01\21\03\0b\02\40\d0\6f\10\00\21\02\20\02\41\00\20\06\10\02\20\03\20\02\10\04\21\04\0b\02\40\41\00\41\00\28\02\00\03\40\20\06\41\01\6b\21\06\41\00\20\06\41\01\fc\08\00\00\20\04\20\06\41\00\2d\00\00\10\02\20\06\0d\00\0b\36\02\00\fc\09\00\0b\02\40\d0\6f\10\00\21\02\20\02\41\00\41\e2\00\10\02\20\02\41\01\41\f5\00\10\02\20\02\41\02\41\e6\00\10\02\20\02\41\03\41\e6\00\10\02\20\02\41\04\41\e5\00\10\02\20\02\41\05\41\f2\00\10\02\20\04\23\01\d0\6f\20\02\10\03\10\01\21\05\0b\0b\02\40\20\05\10\00\21\02\0b\02\40\0b\10\05\0b\0b\47\01\01\44\00\00\00\00\47\50\55\41\64\61\70\74\65\72\70\72\6f\74\6f\74\79\70\65\72\65\71\75\65\73\74\44\65\76\69\63\65\63\6f\6e\73\6f\6c\65\77\61\72\6e\6c\6f\63\61\74\69\6f\6e\6f\72\69\67\69\6e\c3\b6\7a\67\c3\bc\72\00\f5\03\04\6e\61\6d\65\01\ad\01\07\00\15\73\65\6c\66\2e\41\72\72\61\79\2e\6f\66\3c\65\78\74\3e\65\78\74\01\1c\73\65\6c\66\2e\52\65\66\6c\65\63\74\2e\67\65\74\3c\65\78\74\2e\65\78\74\3e\65\78\74\02\1d\73\65\6c\66\2e\52\65\66\6c\65\63\74\2e\73\65\74\3c\65\78\74\2e\69\33\32\2e\69\33\32\3e\03\22\73\65\6c\66\2e\52\65\66\6c\65\63\74\2e\61\70\70\6c\79\3c\65\78\74\2e\65\78\74\2e\65\78\74\3e\65\78\74\04\22\73\65\6c\66\2e\52\65\66\6c\65\63\74\2e\63\6f\6e\73\74\72\75\63\74\3c\65\78\74\2e\65\78\74\3e\65\78\74\05\04\70\61\74\68\06\08\77\61\74\34\77\61\73\6d\02\ad\01\07\00\00\01\00\02\00\03\00\04\00\05\00\06\0f\00\0b\54\65\78\74\44\65\63\6f\64\65\72\01\06\64\65\63\6f\64\65\02\09\61\72\67\75\6d\65\6e\74\73\03\0a\55\69\6e\74\38\41\72\72\61\79\04\04\76\69\65\77\05\06\62\75\66\66\65\72\06\0a\62\79\74\65\4c\65\6e\67\74\68\07\0b\64\65\63\6f\64\65\64\54\65\78\74\08\09\76\61\6c\75\65\2f\69\33\32\09\09\76\61\6c\75\65\2f\66\33\32\0a\09\76\61\6c\75\65\2f\69\36\34\0b\09\76\61\6c\75\65\2f\66\36\34\0c\09\76\61\6c\75\65\2f\65\78\74\0d\09\76\61\6c\75\65\2f\66\75\6e\0e\07\6c\65\76\65\6c\2f\30\05\0b\01\00\08\77\61\74\34\77\61\73\6d\07\67\05\00\04\73\65\6c\66\01\18\73\65\6c\66\2e\53\74\72\69\6e\67\2e\66\72\6f\6d\43\68\61\72\43\6f\64\65\02\27\73\65\6c\66\2e\47\50\55\41\64\61\70\74\65\72\2e\70\72\6f\74\6f\74\79\70\65\2e\72\65\71\75\65\73\74\44\65\76\69\63\65\03\11\73\65\6c\66\2e\63\6f\6e\73\6f\6c\65\2e\77\61\72\6e\04\08\77\61\74\34\77\61\73\6d\08\0b\01\00\08\77\61\74\34\77\61\73\6d\09\0b\01\00\08\77\61\74\34\77\61\73\6d")
	(global $self.GPUAdapter.prototype.requestDevice (mut externref) (ref.null extern))
	(global $self.console.warn                       (mut externref) (ref.null extern))
	(elem   $wat4wasm declare func $wat4wasm $onanimationframe<f32> $self.console.log<ext.ext> $self.console.warn)
	(start  $wat4wasm)
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

		(block $init
			(local.set $byteLength (i32.const 61))
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
				(table.set $wat4wasm (i32.const 3) (local.get $decodedText))
			)

			(block $text<14:9> ;; "prototype"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 14))
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
				(table.set $wat4wasm (i32.const 4) (local.get $decodedText))
			)

			(block $text<23:13> ;; "requestDevice"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 23))
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
				(table.set $wat4wasm (i32.const 5) (local.get $decodedText))
			)

			(block $text<36:7> ;; "console"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 36))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 7))

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
				(table.set $wat4wasm (i32.const 6) (local.get $decodedText))
			)

			(block $text<43:4> ;; "warn"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 43))
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
				(table.set $wat4wasm (i32.const 7) (local.get $decodedText))
			)

			(block $text<47:8> ;; "location"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 47))
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
				(table.set $wat4wasm (i32.const 8) (local.get $decodedText))
			)

			(block $text<55:6> ;; "origin"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 55))
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
		)

		(block $self
			(block $self.GPUAdapter
				(block $self.GPUAdapter
					(local.set $level/1
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/0)
							(table.get $wat4wasm (i32.const 3)) ;; "GPUAdapter"
						)
					)
				)

				(block $self.GPUAdapter.prototype
					(local.set $level/2
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/1)
							(table.get $wat4wasm (i32.const 4)) ;; "prototype"
						)
					)
				)

				(block $self.GPUAdapter.prototype.requestDevice
					(local.set $value/ext
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/2)
							(table.get $wat4wasm (i32.const 5)) ;; "requestDevice"
						)
					)
					(global.set $self.GPUAdapter.prototype.requestDevice (local.get $value/ext))
				)

				(block $self.GPUAdapter.prototype.requestDevice
					(local.set $level/3
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/2)
							(table.get $wat4wasm (i32.const 5)) ;; "requestDevice"
						)
					)
				)
			)

			(block $self.console
				(block $self.console
					(local.set $level/1
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/0)
							(table.get $wat4wasm (i32.const 6)) ;; "console"
						)
					)
				)

				(block $self.console.warn
					(local.set $level/2
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/1)
							(table.get $wat4wasm (i32.const 7)) ;; "warn"
						)
					)
					(table.set $wat4wasm (i32.const 1) (local.get $level/2))
				)

				(block $self.console.warn
					(local.set $value/ext
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/1)
							(table.get $wat4wasm (i32.const 7)) ;; "warn"
						)
					)
					(global.set $self.console.warn (local.get $value/ext))
				)

				(block $self.console.warn
					(local.set $level/2
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/1)
							(table.get $wat4wasm (i32.const 7)) ;; "warn"
						)
					)
				)
			)

			(block $self.location
				(block $self.location
					(local.set $level/1
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/0)
							(table.get $wat4wasm (i32.const 8)) ;; "location"
						)
					)
				)

				(block $self.location.origin
					(local.set $level/2
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/1)
							(table.get $wat4wasm (i32.const 9)) ;; "origin"
						)
					)
					(table.set $wat4wasm (i32.const 2) (local.get $level/2))
				)
			)
		)

		(call $main))
	(data   $wat4wasm "\00\00\00\00\47\50\55\41\64\61\70\74\65\72\70\72\6f\74\6f\74\79\70\65\72\65\71\75\65\73\74\44\65\76\69\63\65\63\6f\6e\73\6f\6c\65\77\61\72\6e\6c\6f\63\61\74\69\6f\6e\6f\72\69\67\69\6e")
	(table  $wat4wasm 10 externref)
	(global $wat4wasm                                (mut externref) (ref.null extern))
	(memory $wat4wasm 1)
)