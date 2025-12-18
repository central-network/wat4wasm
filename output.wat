(module
	(import "String" "fromCharCode" (global $self.String.fromCharCode         externref))
	(import "Array" "of"            (func $self.Array.of<ext>ext              (param externref) (result externref)))
	(import "Reflect" "apply"       (func $self.Reflect.apply<ext.ext.ext>ext (param externref externref externref) (result externref)))
	(import "Reflect" "get"         (func $self.Reflect.get<ext.ext>ext       (param externref externref) (result externref)))
	(import "Reflect" "set"         (func $self.Reflect.set<ext.i32.ext>      (param externref i32 externref) (result)))
	(import "Reflect" "set"         (func $self.Reflect.set<ext.i32.i32>      (param externref i32 i32) (result)))
	(import "Reflect" "construct"   (func $self.Reflect.construct<ext.ext>ext (param externref externref) (result externref)))
	(func $main

		;; {ref_extern $self.x} :
		(table.get $wat4wasm (i32.const 6)) ;; self.x
		(drop)

		;; {i32_extern $self.x} :
		(i32.const 6)
		(drop)

		;; {global_get $self.x} :
		(global.get $wat4wasm/self.x)
		(drop)

		;; {global_get $self.x f32} :
		(global.get $wat4wasm/self.x)
		(drop)

		;; {global_get $self.y} :
		(global.get $wat4wasm/self.y)
		(drop)

		;; [self_get $Uint8Array.__proto__.prototype.slice]
		(call $self.Reflect.get<ext.ext>
			(table.get $wat4wasm (i32.const 7)) ;; self.Uint8Array.__proto__.prototype
			(table.get $wat4wasm (i32.const 4)) ;; "slice"
		)
		(drop)

		;; [self_get $navigation.activation.entry.index i32]
		(call $self.Reflect.get<ext.ext>i32
			(table.get $wat4wasm (i32.const 8)) ;; self.navigation.activation.entry
			(table.get $wat4wasm (i32.const 2)) ;; "index"
		)
		(drop)

		;; [self_set $navigation.activation.entry.index [text "2"]]
		(call $self.Reflect.set<ext.ext.ext>
			(table.get $wat4wasm (i32.const 8)) ;; self.navigation.activation.entry
			(table.get $wat4wasm (i32.const 2)) ;; "index"
			(table.get $wat4wasm (i32.const 1))
		)

		;; [self_set $navigation.activation.entry.index [text "2"] i32]
		(call $self.Reflect.set<ext.ext.ext>i32
			(table.get $wat4wasm (i32.const 8)) ;; self.navigation.activation.entry
			(table.get $wat4wasm (i32.const 2)) ;; "index"
			(table.get $wat4wasm (i32.const 1))
		)

		;; [self_set $navigation.activation.entry.index i32 [i32.const 2] i32]
		(call $self.Reflect.set<ext.ext.i32>
			(table.get $wat4wasm (i32.const 8)) ;; self.navigation.activation.entry
			(table.get $wat4wasm (i32.const 2)) ;; "index"
			(i32.const 2)
		)

		;; [self_set $navigation.activation.entry.index fun [...nested block..]]
		(call $self.Reflect.set<ext.ext.fun>
			(table.get $wat4wasm (i32.const 8)) ;; self.navigation.activation.entry
			(table.get $wat4wasm (i32.const 2)) ;; "index"
			(call $any_inner_nested_block
				(result funcref)
				(ref.func $main)
			)
		)

		;; [self_has $navigation.activation.entry [text "index"]]
		(call $self.Reflect.has<ext.ext>i32
			(call $self.Reflect.get<ext.ext>ext
				(table.get $wat4wasm (i32.const 9)) ;; self.navigation.activation
				(table.get $wat4wasm (i32.const 5)) ;; "entry"
			)

			(table.get $wat4wasm (i32.const 2))
		)

		;; [self_has $navigation.activation.entry [text "index"] f32]
		(call $self.Reflect.has<ext.ext>f32
			(call $self.Reflect.get<ext.ext>ext
				(table.get $wat4wasm (i32.const 9)) ;; self.navigation.activation
				(table.get $wat4wasm (i32.const 5)) ;; "entry"
			)
			(table.get $wat4wasm (i32.const 2))
		)

		;; [self_new $WebSocket [text "http://url"] ext]
		(call $self.Reflect.construct<ext.ext>ext
			(table.get $wat4wasm (i32.const 10)) ;; WebSocket
			(call $self.Array.of<>ext

				(table.get $wat4wasm (i32.const 3)) ;; "http://url"
			)
		)

		;; [self_new $WebSocket [text "http://url"]]
		(call $self.Reflect.construct<ext.ext>ext
			(table.get $wat4wasm (i32.const 10)) ;; WebSocket
			(call $self.Array.of<>ext
				(table.get $wat4wasm (i32.const 3)) ;; "http://url"
			)
		)

		;; [self_new $WebSocket ext [text "http://url"] ext]
		(call $self.Reflect.construct<ext.ext>ext
			(table.get $wat4wasm (i32.const 10)) ;; WebSocket
			(call $self.Array.of<>ext
				(table.get $wat4wasm (i32.const 3)) ;; "http://url"
			)
		)

		;; [self_new $WebSocket ext [text "http://url"]]
		(call $self.Reflect.construct<ext.ext>ext
			(table.get $wat4wasm (i32.const 10)) ;; WebSocket
			(call $self.Array.of<ext.i32.fun>ext
				(table.get $wat4wasm (i32.const 3)) ;; "http://url"
				(i32.const 2)
				(ref.func $main)
			)
		)
	)

	(global $wat4wasm/self.x (mut f32) (f32.const 0))
	(global $wat4wasm/self.y (mut externref) (ref.null extern))

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
			(local.set $byteLength (i32.const 30))
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
			(block $text<20:5> ;; "slice"
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 20))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 5))
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
			(block $text<4:1> ;; "2"
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 4))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 1))
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
			(block $text<25:5> ;; "entry"
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 25))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 5))
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
			(block $text<5:5> ;; "index"
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 5))
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 5))
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
			(block $text<10:10> ;; "http://url"
				(call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 10))
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
		)

		(block $self

		)

	)
	(data  $wat4wasm "\00\00\00\00\32\69\6e\64\65\78\68\74\74\70\3a\2f\2f\75\72\6c\73\6c\69\63\65\65\6e\74\72\79")
	(table $wat4wasm 11 externref)
	(start $wat4wasm)
)