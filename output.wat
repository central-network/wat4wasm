(module
	(import "Array" "of"          (func $self.Array.of<ext>ext              (param externref) (result externref)))
	(import "Reflect" "get"       (func $self.Reflect.get<ext.ext>ext       (param externref externref) (result externref)))
	(import "Reflect" "set"       (func $self.Reflect.set<ext.i32.i32>      (param externref i32 i32) (result)))
	(import "Reflect" "apply"     (func $self.Reflect.apply<ext.ext.ext>ext (param externref externref externref) (result externref)))
	(import "Reflect" "construct" (func $self.Reflect.construct<ext.ext>ext (param externref externref) (result externref)))

	(func $main
		;; {ref_extern $self.x} :
		(self.extern $location.href)
		(drop)

		(self.i32 $location.href)
		(drop)


		(call $self.Reflect.get<ext.ext>ext
			(table.get $wat4wasm (i32.const 2)) ;; self.location
			(table.get $wat4wasm (i32.const 1)) ;; "href"
		)
		(drop)

	)
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
		(local $level/0      externref)

		(block $init

			(local.set $byteLength (i32.const 8))
			(local.set $level/0 (global.get $self))

			(block $TextDecoder

				(local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 0) (i32.const  84))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 101))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 120))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 3) (i32.const 116))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 4) (i32.const  68))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 5) (i32.const 101))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 6) (i32.const  99))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 7) (i32.const 111))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 8) (i32.const 100))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 9) (i32.const 101))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 10) (i32.const 114))

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

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 0) (i32.const 100))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 101))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const  99))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 3) (i32.const 111))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 4) (i32.const 100))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 5) (i32.const 101))

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

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 0) (i32.const  85))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 105))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 110))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 3) (i32.const 116))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 4) (i32.const  56))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 5) (i32.const  65))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 6) (i32.const 114))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 7) (i32.const 114))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 8) (i32.const  97))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 9) (i32.const 121))

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

			(block $text<4:4> ;; "href"

				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 4))
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
				(table.set $wat4wasm (i32.const  1) (local.get $decodedText))
			)
		)

		(block $self
		)
		(nop))
	(data   $wat4wasm "\00\00\00\00\68\72\65\66")
	(table  $wat4wasm 3 externref)
	(start  $wat4wasm)
	(global $wat4wasm (mut extern) (ref.null externef))
	(memory $wat4wasm 1)
)