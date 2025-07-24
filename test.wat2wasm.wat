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
   
	(import "console" "log" (func $self.console.log<ref> (param externref)))
	(import "console" "log" (func $self.console.log<f32> (param f32)))
	(import "console" "error" (func $self.console.error<ref> (param externref)))
	(import "Array" "of" (func $self.Array.of<i32x3.f32>ref (param i32 i32 i32 f32) (result externref)))
	 ;;END_OF_IMPORTS
    
    (func $test-sub

    )

    (global $self.screen.width (mut f32) (f32.const 0))
    (global $self.location.origin (mut externref) ref.null extern)
    (global $self.MessageEvent.prototype.data/get (mut externref) ref.null extern)
    (global $self.Worker:onmessage/set (mut externref) ref.null extern)

    (global $ANY_TEXT_GLOBAL (mut externref) ref.null extern)

    (memory 10 10 shared)

    (start $main) (func $main
        
        (memory.init 0 $wat2wasm/text (i32.const 0) (i32.const 0) (i32.const 488))    
    
        (table.set $extern (i32.const 1) (call $wat2wasm/text (i32.const 0) (i32.const 144)))
		(table.set $extern (i32.const 2) (call $wat2wasm/text (i32.const 144) (i32.const 24)))
		(table.set $extern (i32.const 3) (call $wat2wasm/text (i32.const 168) (i32.const 20)))
		(table.set $extern (i32.const 4) (call $wat2wasm/text (i32.const 188) (i32.const 32)))
		(table.set $extern (i32.const 5) (call $wat2wasm/text (i32.const 220) (i32.const 24)))
		(table.set $extern (i32.const 6) (call $wat2wasm/text (i32.const 244) (i32.const 48)))
		(table.set $extern (i32.const 7) (call $wat2wasm/text (i32.const 292) (i32.const 36)))
		(table.set $extern (i32.const 8) (call $wat2wasm/text (i32.const 328) (i32.const 16)))
		(table.set $extern (i32.const 9) (call $wat2wasm/text (i32.const 344) (i32.const 12)))
		(table.set $extern (i32.const 10) (call $wat2wasm/text (i32.const 356) (i32.const 24)))
		(table.set $extern (i32.const 11) (call $wat2wasm/text (i32.const 380) (i32.const 36)))
		(table.set $extern (i32.const 12) (call $wat2wasm/text (i32.const 416) (i32.const 12)))
		(table.set $extern (i32.const 13) (call $wat2wasm/text (i32.const 428) (i32.const 60)))    
    
        
        (memory.fill (i32.const 0) (i32.const 0) (i32.const 488))
        (data.drop $wat2wasm/text)    
    
        (global.set $ANY_TEXT_GLOBAL (table.get $extern (i32.const 13)))    
    
        
        (global.set $self.screen.width
            (call $wat2wasm/Reflect.get<refx2>f32
                (call $wat2wasm/Reflect.get<refx2>ref 
                        (global.get $wat2wasm/self) 
                        (table.get $extern (i32.const 2)) 
                    )
                (table.get $extern (i32.const 3)) 
            )
        )
        
        (global.set $self.location.origin
            (call $wat2wasm/Reflect.get<refx2>ref
                (call $wat2wasm/Reflect.get<refx2>ref 
                        (global.get $wat2wasm/self) 
                        (table.get $extern (i32.const 4)) 
                    )
                (table.get $extern (i32.const 5)) 
            )
        )
        
        (global.set $self.MessageEvent.prototype.data/get
            (call $wat2wasm/Reflect.get<refx2>ref
                (call $wat2wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat2wasm/Reflect.get<refx2>ref 
                            (call $wat2wasm/Reflect.get<refx2>ref 
                                (global.get $wat2wasm/self) 
                                (table.get $extern (i32.const 6)) 
                            ) 
                            (table.get $extern (i32.const 7)) 
                        )
                    (table.get $extern (i32.const 8)) 
                )
                (table.get $extern (i32.const 9)) 
            )
        )
        
        (global.set $self.Worker:onmessage/set
            (call $wat2wasm/Reflect.get<refx2>ref
                (call $wat2wasm/Reflect.getOwnPropertyDescriptor<refx2>ref
                    (call $wat2wasm/Reflect.get<refx2>ref 
                            (call $wat2wasm/Reflect.get<refx2>ref 
                                (global.get $wat2wasm/self) 
                                (table.get $extern (i32.const 10)) 
                            ) 
                            (table.get $extern (i32.const 7)) 
                        )
                    (table.get $extern (i32.const 11)) 
                )
                (table.get $extern (i32.const 12)) 
            )
        )
            
     
        (call $self.console.log<ref> (table.get $extern (i32.const 1)))
        (call $self.console.log<ref> (global.get $self.location.origin))
        (call $self.console.log<f32> (global.get $self.screen.width))
        (call $self.console.log<ref> (global.get $self.MessageEvent.prototype.data/get))
        (call $self.console.log<ref> (global.get $self.Worker:onmessage/set))
        (call $self.console.log<ref> (global.get $ANY_TEXT_GLOBAL))


        (call $self.console.error<ref>
            (call $self.Array.of<i32x3.f32>ref
                (i32.const 2)
                (i32.const 4)
                (i32.const 5)
                (f32.const 2.2)
            )
        )


    )

    (table $extern 14 14 externref)

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

    (data $wat2wasm/text "\00\00\d2\42\00\00\dc\42\00\00\e8\42\00\00\ca\42\00\00\e4\42\00\00\c2\42\00\00\d8\42\00\00\00\42\00\00\e8\42\00\00\ca\42\00\00\f0\42\00\00\e8\42\00\00\00\42\00\00\c6\42\00\00\de\42\00\00\dc\42\00\00\ec\42\00\00\ca\42\00\00\e4\42\00\00\e8\42\00\00\ca\42\00\00\c8\42\00\00\00\42\00\00\e8\42\00\00\de\42\00\00\00\42\00\00\e8\42\00\00\c2\42\00\00\c4\42\00\00\d8\42\00\00\ca\42\00\00\38\42\00\00\ce\42\00\00\ca\42\00\00\e8\42\00\00\04\42\00\00\e6\42\00\00\c6\42\00\00\e4\42\00\00\ca\42\00\00\ca\42\00\00\dc\42\00\00\ee\42\00\00\d2\42\00\00\c8\42\00\00\e8\42\00\00\d0\42\00\00\d8\42\00\00\de\42\00\00\c6\42\00\00\c2\42\00\00\e8\42\00\00\d2\42\00\00\de\42\00\00\dc\42\00\00\de\42\00\00\e4\42\00\00\d2\42\00\00\ce\42\00\00\d2\42\00\00\dc\42\00\00\9a\42\00\00\ca\42\00\00\e6\42\00\00\e6\42\00\00\c2\42\00\00\ce\42\00\00\ca\42\00\00\8a\42\00\00\ec\42\00\00\ca\42\00\00\dc\42\00\00\e8\42\00\00\e0\42\00\00\e4\42\00\00\de\42\00\00\e8\42\00\00\de\42\00\00\e8\42\00\00\f2\42\00\00\e0\42\00\00\ca\42\00\00\c8\42\00\00\c2\42\00\00\e8\42\00\00\c2\42\00\00\ce\42\00\00\ca\42\00\00\e8\42\00\00\ae\42\00\00\de\42\00\00\e4\42\00\00\d6\42\00\00\ca\42\00\00\e4\42\00\00\de\42\00\00\dc\42\00\00\da\42\00\00\ca\42\00\00\e6\42\00\00\e6\42\00\00\c2\42\00\00\ce\42\00\00\ca\42\00\00\e6\42\00\00\ca\42\00\00\e8\42\00\00\c2\42\00\00\dc\42\00\00\f2\42\00\00\00\42\00\00\e8\42\00\00\ca\42\00\00\f0\42\00\00\e8\42\00\00\00\42\00\00\ce\42\00\00\d8\42\00\00\de\42\00\00\c4\42\00\00\c2\42\00\00\d8\42")
)