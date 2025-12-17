(module
	(import "String" "fromCharCode" (global $self.String.fromCharCode         externref))
	(import "Array" "of"            (func $self.Array.of<ext>ext              (param externref) (result externref)))
	(import "Reflect" "apply"       (func $self.Reflect.apply<ext.ext.ext>ext (param externref externref externref) (result externref)))
	(import "Reflect" "set"         (func $self.Reflect.set<ext.i32.ext>      (param externref i32 externref) (result)))
	(import "Reflect" "set"         (func $self.Reflect.set<ext.i32.i32>      (param externref i32 i32) (result)))
	(import "Reflect" "construct"   (func $self.Reflect.construct<ext.ext>ext (param externref externref) (result externref)))
	(import "Reflect" "get"         (func $self.Reflect.get<ext.ext>ext       (param externref externref) (result externref)))
	(import "self" "self"           (global $self                             externref))
	(import "self" "name"           (global $myname                           externref))
	(func $starter

		(global.get $performance.timeOrigin) ;; performance.timeOrigin
		(drop)

		(global.get $navigator.gpu) ;; navigator.gpu
		(drop)

		(table.get $wat4wasm (i32.const 6)) ;; GPUAdapter:requestDevice
		(drop)
	)

	(memory 10)

	(global $performance.timeOrigin (mut f32) (f32.const 0))
	(global $navigator.gpu          (mut externref) (ref.null extern))

	(elem  $wat4wasm declare func $wat4wasm)
	(func  $wat4wasm
		(local $TextDecoder  externref)
		(local $decode       externref)
		(local $arguments    externref)
		(local $Uint8Array   externref)
		(local $view         externref)
		(local $buffer       externref)
		(local $byteLength   i32)
		(local $decodedText  externref)

		(local $level/0      externref)
		(local $level/1      externref)
		(local $level/2      externref)
		(local $level/3      externref)

		(block $init
			(local.set $byteLength (i32.const 69))
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
				(i32.load (i32.const 0))

				(loop $i--
					(local.set $byteLength (i32.sub (local.get $byteLength) (i32.const 1)))
					(memory.init $wat4wasm (i32.const 0) (local.get $byteLength) (i32.const 1))
					(call $self.Reflect.set<ext.i32.i32> (local.get $view) (local.get $byteLength) (i32.load8_u (i32.const 0)))
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
			(block $text<0:4> ;; "self"
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 0))
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
			(block $text<4:11> ;; "performance"
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 4))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 11))
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

				(table.set $wat4wasm (i32.const  2) (local.get $decodedText))
			)
			(block $text<15:10> ;; "timeOrigin"
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 15))
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

				(table.set $wat4wasm (i32.const  3) (local.get $decodedText))
			)
			(block $text<25:9> ;; "navigator"
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 25))
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

				(table.set $wat4wasm (i32.const  4) (local.get $decodedText))
			)
			(block $text<34:3> ;; "gpu"
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 34))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 3))
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

				(table.set $wat4wasm (i32.const  5) (local.get $decodedText))
			)
			(block $text<37:10> ;; "GPUAdapter"
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 37))
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

				(table.set $wat4wasm (i32.const  7) (local.get $decodedText))
			)
			(block $text<47:9> ;; "prototype"
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 47))
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

				(table.set $wat4wasm (i32.const  8) (local.get $decodedText))
			)
			(block $text<56:13> ;; "requestDevice"
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 56))
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

				(table.set $wat4wasm (i32.const  9) (local.get $decodedText))
			)
		)

		(block $self
			(block $self.performance

				(block $self.performance
					(local.set $level/1
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/0)
							(table.get $wat4wasm (i32.const 2)) ;; "performance"
						)
					)
				)

				(block $self.performance.timeOrigin
					(local.set $level/2
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/1)
							(table.get $wat4wasm (i32.const 3)) ;; "timeOrigin"
						)
					)
				)

			)

			(block $self.navigator

				(block $self.navigator
					(local.set $level/1
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/0)
							(table.get $wat4wasm (i32.const 4)) ;; "navigator"
						)
					)
				)

				(block $self.navigator.gpu
					(local.set $level/2
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/1)
							(table.get $wat4wasm (i32.const 5)) ;; "gpu"
						)
					)
				)

			)

			(block $self.GPUAdapter

				(block $self.GPUAdapter
					(local.set $level/1
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/0)
							(table.get $wat4wasm (i32.const 7)) ;; "GPUAdapter"
						)
					)
				)

				(block $self.GPUAdapter.prototype
					(local.set $level/2
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/1)
							(table.get $wat4wasm (i32.const 8)) ;; "prototype"
						)
					)
				)

				(block $self.GPUAdapter.prototype.requestDevice
					(local.set $level/3
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/2)
							(table.get $wat4wasm (i32.const 9)) ;; "requestDevice"
						)
					)

					(table.set $wat4wasm (i32.const 6) (local.get $level/3))
				)

			)
		)

		(nop)
		(call $starter)
	)
	(data  $wat4wasm "\73\65\6c\66\70\65\72\66\6f\72\6d\61\6e\63\65\74\69\6d\65\4f\72\69\67\69\6e\6e\61\76\69\67\61\74\6f\72\67\70\75\47\50\55\41\64\61\70\74\65\72\70\72\6f\74\6f\74\79\70\65\72\65\71\75\65\73\74\44\65\76\69\63\65")
	(table $wat4wasm 10 externref)
	(start $wat4wasm)
)