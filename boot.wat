
	(func  $wat4wasm ;; stack limit exceed ;;
		(local $self.GPUAdapter externref)
		(local $self.GPUAdapter.prototype externref)
		(local $self.GPUAdapter.prototype.requestDevice externref)
		(local $self.Array externref)
		(local $self.Array.prototype externref)
		(local $self.Array.prototype.splice externref)
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
					(table.get $wat4wasm (i32.const 2)) ;; "Array"
				)
			)
		)

		(block $self.ArrayBuffer
			(local.set $self.ArrayBuffer
				(call $self.Reflect.get<ext.ext>ext
					(global.get $self)
					(table.get $wat4wasm (i32.const 4)) ;; "ArrayBuffer"
				)
			)
		)

		(block $self.ArrayBuffer.prototype
			(local.set $self.ArrayBuffer.prototype
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.ArrayBuffer)
					(table.get $wat4wasm (i32.const 5)) ;; "prototype"
				)
			)
		)

		(block $self.ArrayBuffer.prototype.byteLength
			(local.set $self.ArrayBuffer.prototype.byteLength
				(call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
					(local.get $self.ArrayBuffer.prototype)
					(table.get $wat4wasm (i32.const 6)) ;; "byteLength"
				)
			)
		)

		(block $self.ArrayBuffer.prototype.byteLength/get
			(local.set $self.ArrayBuffer.prototype.byteLength/get
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.ArrayBuffer.prototype.byteLength)
					(table.get $wat4wasm (i32.const 7)) ;; "get"
				)
			)
		)

		(block $self.ArrayBuffer.prototype.growable
			(local.set $self.ArrayBuffer.prototype.growable
				(call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
					(local.get $self.ArrayBuffer.prototype)
					(table.get $wat4wasm (i32.const 9)) ;; "growable"
				)
			)
		)

		(block $self.ArrayBuffer.prototype.growable/set
			(local.set $self.ArrayBuffer.prototype.growable/set
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.ArrayBuffer.prototype.growable)
					(table.get $wat4wasm (i32.const 10)) ;; "set"
				)
			)
		)

		(block $self.ArrayBuffer.prototype.growable/get
			(local.set $self.ArrayBuffer.prototype.growable/get
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.ArrayBuffer.prototype.growable)
					(table.get $wat4wasm (i32.const 7)) ;; "get"
				)
			)
		)

		(block $self.Array.isArray
			(local.set $self.Array.isArray
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.Array)
					(table.get $wat4wasm (i32.const 13)) ;; "isArray"
				)
			)
		)

		(block $self.Array.prototype
			(local.set $self.Array.prototype
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.Array)
					(table.get $wat4wasm (i32.const 5)) ;; "prototype"
				)
			)
		)

		(block $self.Array.prototype.push
			(local.set $self.Array.prototype.push
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.Array.prototype)
					(table.get $wat4wasm (i32.const 15)) ;; "push"
				)
			)
		)

		(block $self.Array.prototype.splice
			(local.set $self.Array.prototype.splice
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.Array.prototype)
					(table.get $wat4wasm (i32.const 17)) ;; "splice"
				)
			)
		)

		(block $self.GPUAdapter
			(local.set $self.GPUAdapter
				(call $self.Reflect.get<ext.ext>ext
					(global.get $self)
					(table.get $wat4wasm (i32.const 19)) ;; "GPUAdapter"
				)
			)
		)

		(block $self.GPUAdapter.prototype
			(local.set $self.GPUAdapter.prototype
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.GPUAdapter)
					(table.get $wat4wasm (i32.const 5)) ;; "prototype"
				)
			)
		)

		(block $self.GPUAdapter.prototype.requestDevice
			(local.set $self.GPUAdapter.prototype.requestDevice
				(call $self.Reflect.get<ext.ext>ext
					(local.get $self.GPUAdapter.prototype)
					(table.get $wat4wasm (i32.const 20)) ;; "requestDevice"
				)
			)
		)

		(table.set $wat4wasm (i32.const  2) (local.get $self.Array))
		(table.set $wat4wasm (i32.const  3) (local.get $self.ArrayBuffer.prototype.byteLength/get))
		(table.set $wat4wasm (i32.const  8) (local.get $self.ArrayBuffer.prototype.growable/set))
		(table.set $wat4wasm (i32.const 11) (local.get $self.ArrayBuffer.prototype.growable/get))
		(table.set $wat4wasm (i32.const 12) (local.get $self.Array.isArray))
		(table.set $wat4wasm (i32.const 14) (local.get $self.Array.prototype.push))
		(table.set $wat4wasm (i32.const 16) (local.get $self.Array.prototype.splice))
		(table.set $wat4wasm (i32.const 18) (local.get $self.GPUAdapter.prototype.requestDevice))
    )