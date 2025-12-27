(module
    (import "console" "log"         (func $log (param externref))) ;; demo only

    (import "Reflect" "construct"   (func $self.Reflect.construct<ext.ext>ext (param externref externref) (result externref)))
    (import "Reflect" "get"         (func $self.Reflect.get<ext.ext>ext (param externref externref) (result externref) ))
    (import "Reflect" "set"         (func $self.Reflect.set<ext.i32.i32> (param externref i32 i32)))
    (import "Reflect" "apply"       (func $self.Reflect.apply<ext.ext.ext>ext (param externref externref externref) (result externref)))
    (import "Array" "of"            (func $self.Array.of<ext>ext (param externref) (result externref)))
    (import "self" "self"           (global $self externref))
    (import "String" "fromCharCode" (global $self.String.fromCharCode externref))

    (memory 1)
    (func $wat4wasm
        (local $TextDecoder externref)
        (local $decode      externref)
        (local $arguments   externref)
        (local $Uint8Array  externref)
        (local $view        externref)
        (local $buffer      externref)
        (local $byteLength  i32)

        (block $perpare
            (local.set $byteLength (i32.const 66))

            (block $TextDecoder
                (local.set $arguments (call $self.Array.of<ext>ext (ref.null extern)))

                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  0) (i32.const  84))
                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  1) (i32.const 101))
                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  2) (i32.const 120))
                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  3) (i32.const 116))
                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  4) (i32.const  68))
                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  5) (i32.const 101))
                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  6) (i32.const  99))
                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  7) (i32.const 111))
                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  8) (i32.const 100))
                (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const  9) (i32.const 101))
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

        (block $testDecoding ;; offset: 0, length: 7, text: "özgür"

            (local.set $arguments (call $self.Array.of<ext>ext (local.get $buffer)))
            (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 1) (i32.const 0))
            (call $self.Reflect.set<ext.i32.i32> (local.get $arguments) (i32.const 2) (i32.const 7))

            (call $self.Reflect.apply<ext.ext.ext>ext
                (local.get $decode)
                (local.get $TextDecoder)
                (call $self.Array.of<ext>ext 
                    (call $self.Reflect.construct<ext.ext>ext 
                        (local.get $Uint8Array) (local.get $arguments)
                    )
                )
            )
            
            (call $log)
        )
    )

    (data  $wat4wasm "\c3\b6\7a\67\c3\bc\72\41\72\72\61\79\42\75\66\66\65\72\70\72\6f\74\6f\74\79\70\65\62\79\74\65\4c\65\6e\67\74\68\67\65\74\67\72\6f\77\61\62\6c\65\73\65\74\69\73\41\72\72\61\79\70\75\73\68\73\70\6c\69\63\65\47\50\55\41\64\61\70\74\65\72\72\65\71\75\65\73\74\44\65\76\69\63\65")

    (start $wat4wasm)
)