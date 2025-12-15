

(module
	(import "self" "self"                  (global $self                             externref))
	(import "Array" "of"                   (func $self.Array.of<i32.i32.ref>ref      (param i32 i32 externref) (result externref)))
	(import "Array" "of"                   (func $self.Array.of<i32>ref              (param i32) (result externref)))
	(import "Array" "of"                   (func $self.Array.of<ref>ref              (param externref) (result externref)))
	(import "Date" "now"                   (func $self.Date.now<>f32                 (param ) (result f32)))
	(import "Date" "now"                   (func $self.Date.now<>f64                 (param ) (result f64)))
	(import "Math" "atan"                  (func $self.Math.atan<f32.f64>f32         (param f32 f64) (result f32)))
	(import "Math" "max"                   (func $self.Math.max<f32.f32>f32          (param f32 f32) (result f32)))
	(import "Math" "random"                (func $self.Math.random<>f32              (param ) (result f32)))
	(import "Reflect" "apply"              (func $self.Reflect.apply<>f32            (param externref externref externref) (result f32)))
	(import "Reflect" "apply"              (func $self.Reflect.apply<fun.ref.ref>i32 (param funcref externref externref) (result i32)))
	(import "Reflect" "apply"              (func $self.Reflect.apply<ref.ref.ref>    (param externref externref externref) ))
	(import "Reflect" "apply"              (func $self.Reflect.apply<ref.ref.ref>i64 (param externref externref externref) (result i64)))
	(import "Reflect" "apply"              (func $self.Reflect.apply<ref.ref.ref>ref (param externref externref externref) (result externref)))
	(import "Reflect" "construct"          (func $self.Reflect.construct<ref.ref>ref (param externref externref) (result externref)))
	(import "Reflect" "get"                (func $self.Reflect.get<ref.i32>ref       (param externref i32) (result externref)))
	(import "Reflect" "get"                (func $self.Reflect.get<ref.ref>ref       (param externref externref) (result externref)))
	(import "Reflect" "set"                (func $self.Reflect.set<ref.i32.i32>      (param externref i32 i32) ))
	(import "Reflect" "set"                (func $self.Reflect.set<ref.i32.ref>      (param externref i32 externref) (result)))
	(import "console" "log"                (func $self.console.log<>                 (param ) ))
	(import "console" "log"                (func $self.console.log<ref.i32>          (param externref i32) ))
	(import "console" "log"                (func $self.console.log<ref>              (param externref) ))
	(import "self" "Array"                 (func $self.Array<>ref                    (param) (result externref)))
	(import "self" "requestAnimationFrame" (func $self.requestAnimationFrame<fun>i32 (param funcref) (result i32)))
	(import "String" "fromCharcode"        (global $self.String.fromCharCode         externref))








































	(table $wat4wasm 20 20 externref)

	(elem $wat4wasm declare func
		(ref.func $onanimationframe)
	)



	(func $test-sub

	)

	(func $main-2


		(call $self.console.log<ref>
			(call $self.Array.of<i32.i32.ref>ref
				(i32.const 100)
				(i32.const 200)
				(table.get $wat4wasm (i32.const 8))
			)
		)
	)

	(memory 10 10 shared)

	(func $test
		(local $arguments externref)
		(local.set $arguments (array))

		(table.get $wat4wasm (i32.const 9))

		(call $self.Reflect.construct<ref.ref>ref
			(table.get $wat4wasm (i32.const 5))
			(local.get $arguments)
		)

		(call $self.Reflect.get<ref.i32>ref
			(local.get $arguments)
			(i32.const 0)
		)

		(call $self.Reflect.set<ref.i32.i32>
			(local.get $arguments)
			(i32.const 0)
			(memory.size)
		)

		(call $self.Math.atan<f32.f64>f32
			(call $self.Math.random<>f32)
			(call $self.Date.now<>f64)
		)

		(call $self.Math.max<f32.f32>f32
			(call $self.Date.now<>f32)
			(call $self.Reflect.apply<>f32
				(table.get $wat4wasm (i32.const 4))
				(global.get $self)
				(global.get $self)

			)
		)

		(call $self.requestAnimationFrame<fun>i32
			(ref.func $onanimationframe)
		)
	)

	(func $main
		(call $self.console.log<>
			(table.get $wat4wasm (i32.const 10))
		)

		(call $self.Reflect.apply<ref.ref.ref>i64
			(table.get $wat4wasm (i32.const 6))
			(global.get $self)
			(call $self.Array.of<ref>ref
				(table.get $wat4wasm (i32.const 11))
			)
		)

		(call $self.Reflect.apply<ref.ref.ref>
			(table.get $wat4wasm (i32.const 6))
			(global.get $self)
			(call $self.Array.of<ref>ref
				(table.get $wat4wasm (i32.const 11))
			)
		)


		(call $self.Reflect.apply<fun.ref.ref>i32
			(table.get $wat4wasm (i32.const 7))
			(ref.null extern)
			(call $self.Array.of<i32>ref
				(i32.const 123)
			)
		)

		(call $self.requestAnimationFrame<fun>i32
			(ref.func $inlinefunction<f32>)
		)
	)

	(func $inlinefunction<f32>
		(param $performance.now f32)

		(call $self.console.log<ref.i32>
			(table.get $wat4wasm (i32.const 12))
			(call $self.Reflect.apply<>f32
				(table.get $wat4wasm (i32.const 1))
				(global.get $self)
				(global.get $self)

			)
		)
	)

	;; --- Wat4Wasm Injected Blocks ---

	(data $wat4wasm "\06\01\00\00\6d\69\6c\6c\65\74\5f\79\65\72\69\6e\65\5f\74\65\78\74\5f\6b\75\6c\6c\61\6e\c4\b1\6d\c4\b1\6e\c4\b1\5f\c3\b6\7a\65\6e\64\69\72\65\6c\69\6d\5f\61\c5\9f\6b\c4\b1\6d\42\75\20\62\69\72\20\c3\a7\6f\6b\6c\75\20\73\61\74\69\72\20\c3\b6\72\6e\65\c4\9f\69\64\69\72\2e\0a\20\20\20\20\20\20\20\20\20\20\20\20\69\c3\a7\69\6e\64\65\20\64\65\20\5c\22\6d\61\73\6b\65\5c\22\20\6b\65\6c\69\6d\65\20\76\61\72\2e\69\6e\74\65\72\61\6c\20\74\65\78\74\20\63\6f\6e\76\65\72\74\65\64\20\74\6f\20\74\61\62\6c\65\2e\67\65\74\21\53\74\61\6e\64\61\72\74\20\67\c3\b6\72\c3\bc\6e\c3\bc\6d\20\68\61\72\69\6b\61\21\61\6e\69\6d\61\74\69\6f\6e\20\66\72\61\6d\65\20\72\65\61\64\79\3a\70\65\72\66\6f\72\6d\61\6e\63\65\6e\6f\77\57\65\62\53\6f\63\6b\65\74\63\6f\6e\73\6f\6c\65\6c\6f\67\61\6c\65\72\74\62\69\6e\64\00\00\00\00\00\00")

	;; --- Wat4Wasm Bootstrap Start ---
	(func $__wat4wasm_bootstrap
		(local $__new_decoder__ externref)
		(local $__decode_func__ externref)
		(local $__buffer_view__ externref)
		(local $__heap_backup__ externref)
		(local $__data_length__ externref)
		(local $__data_offset__ externref)
		(local $__text_offset__ externref)
		(local $__newviewargs__ externref)
		(local $__decode_args__ externref)
		(local $__char__codes__ externref)
		(local $_bind_function_ externref)
		(local $_func_argument_ externref)
		(local $self.Uint8Array externref)
		(local $__ref_performance externref)
		(local $__ref_now externref)
		(local $__ref_WebSocket externref)
		(local $__ref_console externref)
		(local $__ref_console_log externref)
		(local $__ref_alert externref)


		(block $TextDecoder
			(local.set $__new_decoder__
				(call $self.Reflect.construct<ref.ref>ref
					(call $self.Reflect.get<ref.ref>ref
						(global.get $self)
						(block
							(result externref)
							(local.set $__char__codes__ (call $self.Array<>ref))

							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 0) (i32.const 84))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 1) (i32.const 101))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 2) (i32.const 120))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 3) (i32.const 116))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 4) (i32.const 68))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 5) (i32.const 101))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 6) (i32.const 99))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 7) (i32.const 111))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 8) (i32.const 100))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 9) (i32.const 101))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 10) (i32.const 114))

							(call $self.Reflect.apply<ref.ref.ref>ref
								(global.get $self.String.fromCharCode)
								(ref.null externref)
								(local.get $__char__codes__)
							)
						)
					)
					(global.get $self)
				)
			)

			(local.set $__decode_func__
				(call $self.Reflect.get<ref.ref>ref
					(local.get $__new_decoder__)
					(block
						(result externref)
						(local.set $__char__codes__ (call $self.Array<>ref))

						(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 0) (i32.const 100))
						(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 1) (i32.const 101))
						(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 2) (i32.const 99))
						(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 3) (i32.const 111))
						(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 4) (i32.const 100))
						(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 5) (i32.const 101))

						(call $self.Reflect.apply<ref.ref.ref>ref
							(global.get $self.String.fromCharCode)
							(ref.null externref)
							(local.get $__char__codes__)
						)
					)
				)
			)

			(local.set $__heap_backup__
				(i32.load (i32.const 0))
			)

			(memory.init $wat4wasm
				(i32.const 0)
				(i32.const 0)
				(i32.const 4)
			)

			(local.set $__data_offset__ (i32.const 4))
			(local.set $__text_offset__ (i32.const 0))
			(local.set $__text_length__ (i32.load (i32.const 0)))
			(local.set $__newviewargs__ (call $self.Array<>ref))

			(call $self.Reflect.set<ref.i32.i32>
				(local.get $__newviewargs__)
				(i32.const 0)
				(local.get $__text_length__)
			)

			(local.set $__buffer_view__
				(call $self.Reflect.construct<ref.ref>ref
					(call $self.Reflect.get<ref.ref>ref
						(global.get $self)
						(block
							(result externref)
							(local.set $__char__codes__ (call $self.Array<>ref))

							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 0) (i32.const 85))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 1) (i32.const 105))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 2) (i32.const 110))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 3) (i32.const 116))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 4) (i32.const 56))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 5) (i32.const 65))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 6) (i32.const 114))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 7) (i32.const 114))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 8) (i32.const 97))
							(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 9) (i32.const 121))

							(call $self.Reflect.apply<ref.ref.ref>ref
								(global.get $self.String.fromCharCode)
								(ref.null externref)
								(local.get $__char__codes__)
							)
						)
					)
					(local.get $__newviewargs__)
				)
			)

			(loop $length--
				(memory.init $wat4wasm
					(i32.const 0)
					(local.get $__data_offset__)
					(i32.const 1)
				)

				(call $self.Reflect.set<ref.i32.i32>
					(local.get $__buffer_view__)
					(local.get $__text_offset__)
					(i32.load8_u (i32.const 0))
				)

				(local.set $__data_offset__
					(i32.add
						(local.get $__data_offset__)
						(i32.const 1)
					)
				)

				(local.set $__text_offset__
					(i32.add
						(local.get $__text_offset__)
						(i32.const 1)
					)
				)

				(br_if $length--
					(local.tee $__text_length__
						(i32.sub
							(local.get $__text_length__)
							(i32.const 1)
						)
					)
				)
			)

			(data.drop $wat4wasm)
			(i32.store (local.get $__heap_backup__))

			(call $self.Reflect.set<ref.i32.ref>
				(local.get $__newviewargs__)
				(i32.const 0)
				(call $self.Reflect.get<ref.ref>ref
					(local.get $__buffer_view__)
					(block
						(result externref)
						(local.set $__char__codes__ (call $self.Array<>ref))

						(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 0) (i32.const 98))
						(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 1) (i32.const 117))
						(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 2) (i32.const 102))
						(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 3) (i32.const 102))
						(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 4) (i32.const 101))
						(call $self.Reflect.set<ref.i32.i32> (local.get $__char__codes__) (i32.const 5) (i32.const 114))

						(call $self.Reflect.apply<ref.ref.ref>ref
							(global.get $self.String.fromCharCode)
							(ref.null externref)
							(local.get $__char__codes__)
						)
					)
				)
			)

			(local.set $__decode_args__ (call $self.Array<>ref))
		)


		(block $decodeText
			(table.set $wat4wasm
				(i32.const 8)
				(block (result externref)
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 1) (i32.const 4))
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 2) (i32.const 54))

					(call $self.Reflect.set<ref.i32.ref>
						(local.get $__decode_args__)
						(i32.const 0)
						(call $self.Reflect.construct<ref.ref>ref
							(local.get $self.Uint8Array)
							(local.get $__newviewargs__)
						)
					)

					(call $self.Reflect.apply<ref.ref.ref>ref
						(local.get $__decode_func__)
						(local.get $__new_decoder__)
						(local.get $__decode_args__)
					)
				)
			)

			(table.set $wat4wasm
				(i32.const 9)
				(block (result externref)
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 1) (i32.const 58))
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 2) (i32.const 77))

					(call $self.Reflect.set<ref.i32.ref>
						(local.get $__decode_args__)
						(i32.const 0)
						(call $self.Reflect.construct<ref.ref>ref
							(local.get $self.Uint8Array)
							(local.get $__newviewargs__)
						)
					)

					(call $self.Reflect.apply<ref.ref.ref>ref
						(local.get $__decode_func__)
						(local.get $__new_decoder__)
						(local.get $__decode_args__)
					)
				)
			)

			(table.set $wat4wasm
				(i32.const 10)
				(block (result externref)
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 1) (i32.const 135))
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 2) (i32.const 36))

					(call $self.Reflect.set<ref.i32.ref>
						(local.get $__decode_args__)
						(i32.const 0)
						(call $self.Reflect.construct<ref.ref>ref
							(local.get $self.Uint8Array)
							(local.get $__newviewargs__)
						)
					)

					(call $self.Reflect.apply<ref.ref.ref>ref
						(local.get $__decode_func__)
						(local.get $__new_decoder__)
						(local.get $__decode_args__)
					)
				)
			)

			(table.set $wat4wasm
				(i32.const 11)
				(block (result externref)
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 1) (i32.const 171))
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 2) (i32.const 27))

					(call $self.Reflect.set<ref.i32.ref>
						(local.get $__decode_args__)
						(i32.const 0)
						(call $self.Reflect.construct<ref.ref>ref
							(local.get $self.Uint8Array)
							(local.get $__newviewargs__)
						)
					)

					(call $self.Reflect.apply<ref.ref.ref>ref
						(local.get $__decode_func__)
						(local.get $__new_decoder__)
						(local.get $__decode_args__)
					)
				)
			)

			(table.set $wat4wasm
				(i32.const 12)
				(block (result externref)
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 1) (i32.const 198))
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 2) (i32.const 22))

					(call $self.Reflect.set<ref.i32.ref>
						(local.get $__decode_args__)
						(i32.const 0)
						(call $self.Reflect.construct<ref.ref>ref
							(local.get $self.Uint8Array)
							(local.get $__newviewargs__)
						)
					)

					(call $self.Reflect.apply<ref.ref.ref>ref
						(local.get $__decode_func__)
						(local.get $__new_decoder__)
						(local.get $__decode_args__)
					)
				)
			)

			(table.set $wat4wasm
				(i32.const 13)
				(block (result externref)
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 1) (i32.const 220))
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 2) (i32.const 11))

					(call $self.Reflect.set<ref.i32.ref>
						(local.get $__decode_args__)
						(i32.const 0)
						(call $self.Reflect.construct<ref.ref>ref
							(local.get $self.Uint8Array)
							(local.get $__newviewargs__)
						)
					)

					(call $self.Reflect.apply<ref.ref.ref>ref
						(local.get $__decode_func__)
						(local.get $__new_decoder__)
						(local.get $__decode_args__)
					)
				)
			)

			(table.set $wat4wasm
				(i32.const 14)
				(block (result externref)
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 1) (i32.const 231))
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 2) (i32.const 3))

					(call $self.Reflect.set<ref.i32.ref>
						(local.get $__decode_args__)
						(i32.const 0)
						(call $self.Reflect.construct<ref.ref>ref
							(local.get $self.Uint8Array)
							(local.get $__newviewargs__)
						)
					)

					(call $self.Reflect.apply<ref.ref.ref>ref
						(local.get $__decode_func__)
						(local.get $__new_decoder__)
						(local.get $__decode_args__)
					)
				)
			)

			(table.set $wat4wasm
				(i32.const 15)
				(block (result externref)
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 1) (i32.const 234))
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 2) (i32.const 9))

					(call $self.Reflect.set<ref.i32.ref>
						(local.get $__decode_args__)
						(i32.const 0)
						(call $self.Reflect.construct<ref.ref>ref
							(local.get $self.Uint8Array)
							(local.get $__newviewargs__)
						)
					)

					(call $self.Reflect.apply<ref.ref.ref>ref
						(local.get $__decode_func__)
						(local.get $__new_decoder__)
						(local.get $__decode_args__)
					)
				)
			)

			(table.set $wat4wasm
				(i32.const 16)
				(block (result externref)
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 1) (i32.const 243))
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 2) (i32.const 7))

					(call $self.Reflect.set<ref.i32.ref>
						(local.get $__decode_args__)
						(i32.const 0)
						(call $self.Reflect.construct<ref.ref>ref
							(local.get $self.Uint8Array)
							(local.get $__newviewargs__)
						)
					)

					(call $self.Reflect.apply<ref.ref.ref>ref
						(local.get $__decode_func__)
						(local.get $__new_decoder__)
						(local.get $__decode_args__)
					)
				)
			)

			(table.set $wat4wasm
				(i32.const 17)
				(block (result externref)
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 1) (i32.const 250))
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 2) (i32.const 3))

					(call $self.Reflect.set<ref.i32.ref>
						(local.get $__decode_args__)
						(i32.const 0)
						(call $self.Reflect.construct<ref.ref>ref
							(local.get $self.Uint8Array)
							(local.get $__newviewargs__)
						)
					)

					(call $self.Reflect.apply<ref.ref.ref>ref
						(local.get $__decode_func__)
						(local.get $__new_decoder__)
						(local.get $__decode_args__)
					)
				)
			)

			(table.set $wat4wasm
				(i32.const 18)
				(block (result externref)
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 1) (i32.const 253))
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 2) (i32.const 5))

					(call $self.Reflect.set<ref.i32.ref>
						(local.get $__decode_args__)
						(i32.const 0)
						(call $self.Reflect.construct<ref.ref>ref
							(local.get $self.Uint8Array)
							(local.get $__newviewargs__)
						)
					)

					(call $self.Reflect.apply<ref.ref.ref>ref
						(local.get $__decode_func__)
						(local.get $__new_decoder__)
						(local.get $__decode_args__)
					)
				)
			)

			(table.set $wat4wasm
				(i32.const 19)
				(block (result externref)
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 1) (i32.const 258))
					(call $self.Reflect.set<ref.i32.i32> (local.get $__newviewargs__) (i32.const 2) (i32.const 4))

					(call $self.Reflect.set<ref.i32.ref>
						(local.get $__decode_args__)
						(i32.const 0)
						(call $self.Reflect.construct<ref.ref>ref
							(local.get $self.Uint8Array)
							(local.get $__newviewargs__)
						)
					)

					(call $self.Reflect.apply<ref.ref.ref>ref
						(local.get $__decode_func__)
						(local.get $__new_decoder__)
						(local.get $__decode_args__)
					)
				)
			)
		)


		(block $ref.externef

			(local.set $__ref_performance
				(call $self.Reflect.get<ref.ref>ref
					(global.get $self)
					(table.get $wat4wasm (i32.const 13))
				)
			)

			(table.set $wat4wasm (i32.const 2) (local.get $__ref_performance))


			(local.set $__ref_now
				(call $self.Reflect.get<ref.ref>ref
					(local.get $__ref_performance)
					(table.get $wat4wasm (i32.const 14))
				)
			)

			(table.set $wat4wasm (i32.const 3) (local.get $__ref_now))


			(local.set $__ref_WebSocket
				(call $self.Reflect.get<ref.ref>ref
					(global.get $self)
					(table.get $wat4wasm (i32.const 15))
				)
			)

			(table.set $wat4wasm (i32.const 5) (local.get $__ref_WebSocket))


			(local.set $__ref_console
				(call $self.Reflect.get<ref.ref>ref
					(global.get $self)
					(table.get $wat4wasm (i32.const 16))
				)
			)


			(local.set $__ref_console_log
				(call $self.Reflect.get<ref.ref>ref
					(local.get $__ref_console)
					(table.get $wat4wasm (i32.const 17))
				)
			)

			(table.set $wat4wasm (i32.const 6) (local.get $__ref_console_log))


			(local.set $__ref_alert
				(call $self.Reflect.get<ref.ref>ref
					(global.get $self)
					(table.get $wat4wasm (i32.const 18))
				)
			)

			(table.set $wat4wasm (i32.const 7) (local.get $__ref_alert))
		)


		(block $call_bound
			(local.set $_this_argument_ (call $self.Array<>ref))

			(local.set $_bind_function_
				(call $self.Reflect.get<ref.ref>ref
					(global.get $String.fromCharCode)
					(table.get $wat4wasm (i32.const 19))
				)
			)

			(table.set $wat4wasm
				(i32.const 1)
				(block (result externref)
					(call $self.Reflect.set<ref.i32.ref>
						(local.get $_this_argument_)
						(i32.const 0)
						(table.get $wat4wasm (i32.const 2))
					)

					(call $self.Reflect.apply<ref.ref.ref>ref
						(local.get $_bind_function_)
						(table.get $wat4wasm (i32.const 3))
						(local.get $_this_argument_)
					)
				)
			)
			(table.set $wat4wasm
				(i32.const 4)
				(block (result externref)
					(call $self.Reflect.set<ref.i32.ref>
						(local.get $_this_argument_)
						(i32.const 0)
						(table.get $wat4wasm (i32.const 2))
					)

					(call $self.Reflect.apply<ref.ref.ref>ref
						(local.get $_bind_function_)
						(table.get $wat4wasm (i32.const 3))
						(local.get $_this_argument_)
					)
				)
			)
		)


		(call $main)
	)

	(start $__wat4wasm_bootstrap)
)

