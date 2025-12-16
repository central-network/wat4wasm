(module
	(import "Date" "now"                            (func $self.Date.now<i32>i64                             (param i32) (result i64)))
	(import "Math" "random"                         (func $self.Math.random<>f32                             (param) (result f32)))
	(import "WebGL2RenderingContext" "ARRAY_BUFFER" (global $WebGL2RenderingContext.ARRAY_BUFFER             i32))
	(import "self" "length"                         (global $length                                          i32))
	(import "performance" "timeOrigin"              (global $performance.timeOrigin                          f32))
	(import "Reflect" "getOwnPropertyDescriptor"    (func $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext (param externref externref) (result externref)))
	(import "Reflect" "get"                         (func $self.Reflect.get<ext.ext>ext                      (param externref externref) (result externref)))

	(func $path:test/sub-folder/test-sub-wat
		(table.get $wat4wasm (i32.const 1)) ;; "özgür"
		(table.get $wat4wasm (i32.const 3)) ;; Array
		(table.get $wat4wasm (i32.const 4)) ;; ArrayBuffer:byteLength/get
		(table.get $wat4wasm (i32.const 9)) ;; ArrayBuffer:growable/set
		(table.get $wat4wasm (i32.const 12)) ;; ArrayBuffer:growable/get
		(table.get $wat4wasm (i32.const 13)) ;; Array.isArray
		(table.get $wat4wasm (i32.const 15)) ;; Array:push
		(table.get $wat4wasm (i32.const 17)) ;; Array:slice
		(table.get $wat4wasm (i32.const 19)) ;; Array:splice
		(nop)

		(global.get $performance.timeOrigin)
		(global.get $length)
		(global.get $WebGL2RenderingContext.ARRAY_BUFFER)
		(nop)

		(call $self.Math.random<>f32)

		(call $self.Date.now<i32>i64 (i32.const 4))

	)

	(func $path:test/test-sub-wat
		(table.get $wat4wasm (i32.const 2)) ;; "another time..."
	)

	(func $test-sub.wat

	)

	(data  $wat4wasm "\c3\b6\7a\67\c3\bc\72\61\6e\6f\74\68\65\72\20\74\69\6d\65\2e\2e\2e\41\72\72\61\79\42\75\66\66\65\72\70\72\6f\74\6f\74\79\70\65\62\79\74\65\4c\65\6e\67\74\68\67\65\74\67\72\6f\77\61\62\6c\65\73\65\74\69\73\41\72\72\61\79\70\75\73\68\73\6c\69\63\65\73\70\6c\69\63\65")
	(elem  $wat4wasm declare func $wat4wasm)
	(func  $wat4wasm ;; stack limit exceed ;;
		(local $self.Array externref)
		(local $self.Array.prototype externref)
		(local $self.Array.prototype.splice externref)
		(local $self.Array.prototype.slice externref)
		(local $self.Array.prototype.push externref)
		(local $self.Array.isArray externref)
		(local $self.ArrayBuffer externref)
		(local $self.ArrayBuffer.prototype externref)
		(local $self.ArrayBuffer.prototype.growable externref)
		(local $self.ArrayBuffer.prototype.growable/get externref)
		(local $self.ArrayBuffer.prototype.growable/set externref)
		(local $self.ArrayBuffer.prototype.byteLength externref)
		(local $self.ArrayBuffer.prototype.byteLength/get externref)

		(block $self.Array
			(local.set $self.Array
				(call $self.Reflect.get<ext.ext>ext
					(global.get $self)
					(table.get $wat4wasm (i32.const 3)) ;; "Array"
				)
			)
		)

		(block $self.ArrayBuffer
			(local.set $self.ArrayBuffer
				(call $self.Reflect.get<ext.ext>ext
					(global.get $self)
					(table.get $wat4wasm (i32.const 5)) ;; "ArrayBuffer"
				)
			)
		)

		(block $self.ArrayBuffer.prototype
			(local.set $self.ArrayBuffer.prototype
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.ArrayBuffer)
					(table.get $wat4wasm (i32.const 6)) ;; "prototype"
				)
			)
		)

		(block $self.ArrayBuffer.prototype.byteLength
			(local.set $self.ArrayBuffer.prototype.byteLength
				(call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
					(local.get $self.ArrayBuffer.prototype)
					(table.get $wat4wasm (i32.const 7)) ;; "byteLength"
				)
			)
		)

		(block $self.ArrayBuffer.prototype.byteLength/get
			(local.set $self.ArrayBuffer.prototype.byteLength/get
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.ArrayBuffer.prototype.byteLength)
					(table.get $wat4wasm (i32.const 8)) ;; "get"
				)
			)
		)

		(block $self.ArrayBuffer.prototype.growable
			(local.set $self.ArrayBuffer.prototype.growable
				(call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
					(local.get $self.ArrayBuffer.prototype)
					(table.get $wat4wasm (i32.const 10)) ;; "growable"
				)
			)
		)

		(block $self.ArrayBuffer.prototype.growable/set
			(local.set $self.ArrayBuffer.prototype.growable/set
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.ArrayBuffer.prototype.growable)
					(table.get $wat4wasm (i32.const 11)) ;; "set"
				)
			)
		)

		(block $self.ArrayBuffer.prototype.growable/get
			(local.set $self.ArrayBuffer.prototype.growable/get
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.ArrayBuffer.prototype.growable)
					(table.get $wat4wasm (i32.const 8)) ;; "get"
				)
			)
		)

		(block $self.Array.isArray
			(local.set $self.Array.isArray
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.Array)
					(table.get $wat4wasm (i32.const 14)) ;; "isArray"
				)
			)
		)

		(block $self.Array.prototype
			(local.set $self.Array.prototype
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.Array)
					(table.get $wat4wasm (i32.const 6)) ;; "prototype"
				)
			)
		)

		(block $self.Array.prototype.push
			(local.set $self.Array.prototype.push
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.Array.prototype)
					(table.get $wat4wasm (i32.const 16)) ;; "push"
				)
			)
		)

		(block $self.Array.prototype.slice
			(local.set $self.Array.prototype.slice
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.Array.prototype)
					(table.get $wat4wasm (i32.const 18)) ;; "slice"
				)
			)
		)

		(block $self.Array.prototype.splice
			(local.set $self.Array.prototype.splice
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.Array.prototype)
					(table.get $wat4wasm (i32.const 20)) ;; "splice"
				)
			)
		)

		(table.set $wat4wasm (i32.const  3) (local.get $self.Array))
		(table.set $wat4wasm (i32.const  4) (local.get $self.ArrayBuffer.prototype.byteLength/get))
		(table.set $wat4wasm (i32.const  9) (local.get $self.ArrayBuffer.prototype.growable/set))
		(table.set $wat4wasm (i32.const 12) (local.get $self.ArrayBuffer.prototype.growable/get))
		(table.set $wat4wasm (i32.const 13) (local.get $self.Array.isArray))
		(table.set $wat4wasm (i32.const 15) (local.get $self.Array.prototype.push))
		(table.set $wat4wasm (i32.const 17) (local.get $self.Array.prototype.slice))
		(table.set $wat4wasm (i32.const 19) (local.get $self.Array.prototype.splice))
		(nop)

		(call $path:test/sub-folder/test-sub-wat))
	(table $wat4wasm 21 externref)
	(start $wat4wasm)
)