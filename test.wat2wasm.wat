(module
    
    (import "self" "Array"              (func $wat2wasm/Array<>ref (param) (result externref)))
    (import "Reflect" "set"             (func $wat2wasm/Reflect.set<ref.i32x2> (param externref i32 i32) (result)))
    (import "Reflect" "apply"           (func $wat2wasm/Reflect.apply<refx3>ref (param externref externref externref) (result externref)))
    (import "self" "self"               (global $wat2wasm/self externref))
    (import "String" "fromCharCode"     (global $wat2wasm/String.fromCharCode externref))
    (import "console" "log" (func $console.log (param externref)))

    (func $test-sub

    )

    (start $main) (func $main
        
        (memory.init 0 $wat2wasm/text (i32.const 0) (i32.const 0) (i32.const 24))    
    
        (table.set $extern (i32.const 1) (call $wat2wasm/text (i32.const 0) (i32.const 24)))    
    
        
        ;;(memory.fill (i32.const 0) (i32.const 0) (i32.const 24))
        (data.drop $wat2wasm/text)    
     
        (call $console.log
            (table.get $extern (i32.const 1))
        )
    )

    (table $extern 2 2 externref)

    (memory $wat2wasm/text 1 1)
    
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
                (i32.sub (local.get $length) (i32.const 2))
            )
                
            (call $wat2wasm/Reflect.set<ref.i32x2>
                (local.get $array)
                (i32.div_u (local.get $length) (i32.const 2))
                (i32.sub 
                    (i32.load16_u 
                        (i32.add 
                            (local.get $offset)
                            (local.get $length)
                        )
                    )
                    (i32.const 1000)
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

    (data $wat2wasm/text "\50\04\4d\04\54\04\54\04\57\04\08\04\5f\04\57\04\5a\04\54\04\4c\04\09\04")
)