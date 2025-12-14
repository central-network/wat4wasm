(module


	;; --- Standard Library Imports ---
	(import "self" "self"                        (global $self                                            externref))

	(import "Reflect" "apply"                    (func $self.Reflect.apply<ref.ref.ref>                   (param externref externref externref) (result externref)))
	(import "Reflect" "get"                      (func $self.Reflect.get<ref.ref>ref                      (param externref externref) (result externref)))
	(import "Reflect" "get"                      (func $self.Reflect.get<ref.i32>i32                      (param externref i32) (result i32)))
	(import "Reflect" "set"                      (func $self.Reflect.set<ref.ref.i32>                     (param externref externref i32)))
	(import "Reflect" "construct"                (func $self.Reflect.construct<ref.ref>ref                (param externref externref) (result externref)))

	;; YENİ: Descriptor alıcı (Getter/Setter'lara erişmek için şart)
	(import "Reflect" "getOwnPropertyDescriptor" (func $self.Reflect.getOwnPropertyDescriptor<ref.ref>ref (param externref externref) (result externref)))

	(import "Array" "of"                         (func $wat4wasm/Array.of<i32.i32>ref                     (param i32 i32) (result externref)))
	(import "Array" "of"                         (func $wat4wasm/Array.of<i32.i32.ref>ref                 (param i32 i32 externref) (result externref)))
	(import "Array" "of"                         (func $wat4wasm/Array.of<ref>ref                         (param externref) (result externref)))
	(import "Array" "of"                         (func $wat4wasm/Array.of<i32>ref                         (param i32) (result externref)))


	(func $test-sub

	)

	(func $main-2

		(call $log (table.get $wat4wasm<ext> (i32.const 1)))


		(call $alert (table.get $wat4wasm<ext> (i32.const 17)))
		(call $alert (table.get $wat4wasm<ext> (i32.const 17)))
		(call $alert (table.get $wat4wasm<ext> (i32.const 18)))



		(call $log (table.get $wat4wasm<ext> (i32.const 12)))



		(call $log (table.get $wat4wasm<ext> (i32.const 13)))





		(call $log (table.get $wat4wasm<ext> (i32.const 14)))


		(call $log
			(call $wat4wasm/Array.of<i32.i32>ref
				(i32.const 10)
				(i32.const 20)
			)
			(array)
		)



		(call $log
			(call $wat4wasm/Array.of<i32.i32.ref>ref
				(i32.const 100)
				(i32.const 200)
				(table.get $wat4wasm<ext> (i32.const 2))
			)
		)
	)





	(global $self.screen.width                    f32)
	(global $self.Math                            externref)
	(global $self.Math.max                        externref)
	(global $self.location.origin                 externref)
	(global $self.console.warn                    externref)
	(global $self.MessageEvent.prototype.data/get externref)
	(global $self.Worker:onmessage/set            externref)

	(global $ANY_TEXT_GLOBAL                      "any text
		\\"masked\\"
		global")

	(memory 10 10 shared)

	(func $test
		(local $arg0 i32)

		(local.set 0 (table.get $wat4wasm<ext> (i32.const 3)))

		(local.set 0 i32(24))


		this
		(warn<i32>)

		self
		(warn<ref>)

		null
		(warn<ref>)



		(new $self.Worker<refx2>ref
			(table.get $wat4wasm<ext> (i32.const 4))
			(call $self.Object.fromEntries<ref>ref
				(call $self.Array<ref>ref
					(call $self.Array.of<refx2>ref
						(table.get $wat4wasm<ext> (i32.const 5))
						(table.get $wat4wasm<ext> (i32.const 6))
					)
				)
			)
		)
		(warn<ref>)

		(get <refx2>ref self (table.get $wat4wasm<ext> (i32.const 7)))
		(warn<ref>)

		(set <refx2.fun> self text("onresize") func($onresize))


		(async
			(call $self.navigator.gpu.requestAdapter)
			(then $onadapter
				(param $adapter externref)
				(warn <ref> this)
			)
			(catch $onfail
				(param $msg externref)
				(error <ref> local($msg))
			)
		)
	)

	(func $onresize
		(param $a i32)
		(log<i32> this)
	)

	(global $self.navigator.hardwareConcurrency   i32)

	(on $message
		(param $event externref)
		(log<ref> this)
		(log<ref> (table.get $wat4wasm<ext> (i32.const 8)))
	)

	(start $main

		(log<ref> (table.get $wat4wasm<ext> (i32.const 9)))
		(log<ref> (global.get $self.location.origin))
		(log<f32> (global.get $self.screen.width))
		(log<ref> (global.get $self.MessageEvent.prototype.data/get))
		(log<ref> (global.get $self.Worker:onmessage/set))
		(warn<ref> (global.get $ANY_TEXT_GLOBAL))


		(call $self.Reflect.apply<ref.ref.ref>
			(table.get $wat4wasm<ext> (i32.const 15))
			(global.get $self)
			(call $wat4wasm/Array.of<ref>ref
				(table.get $wat4wasm<ext> (i32.const 10))
			)
		)



		(call $self.Reflect.apply<ref.ref.ref>
			(table.get $wat4wasm<ext> (i32.const 16))
			(ref.null extern)
			(call $wat4wasm/Array.of<i32>ref
				(i32.const 123)
			)
		)

		(call $self.requestAnimationFrame<fun>
			(func $inlinefunction<f32>
				(param $performance.now f32)

				(log<ref.f32>
					(table.get $wat4wasm<ext> (i32.const 11))
					(local.get $performance.now)
				)
			)
		)
	)




	;; --- Wat4Wasm Injected Blocks ---
	(table $wat4wasm<ext> 19 19 externref)
	(data $wat4wasm/text "\2c\01\00\00\4d\65\72\68\61\62\61\20\44\c3\bc\6e\79\61\6d\69\6c\6c\65\74\65\5f\73\74\72\69\6e\67\5f\79\65\72\69\6e\65\5f\74\65\78\74\5f\6b\75\6c\6c\61\6e\c4\b1\6d\c4\b1\6e\c4\b1\5f\c3\b6\7a\65\6e\64\69\72\65\6c\69\6d\5f\61\c5\9f\6b\c4\b1\6d\42\75\20\62\69\72\0a\20\20\20\20\20\20\20\20\20\20\20\20\c3\a7\6f\6b\6c\75\20\73\61\74\c4\b1\72\20\c3\b6\72\6e\65\c4\9f\69\64\69\72\2e\0a\20\20\20\20\20\20\20\20\20\20\20\20\c4\b0\c3\a7\69\6e\64\65\20\5c\22\65\73\63\61\70\65\64\5c\22\20\74\c4\b1\72\6e\61\6b\6c\61\72\20\76\61\72\2e\77\6f\72\6b\65\72\2e\6a\73\6e\61\6d\65\c3\b6\7a\67\c3\bc\72\6f\72\69\67\69\6e\68\65\6c\6c\6f\20\c3\b6\7a\67\c3\bc\72\69\6e\74\65\72\61\6c\20\74\65\78\74\20\63\6f\6e\76\65\72\74\65\64\20\74\6f\20\74\61\62\6c\65\2e\67\65\74\21\53\74\61\6e\64\61\72\74\20\67\c3\b6\72\c3\bc\6e\c3\bc\6d\20\68\61\72\69\6b\61\21\61\6e\69\6d\61\74\69\6f\6e\20\66\72\61\6d\65\20\72\65\61\64\79\3a\00\00")


	;; --- Wat4Wasm Bootstrap Start ---
	(func $__wat4wasm_bootstrap
		(local $__ref_tmp externref)

		;; Tabloyu ve Verileri Doldur

		(table.set $wat4wasm<ext> (i32.const 1) (call $wat4wasm/decodeText<i32.i32>ref (i32.const 4) (i32.const 14)))
		(table.set $wat4wasm<ext> (i32.const 2) (call $wat4wasm/decodeText<i32.i32>ref (i32.const 18) (i32.const 62)))
		(table.set $wat4wasm<ext> (i32.const 3) (call $wat4wasm/decodeText<i32.i32>ref (i32.const 80) (i32.const 94)))
		(table.set $wat4wasm<ext> (i32.const 4) (call $wat4wasm/decodeText<i32.i32>ref (i32.const 174) (i32.const 9)))
		(table.set $wat4wasm<ext> (i32.const 5) (call $wat4wasm/decodeText<i32.i32>ref (i32.const 183) (i32.const 4)))
		(table.set $wat4wasm<ext> (i32.const 6) (call $wat4wasm/decodeText<i32.i32>ref (i32.const 187) (i32.const 7)))
		(table.set $wat4wasm<ext> (i32.const 7) (call $wat4wasm/decodeText<i32.i32>ref (i32.const 194) (i32.const 6)))
		(table.set $wat4wasm<ext> (i32.const 8) (call $wat4wasm/decodeText<i32.i32>ref (i32.const 200) (i32.const 13)))
		(table.set $wat4wasm<ext> (i32.const 9) (call $wat4wasm/decodeText<i32.i32>ref (i32.const 213) (i32.const 36)))
		(table.set $wat4wasm<ext> (i32.const 10) (call $wat4wasm/decodeText<i32.i32>ref (i32.const 249) (i32.const 27)))
		(table.set $wat4wasm<ext> (i32.const 11) (call $wat4wasm/decodeText<i32.i32>ref (i32.const 276) (i32.const 22)))
		(table.set $wat4wasm<ext> (i32.const 12)
			(block (result externref)
				(local.set $__ref_tmp (global.get $self))

				(local.set $__ref_tmp
					(call $self.Reflect.get<ref.ref>ref
						(local.get $__ref_tmp)
						(string "ArrayBuffer")
					)
				)

				(local.set $__ref_tmp
					(call $self.Reflect.get<ref.ref>ref
						(local.get $__ref_tmp)
						(string "prototype")
					)
				)

				;; --- Descriptor Mode: byteLength/get ---
				;; 1. Descriptor'ı al: Reflect.getOwnPropertyDescriptor(target, prop)
				(local.set $__ref_tmp
					(call $self.Reflect.getOwnPropertyDescriptor<ref.ref>ref
						(local.get $__ref_tmp)
						(string "byteLength")
					)
				)
				;; 2. Getter fonksiyonunu çek: Reflect.get(descriptor, "get")
				(local.set $__ref_tmp
					(call $self.Reflect.get<ref.ref>ref
						(local.get $__ref_tmp)
						(string "get")
					)
				)

				(local.get $__ref_tmp)
		))
		(table.set $wat4wasm<ext> (i32.const 13)
			(block (result externref)
				(local.set $__ref_tmp (global.get $self))

				(local.set $__ref_tmp
					(call $self.Reflect.get<ref.ref>ref
						(local.get $__ref_tmp)
						(string "WebAssembly")
					)
				)

				(local.set $__ref_tmp
					(call $self.Reflect.get<ref.ref>ref
						(local.get $__ref_tmp)
						(string "Memory")
					)
				)

				(local.set $__ref_tmp
					(call $self.Reflect.get<ref.ref>ref
						(local.get $__ref_tmp)
						(string "prototype")
					)
				)

				(local.set $__ref_tmp
					(call $self.Reflect.get<ref.ref>ref
						(local.get $__ref_tmp)
						(string "grow")
					)
				)

				(local.get $__ref_tmp)
		))
		(table.set $wat4wasm<ext> (i32.const 14)
			(block (result externref)
				(local.set $__ref_tmp (global.get $self))

				(local.set $__ref_tmp
					(call $self.Reflect.get<ref.ref>ref
						(local.get $__ref_tmp)
						(string "Uint8Array")
					)
				)

				(local.set $__ref_tmp
					(call $self.Reflect.get<ref.ref>ref
						(local.get $__ref_tmp)
						(string "__proto__")
					)
				)

				(local.set $__ref_tmp
					(call $self.Reflect.get<ref.ref>ref
						(local.get $__ref_tmp)
						(string "prototype")
					)
				)

				(local.set $__ref_tmp
					(call $self.Reflect.get<ref.ref>ref
						(local.get $__ref_tmp)
						(string "set")
					)
				)

				(local.get $__ref_tmp)
		))
		(table.set $wat4wasm<ext> (i32.const 15)
			(block (result externref)
				(local.set $__ref_tmp (global.get $self))

				(local.set $__ref_tmp
					(call $self.Reflect.get<ref.ref>ref
						(local.get $__ref_tmp)
						(string "console")
					)
				)

				(local.set $__ref_tmp
					(call $self.Reflect.get<ref.ref>ref
						(local.get $__ref_tmp)
						(string "log")
					)
				)

				(local.get $__ref_tmp)
		))
		(table.set $wat4wasm<ext> (i32.const 16)
			(block (result externref)
				(local.set $__ref_tmp (global.get $self))

				(local.set $__ref_tmp
					(call $self.Reflect.get<ref.ref>ref
						(local.get $__ref_tmp)
						(string "alert")
					)
				)

				(local.get $__ref_tmp)
		))

	)
	(start $__wat4wasm_bootstrap)

)