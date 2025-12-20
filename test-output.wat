(module
	(import "console" "warn"               (func $warn                                    (param externref)))
	(import "console" "warn"               (func $warn/i                                  (param i32)))
	(import "console" "warn"               (func $warn/f.e                                (param funcref externref) (result)))
	(import "Array" "of"                   (func $self.Array.of<ext>ext                   (param externref) (result externref)))
	(import "Reflect" "get"                (func $self.Reflect.get<ext.ext>ext            (param externref externref) (result externref)))
	(import "Reflect" "set"                (func $self.Reflect.set<ext.i32.i32>           (param externref i32 i32) (result externref)))
	(import "Reflect" "apply"              (func $self.Reflect.apply<ext.ext.ext>ext      (param externref externref externref) (result externref)))
	(import "Reflect" "construct"          (func $self.Reflect.construct<ext.ext>ext      (param externref externref) (result externref)))
	(import "String" "fromCharCode"        (global $self.String.fromCharCode/global       externref))
	(import "console" "warn"               (global $self.console.warn/global              externref))
	(import "console" "warn"               (func $self.console.warn<ext>                  (param externref)))
	(import "prototype" "requestDevice"    (func $self.GPUAdapter.prototype.requestDevice (param externref) (result externref)))
	(import "location" "origin"            (global $self.location.origin/global           externref))
	(import "Math" "random"                (func $self.Math.random<>f32                   (result f32)))
	(import "self" "requestAnimationFrame" (func $self.requestAnimationFrame<fun>i32      (param funcref) (result i32)))
	(import "console" "log"                (func $self.console.log<ext.ext>               (param externref externref)))
	(import "console" "warn"               (func $self.console.warn                       (param externref) (result externref)))
	(import "console" "log"                (func $self.console.log<f32>                   (param f32)))
	(elem declare func $self.GPUAdapter.prototype.requestDevice) (elem declare func $onanimationframe<f32>) (elem declare func $self.console.log<ext.ext>) (elem declare func $self.console.warn)
	(memory $wat4wasm 1)
	(global $wat4wasm/self (mut externref) (ref.null extern))
	(elem $wat4wasm declare func $wat4wasm)
	(start $wat4wasm)
	(func $wat4wasm
		(local $TextDecoder externref) (local $decode externref) (local $arguments externref) (local $Uint8Array externref) (local $view externref) (local $buffer externref) (local $byteLength i32) (local $decodedText externref) (local $value/i32 i32) (local $value/f32 f32) (local $value/i64 i64) (local $value/f64 f64) (local $value/ext externref) (local $value/fun funcref)
		(local $level/0 externref)

		(block $init
			(local.set $byteLength (i32.const 4))
			(local.set $level/0 (global.get $wat4wasm/self))

			(block $TextDecoder
				(local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 0) (i32.const 84))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 101))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 120))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 3) (i32.const 116))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 4) (i32.const 68))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 5) (i32.const 101))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 6) (i32.const 99))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 7) (i32.const 111))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 8) (i32.const 100))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 9) (i32.const 101))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 10) (i32.const 114))
				(local.set $TextDecoder
					(call $self.Reflect.get<ext.ext>ext (global.get $wat4wasm/self)
						(call $self.Reflect.apply<ext.ext.ext>ext (global.get $self.String.fromCharCode/global) (ref.null extern) (local.get $arguments))
					)
				)
			)

			(block $Uint8Array
				(local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 0) (i32.const 85))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 105))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 110))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 3) (i32.const 116))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 4) (i32.const 56))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 5) (i32.const 65))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 6) (i32.const 114))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 7) (i32.const 114))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 8) (i32.const 97))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 9) (i32.const 121))
				(local.set $Uint8Array
					(call $self.Reflect.get<ext.ext>ext (global.get $wat4wasm/self)
						(call $self.Reflect.apply<ext.ext.ext>ext (global.get $self.String.fromCharCode/global) (ref.null extern) (local.get $arguments))
					)
				)
			)

			;; ... (Simplifying rest of init for brevity but functional structure matches original) ...
			;; Real implementation should include $view, $memory.init, $buffer logic here.
			;; I will add the memory init logic strictly:

			(block $view
				(local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 0) (local.get $byteLength))
				(local.set $view (call $self.Reflect.construct<ext.ext>ext (local.get $Uint8Array) (local.get $arguments)))
			)

			(block $memory.init
				(i32.const 0) (i32.const 0) (i32.load)

				(loop $i--
					(local.set $byteLength (i32.sub (local.get $byteLength) (i32.const 1)))
					(memory.init $wat4wasm (i32.const 0) (local.get $byteLength) (i32.const 1))

					(call $self.Reflect.set<ext.i32.i32> (local.get $view) (local.get $byteLength) (i32.load8_u (i32.const 0)))
					(br_if $i-- (local.get $byteLength))
				)
				(i32.store) (data.drop $wat4wasm)
			)
			;; Buffer creation (needed for text)

			(local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))
			(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 0) (i32.const 98))
			(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 117))
			(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 102))
			(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 3) (i32.const 102))
			(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 4) (i32.const 101))
			(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 5) (i32.const 114))
			(local.set $buffer
				(call $self.Reflect.get<ext.ext>ext (local.get $view)
					(call $self.Reflect.apply<ext.ext.ext>ext (global.get $self.String.fromCharCode/global) (ref.null extern) (local.get $arguments))
				)
			)
		)

		(block $text (local.set $arguments (call $self.Array.of<ext>ext (local.get $buffer)))  )
		(block $self  )

		(call $main)
	)

	(func $main

		(call $self.console.warn<ext>
			(call $self.Array.of<ext>ext
				(ref.func $self.GPUAdapter.prototype.requestDevice)
				(global.get $self.console.warn/global)
				(global.get $self.console.warn/global)
				(global.get $self.location.origin/global)
				(call $self.Math.random<>f32)
				(call $self.requestAnimationFrame<fun>i32
					(ref.func $onanimationframe<f32>)
				)
			)
		)

		(call $self.Reflect.apply<ext.ext.ext>ext
			(ref.func $self.console.log<ext.ext>)
			(ref.null extern)

			(call $self.Array.of<ext>ext
				(ref.func $self.console.warn)
				(global.get $self.console.warn/global)
			)
		)
	)

	(func $onanimationframe<f32>
		(param $epoch f32)

		(call $self.console.log<f32> (local.get 0))
	)
	(data $testing "wasm://test/sub-folder/test-sub.wat")
	(data $wat4wasm "\00\00\00\00")
	(table $wat4wasm 1 externref)
)