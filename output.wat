(module
	(import "self" "name" (global $myname externref))
	(func $starter

		(pathwalk $self
			(local.set $level/0 (global.get $self))
		)

		(pathwalk $self.performance
			(local.set $level/1
				(call $self.Reflect.get<ext.ext>ext
					(local.get $level/0)
					(texxt "performance")
				)
			)
		)

		(pathwalk $self.performance.timeOrigin
			(local.set $prototype
				(call $self.Reflect.getPrototypeOf<ext>ext
					(local.get $level/1)
				)
			)

			(local.set $descriptor
				(call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
					(local.get $prototype)
					(texxt "timeOrigin")
				)
			)

			(if (call $self.Reflect.has<ext.ext>i32
					(local.get $descriptor)
					(texxt "value")
				)
				(then
					(local.set $value
						(call $self.Reflect.get<ext.ext>f32
							(local.get $descriptor)
							(texxt "value")
						)
					)
				)
				(else
					(local.set $value
						(call $self.Reflect.get<ext.ext>f32
							(local.get $level/1)
							(texxt "self.performance.timeOrigin")
						)
					)
				)
			)

			(global.set $performance.timeOrigin (local.get $value))
		)

		(global.get $performance.timeOrigin)
		(drop)

		(pathwalk $self
			(local.set $level/0 (global.get $self))
		)

		(pathwalk $self.location
			(local.set $level/1
				(call $self.Reflect.get<ext.ext>ext
					(local.get $level/0)
					(texxt "location")
				)
			)
		)

		(pathwalk $self.location.href
			(local.set $prototype
				(call $self.Reflect.getPrototypeOf<ext>ext
					(local.get $level/1)
				)
			)

			(local.set $descriptor
				(call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
					(local.get $prototype)
					(texxt "href")
				)
			)

			(if (call $self.Reflect.has<ext.ext>i32
					(local.get $descriptor)
					(texxt "value")
				)
				(then
					(local.set $value
						(call $self.Reflect.get<ext.ext>ext
							(local.get $descriptor)
							(texxt "value")
						)
					)
				)
				(else
					(local.set $value
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/1)
							(texxt "self.location.href")
						)
					)
				)
			)

			(global.set $location.href (local.get $value))
		)

		(global.get $location.href)
		(drop)

		(pathwalk $self
			(local.set $level/0 (global.get $self))
		)

		(pathwalk $self.navigator
			(local.set $level/1
				(call $self.Reflect.get<ext.ext>ext
					(local.get $level/0)
					(texxt "navigator")
				)
			)
		)

		(pathwalk $self.navigator.gpu
			(local.set $prototype
				(call $self.Reflect.getPrototypeOf<ext>ext
					(local.get $level/1)
				)
			)

			(local.set $descriptor
				(call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
					(local.get $prototype)
					(texxt "gpu")
				)
			)

			(if (call $self.Reflect.has<ext.ext>i32
					(local.get $descriptor)
					(texxt "get")
				)
				(then
					(local.set $value
						(call $self.Reflect.get<ext.ext>ext
							(local.get $descriptor)
							(texxt "get")
						)
					)
				)
				(else
					(local.set $value
						(call $self.Reflect.get<ext.ext>ext
							(local.get $level/1)
							(texxt "self.navigator.gpu")
						)
					)
				)
			)

			(global.set $navigator.gpu/get (local.get $value))
		)

		(global.get $navigator.gpu/get)
		(drop)
	)

	(memory 10)

	(global $performance.timeOrigin (mut f32) (f32.const 0))
	(global $location.href          (mut externref) (ref.null extern))
	(global $navigator.gpu/get      (mut externref) (ref.null extern))
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

		(block $init
			(local.set $byteLength (i32.const 0))
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

		)

		(block $self

		)

		(nop)
		(call $starter)
	)
	(data  $wat4wasm "\")
	(table $wat4wasm 1 externref)
	(start $wat4wasm)
)