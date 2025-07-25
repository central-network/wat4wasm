(module
    ;;BEGIN_OF_IMPORTS
    (import "self" "Array"              (func $wat2wasm/Array<>ref (param) (result externref)))
    (import "Reflect" "set"             (func $wat2wasm/Reflect.set<ref.i32x2> (param externref i32 i32) (result)))
    (import "Reflect" "getOwnPropertyDescriptor" (func $wat2wasm/Reflect.getOwnPropertyDescriptor<refx2>ref (param externref externref) (result externref)))
    (import "Reflect" "get"             (func $wat2wasm/Reflect.get<refx2>ref (param externref externref) (result externref)))
    (import "Reflect" "get"             (func $wat2wasm/Reflect.get<refx2>i32 (param externref externref) (result i32)))
    (import "Reflect" "get"             (func $wat2wasm/Reflect.get<refx2>f32 (param externref externref) (result f32)))
    (import "Reflect" "get"             (func $wat2wasm/Reflect.get<refx2>i64 (param externref externref) (result i64)))
    (import "Reflect" "get"             (func $wat2wasm/Reflect.get<refx2>f64 (param externref externref) (result f64)))
    (import "Reflect" "apply"           (func $wat2wasm/Reflect.apply<refx3>ref (param externref externref externref) (result externref)))
    (import "self" "self"               (global $wat2wasm/self externref))
    (import "String" "fromCharCode"     (global $wat2wasm/String.fromCharCode externref))
   
	(import "console" "warn" (func $self.console.warn<i32> (param i32)))
	(import "console" "warn" (func $self.console.warn<ref> (param externref)))
	(import "Reflect" "construct" (func $self.Reflect.construct<refx2>ref (param externref externref) (result externref)))
	(import "Array" "of" (func $self.Array.of<refx2>ref (param externref externref) (result externref)))
	(import "Object" "fromEntries" (func $self.Object.fromEntries<ref>ref (param externref) (result externref)))
	(import "Array" "of" (func $self.Array.of<ref>ref (param externref) (result externref)))
	(import "console" "log" (func $self.console.log<ref.f32> (param externref f32)))
	(import "console" "log" (func $self.console.log<ref> (param externref)))
	(import "console" "log" (func $self.console.log<f32> (param f32)))
	(import "Reflect" "apply" (func $self.Reflect.apply<refx3>i32 (param externref externref externref) (result i32)))
	(import "Array" "of" (func $self.Array.of<i32x3.f32>ref (param i32 i32 i32 f32) (result externref)))
	(import "console" "error" (func $self.console.error<i32> (param i32)))
	(import "Reflect" "apply" (func $self.Reflect.apply<refx3>f32 (param externref externref externref) (result f32)))
	(import "Array" "of" (func $self.Array.of<>ref  (result externref)))
	(import "console" "error" (func $self.console.error<f32> (param f32)))
	(import "Math" "random" (func $self.Math.random<>f32  (result f32)))
	(import "console" "warn" (func $self.console.warn<f32> (param f32)))
	(import "Reflect" "apply" (func $self.Reflect.apply<refx3> (param externref externref externref)))
	(import "Reflect" "apply" (func $self.Reflect.apply<refx3>ref (param externref externref externref) (result externref)))
	(import "Array" "of" (func $self.Array.of<i32>ref (param i32) (result externref)))
	(import "Array" "of" (func $self.Array.of<f32>ref (param f32) (result externref)))
	(import "self" "requestAnimationFrame" (func $self.requestAnimationFrame<fun> (param funcref)))
	 ;;END_OF_IMPORTS
    
    (func $test-sub

    )

    (global $self.screen.width (mut f32) (f32.const 0))
    (global $self.Math (mut externref) ref.null extern)
    (global $self.Math.max (mut externref) ref.null extern)
    (global $self.location.origin (mut externref) ref.null extern)
    (global $self.console.warn (mut externref) ref.null extern)
    (global $self.MessageEvent.prototype.data/get (mut externref) ref.null extern)
    (global $self.Worker:onmessage/set (mut externref) ref.null extern)

    (global $ANY_TEXT_GLOBAL (mut externref) ref.null extern)

    (memory 10 10 shared)

    (func $test
        (local $arg0 i32)

        (local.set 0 (i32.const 24))


        (local.get 0)
        (call $self.console.warn<i32>)

        (global.get $wat2wasm/self)
        (call $self.console.warn<ref>)

        (ref.null extern)
        (call $self.console.warn<ref>)


        ;; construct
        (call $self.Reflect.construct<refx2>ref 
            (global.get $self.Worker) 
            (call $self.Array.of<refx2>ref 
            (table.get $extern (i32.const 1))
            (call $self.Object.fromEntries<ref>ref
                (call $self.Array.of<ref>ref
                    (call $self.Array.of<refx2>ref
                        (table.get $extern (i32.const 2))
                        (table.get $extern (i32.const 3))
                    )
                )
            )
        ))        
        (call $self.console.warn<ref>)

        
    )

    (start $main) (func $inlinefunction<f32>
                (param $performance.now f32)

                (call $self.console.log<ref.f32>
                    (table.get $extern (i32.const 4)) 
                    (local.get $performance.now)
                )
            )(func $main
        
        (memory.init 0 $wat2wasm/text (i32.const 0) (i32.const 0) (i32.const 808))    
    
        (table.set $extern (i32.const 1) (call $wat2wasm/text (i32.const 0) (i32.const 36)))
		(table.set $extern (i32.const 2) (call $wat2wasm/text (i32.const 36) (i32.const 16)))
		(table.set $extern (i32.const 3) (call $wat2wasm/text (i32.const 52) (i32.const 20)))
		(table.set $extern (i32.const 4) (call $wat2wasm/text (i32.const 72) (i32.const 88)))
		(table.set $extern (i32.const 5) (call $wat2wasm/text (i32.const 160) (i32.const 144)))
		(table.set $extern (i32.const 6) (call $wat2wasm/text (i32.const 304) (i32.const 24)))
		(table.set $extern (i32.const 7) (call $wat2wasm/text (i32.const 328) (i32.const 20)))
		(table.set $extern (i32.const 8) (call $wat2wasm/text (i32.const 348) (i32.const 16)))
		(table.set $extern (i32.const 9) (call $wat2wasm/text (i32.const 364) (i32.const 12)))
		(table.set $extern (i32.const 10) (call $wat2wasm/text (i32.const 376) (i32.const 32)))
		(table.set $extern (i32.const 11) (call $wat2wasm/text (i32.const 408) (i32.const 24)))
		(table.set $extern (i32.const 12) (call $wat2wasm/text (i32.const 432) (i32.const 28)))
		(table.set $extern (i32.const 13) (call $wat2wasm/text (i32.const 460) (i32.const 16)))
		(table.set $extern (i32.const 14) (call $wat2wasm/text (i32.const 476) (i32.const 48)))
		(table.set $extern (i32.const 15) (call $wat2wasm/text (i32.const 524) (i32.const 36)))
		(table.set $extern (i32.const 16) (call $wat2wasm/text (i32.const 560) (i32.const 16)))
		(table.set $extern (i32.const 17) (call $wat2wasm/text (i32.const 576) (i32.const 12)))
		(table.set $extern (i32.const 18) (call $wat2wasm/text (i32.const 588) (i32.const 24)))
		(table.set $extern (i32.const 19) (call $wat2wasm/text (i32.const 612) (i32.const 36)))
		(table.set $extern (i32.const 20) (call $wat2wasm/text (i32.const 648) (i32.const 12)))
		(table.set $extern (i32.const 21) (call $wat2wasm/text (i32.const 660) (i32.const 40)))
		(table.set $extern (i32.const 22) (call $wat2wasm/text (i32.const 700) (i32.const 24)))
		(table.set $extern (i32.const 23) (call $wat2wasm/text (i32.const 724) (i32.const 24)))
		(table.set $extern (i32.const 24) (call $wat2wasm/text (i32.const 748) (i32.const 60)))    
    
        
        (memory.fill (i32.const 0) (i32.const 0) (i32.const 808))
        (data.drop $wat2wasm/text)    
    
        (global.set $ANY_TEXT_GLOBAL (table.get $extern (i32.const 24)))    
    
        
        (global.set $self.screen.width
            (call $wat2wasm/Reflect.get<refx2>f32
                (call $wat2wasm/Reflect.get<refx2>ref 
                        (global.get $wat2wasm/self) 
                        (table.get $extern (i32.const 6)) 
                    )
                (table.get $extern (i32.const 7)) 
            )
        )
        
        (global.set $self.Math
            (call $wat2wasm/Reflect.get<refx2>ref
                (global.get $wat2wasm/self)
                (table.get $extern (i32.const 8)) 
            )
        )
        
        (global.set $self.Math.max
            (call $wat2wasm/Reflect.get<refx2>ref
                (call $wat2wasm/Reflect.get<refx2>ref 
                        (global.get $wat2wasm/self) 
                        (table.get $extern (i32.const 8)) 
                    )
                (table.get $extern (i32.const 9)) 
            )
        )
        
        (global.set $self.location.origin
            (call $wat2wasm/Reflect.get<refx2>ref
                (call $wat2wasm/Reflect.get<refx2>ref 
                        (global.get $wat2wasm/self) 
                        (table.get $extern (i32.const 10)) 
                    )
                (table.get $extern (i32.const 11)) 
            )
        )
        
        (global.set $self.console.warn
            (call $wat2wasm/Reflect.get<refx2>ref
                (call $wat2wasm/Reflect.get<refx2>ref 
                        (global.get $wat2wasm/self) 
                        (table.get $extern (i32.const 12)) 
                    )
                (table.get $extern (i32.const 13)) 
            )
        )
        
        (global.set $self.MessageEvent.prototype.data/get
            (call $wat2wasm/Reflect.get<refx2>ref
                (call $wat2wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat2wasm/Reflect.get<refx2>ref 
                            (call $wat2wasm/Reflect.get<refx2>ref 
                                (global.get $wat2wasm/self) 
                                (table.get $extern (i32.const 14)) 
                            ) 
                            (table.get $extern (i32.const 15)) 
                        )
                    (table.get $extern (i32.const 16)) 
                )
                (table.get $extern (i32.const 17)) 
            )
        )
        
        (global.set $self.Worker:onmessage/set
            (call $wat2wasm/Reflect.get<refx2>ref
                (call $wat2wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat2wasm/Reflect.get<refx2>ref 
                            (call $wat2wasm/Reflect.get<refx2>ref 
                                (global.get $wat2wasm/self) 
                                (table.get $extern (i32.const 18)) 
                            ) 
                            (table.get $extern (i32.const 15)) 
                        )
                    (table.get $extern (i32.const 19)) 
                )
                (table.get $extern (i32.const 20)) 
            )
        )
        
        (global.set $self.Worker
            (call $wat2wasm/Reflect.get<refx2>ref
                (global.get $wat2wasm/self)
                (table.get $extern (i32.const 18)) 
            )
        )
        
        (global.set $self.Uint8Array
            (call $wat2wasm/Reflect.get<refx2>ref
                (global.get $wat2wasm/self)
                (table.get $extern (i32.const 21)) 
            )
        )
        
        (global.set $self.Number
            (call $wat2wasm/Reflect.get<refx2>ref
                (global.get $wat2wasm/self)
                (table.get $extern (i32.const 22)) 
            )
        )
        
        (global.set $self.Math.random
            (call $wat2wasm/Reflect.get<refx2>ref
                (call $wat2wasm/Reflect.get<refx2>ref 
                        (global.get $wat2wasm/self) 
                        (table.get $extern (i32.const 8)) 
                    )
                (table.get $extern (i32.const 23)) 
            )
        )
            
     

        (call $self.console.log<ref> (table.get $extern (i32.const 5)))
        (call $self.console.log<ref> (global.get $self.location.origin))
        (call $self.console.log<f32> (global.get $self.screen.width))
        (call $self.console.log<ref> (global.get $self.MessageEvent.prototype.data/get))
        (call $self.console.log<ref> (global.get $self.Worker:onmessage/set))
        (call $self.console.warn<ref> (global.get $ANY_TEXT_GLOBAL))


        (call $self.Reflect.apply<refx3>i32 
            (global.get $self.Math.max) 
            (global.get $wat2wasm/self)
            (call $self.Array.of<i32x3.f32>ref
                (i32.const 2)
                (i32.const 4)
                (i32.const 5)
                (f32.const 1122.2)
            )
        )
        (call $self.console.error<i32>)

        (call $self.Reflect.apply<refx3>f32 
            (global.get $self.Math.random) (global.get $wat2wasm/self) (call $self.Array.of<>ref))
        (call $self.console.error<f32>)

        (call $self.Math.random<>f32)
        (call $self.console.warn<f32>)

        (call $self.Reflect.apply<refx3> 
            (global.get $self.Math.random) (global.get $wat2wasm/self) (call $self.Array.of<>ref))
        (nop)

        (call $self.Reflect.apply<refx3>ref 
            (global.get $self.Math.random) (global.get $wat2wasm/self) (call $self.Array.of<>ref))
        (drop)

        (call $self.Reflect.construct<refx2>ref 
            (global.get $self.Uint8Array)  
            (call $self.Array.of<i32>ref
                (i32.const 3)
            )
        )
        (call $self.console.warn<ref>)

        (call $self.Reflect.construct<refx2>ref 
            (global.get $self.Uint8Array) 
            (call $self.Array.of<i32>ref  (i32.const 4)))
        (call $self.console.warn<ref>)

        (call $self.Reflect.construct<refx2>ref 
            (global.get $self.Number) 
            (call $self.Array.of<f32>ref  (f32.const 4.4)))
        (call $self.console.warn<ref>)


        (call $test)


        (call $self.requestAnimationFrame<fun>
            (ref.func $inlinefunction<f32>)
        )
    )

	(global $self.Worker (mut externref) ref.null extern)
	(global $self.Uint8Array (mut externref) ref.null extern)
	(global $self.Number (mut externref) ref.null extern)

	(global $self.Math.random (mut externref) ref.null extern)

	(elem $wat2wasm/refs funcref (ref.func $inlinefunction<f32>))

    (table $extern 25 25 externref)

    (func $wat2wasm/text 
        (param $offset i32)
        (param $length i32)
        (result externref)
        (local $array externref)

        (if (i32.eqz (local.get $length))
            (then (return (ref.null extern)))
        )

        (local.set $array 
            (call $wat2wasm/Array<>ref)
        )

        (loop $length--
            (local.set $length
                (i32.sub (local.get $length) (i32.const 4))
            )
                
            (call $wat2wasm/Reflect.set<ref.i32x2>
                (local.get $array)
                (i32.div_u (local.get $length) (i32.const 4))
                (i32.trunc_f32_u	
                    (f32.load 
                        (i32.add 
                            (local.get $offset)
                            (local.get $length)
                        )
                    )
                )
            )

            (br_if $length-- (local.get $length))
        )

        (call $wat2wasm/Reflect.apply<refx3>ref
            (global.get $wat2wasm/String.fromCharCode)
            (ref.null extern)
            (local.get $array)
        )
    )

    (data $wat2wasm/text "\00\00\ee\42\00\00\de\42\00\00\e4\42\00\00\d6\42\00\00\ca\42\00\00\e4\42\00\00\38\42\00\00\d4\42\00\00\e6\42\00\00\dc\42\00\00\c2\42\00\00\da\42\00\00\ca\42\00\00\76\43\00\00\f4\42\00\00\ce\42\00\00\7c\43\00\00\e4\42\00\00\c2\42\00\00\dc\42\00\00\d2\42\00\00\da\42\00\00\c2\42\00\00\e8\42\00\00\d2\42\00\00\de\42\00\00\dc\42\00\00\00\42\00\00\cc\42\00\00\e4\42\00\00\c2\42\00\00\da\42\00\00\ca\42\00\00\00\42\00\00\e4\42\00\00\ca\42\00\00\c2\42\00\00\c8\42\00\00\f2\42\00\00\68\42\00\00\d2\42\00\00\dc\42\00\00\e8\42\00\00\ca\42\00\00\e4\42\00\00\c2\42\00\00\d8\42\00\00\00\42\00\00\e8\42\00\00\ca\42\00\00\f0\42\00\00\e8\42\00\00\00\42\00\00\c6\42\00\00\de\42\00\00\dc\42\00\00\ec\42\00\00\ca\42\00\00\e4\42\00\00\e8\42\00\00\ca\42\00\00\c8\42\00\00\00\42\00\00\e8\42\00\00\de\42\00\00\00\42\00\00\e8\42\00\00\c2\42\00\00\c4\42\00\00\d8\42\00\00\ca\42\00\00\38\42\00\00\ce\42\00\00\ca\42\00\00\e8\42\00\00\04\42\00\00\e6\42\00\00\c6\42\00\00\e4\42\00\00\ca\42\00\00\ca\42\00\00\dc\42\00\00\ee\42\00\00\d2\42\00\00\c8\42\00\00\e8\42\00\00\d0\42\00\00\9a\42\00\00\c2\42\00\00\e8\42\00\00\d0\42\00\00\da\42\00\00\c2\42\00\00\f0\42\00\00\d8\42\00\00\de\42\00\00\c6\42\00\00\c2\42\00\00\e8\42\00\00\d2\42\00\00\de\42\00\00\dc\42\00\00\de\42\00\00\e4\42\00\00\d2\42\00\00\ce\42\00\00\d2\42\00\00\dc\42\00\00\c6\42\00\00\de\42\00\00\dc\42\00\00\e6\42\00\00\de\42\00\00\d8\42\00\00\ca\42\00\00\ee\42\00\00\c2\42\00\00\e4\42\00\00\dc\42\00\00\9a\42\00\00\ca\42\00\00\e6\42\00\00\e6\42\00\00\c2\42\00\00\ce\42\00\00\ca\42\00\00\8a\42\00\00\ec\42\00\00\ca\42\00\00\dc\42\00\00\e8\42\00\00\e0\42\00\00\e4\42\00\00\de\42\00\00\e8\42\00\00\de\42\00\00\e8\42\00\00\f2\42\00\00\e0\42\00\00\ca\42\00\00\c8\42\00\00\c2\42\00\00\e8\42\00\00\c2\42\00\00\ce\42\00\00\ca\42\00\00\e8\42\00\00\ae\42\00\00\de\42\00\00\e4\42\00\00\d6\42\00\00\ca\42\00\00\e4\42\00\00\de\42\00\00\dc\42\00\00\da\42\00\00\ca\42\00\00\e6\42\00\00\e6\42\00\00\c2\42\00\00\ce\42\00\00\ca\42\00\00\e6\42\00\00\ca\42\00\00\e8\42\00\00\aa\42\00\00\d2\42\00\00\dc\42\00\00\e8\42\00\00\60\42\00\00\82\42\00\00\e4\42\00\00\e4\42\00\00\c2\42\00\00\f2\42\00\00\9c\42\00\00\ea\42\00\00\da\42\00\00\c4\42\00\00\ca\42\00\00\e4\42\00\00\e4\42\00\00\c2\42\00\00\dc\42\00\00\c8\42\00\00\de\42\00\00\da\42\00\00\c2\42\00\00\dc\42\00\00\f2\42\00\00\00\42\00\00\e8\42\00\00\ca\42\00\00\f0\42\00\00\e8\42\00\00\00\42\00\00\ce\42\00\00\d8\42\00\00\de\42\00\00\c4\42\00\00\c2\42\00\00\d8\42")
)