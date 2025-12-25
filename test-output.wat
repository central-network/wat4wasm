(module
	(import "console" "log"         (func $self.console.log<ext>              (param externref)))
	(import "console" "warn"        (func $self.console.warn<f32>             (param f32)))
	(import "console" "warn"        (func $self.console.warn<i32>             (param i32)))
	(import "Reflect" "get"         (func $self.Reflect.get<ext.ext>ext       (param externref externref) (result externref) ))
	(import "Reflect" "set"         (func $self.Reflect.set<ext.i32.i32>      (param externref i32 i32)))
	(import "Reflect" "apply"       (func $self.Reflect.apply<ext.ext.ext>ext (param externref externref externref) (result externref)))
	(import "Reflect" "construct"   (func $self.Reflect.construct<ext.ext>ext (param externref externref) (result externref)))
	(import "Array" "of"            (func $self.Array.of<ext>ext              (param externref) (result externref)))
	(import "self" "Array"          (func $self.Array<>ext                    (param) (result externref)))
	(import "self" "self"           (global $self                             externref))
	(import "String" "fromCharCode" (global $self.String.fromCharCode         externref))

	(func $Array
		(ref.null (;0x22ea83fe9afc4a3ea4a365680fc700ac;) extern)

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

		(block ;; "getPrototypeOf"
			(result   externref)
			(global.set $wat4wasm (call $self.Array<>ext))

			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 0) (i32.const 103))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 1) (i32.const 101))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 2) (i32.const 116))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 3) (i32.const 80))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 4) (i32.const 114))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 5) (i32.const 111))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 6) (i32.const 116))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 7) (i32.const 111))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 8) (i32.const 116))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 9) (i32.const 121))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 10) (i32.const 112))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 11) (i32.const 101))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 12) (i32.const 79))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 13) (i32.const 102))

			(call $self.Reflect.apply<ext.ext.ext>ext
				(global.get $self.String.fromCharCode)
				(ref.null extern)
				(global.get $wat4wasm)
			)
		)

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

		(block ;; "şık"
			(result   externref)
			(global.set $wat4wasm (call $self.Array<>ext))

			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 0) (i32.const 351))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 1) (i32.const 305))
			(call $self.Reflect.set<ext.i32.i32> (global.get $wat4wasm) (i32.const 2) (i32.const 107))

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
	)
	(data $filread "file://test-out.txt")
	;;(nop)

	(func $calc)
	(export "calc" (func $calc))
	(global $wat4wasm (mut externref) (ref.null extern))
	(table $wat4wasm 1 externref)
	(elem $wat4wasm declare func $wat4wasm)
	(func $wat4wasm
		(local $TextDecoder externref)
		(local $decode externref)
		(local $Uint8Array externref)

		(block $prepare
			(local.set $TextDecoder
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

			(local.set $decode
				(call $self.Reflect.get<ext.ext>ext
					(local.get $TextDecoder)

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

		(local.get $TextDecoder)
		(call $self.console.log<ext>)

		(local.get $decode)
		(call $self.console.log<ext>)

		(local.get $Uint8Array)
		(call $self.console.log<ext>)
		(call $Array)
	)
	(data $wat4wasm "\00\00\00\00")
	(start $wat4wasm)
)