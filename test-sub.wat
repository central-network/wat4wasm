
    (func 

        (ref.extern $Navigator:gpu)
        (ref.extern $Navigator:gpu[getter])
        (ref.extern $Navigator:gpu[setter])
        
        (reflect.new

            ;; example usage
            (reflect.new 
                (param ext ext)
                (result ext)

                (ref.extern $self.OffscreenCanvas)
                (array.of 
                    (param i32 i32)
                    (result ext)

                    (i32.const 640)
                    (i32.const 480)
                )
            )

            ;; conversion walk
            (steps
                (step 0 -> converting ref.extern
                     (reflect.new 
                        (param ext ext)
                        (result ext)

                        (table.get $wat4wasm (i32.const O)) ;; self.OffscreenCanvas
                        (array.of 
                            (param i32 i32)
                            (result ext)

                            (i32.const 640)
                            (i32.const 480)
                        )
                    )
                )

                (step 1 -> converting array 
                    (reflect.new 
                        (param ext ext)
                        (result ext)

                        (table.get $wat4wasm (i32.const O)) ;; self.OffscreenCanvas
                        (call $self.Array.of<i32.i32>ext 
                            (i32.const 640) 
                            (i32.const 480)
                        )
                    )
                )

                (step 2 -> Reflecting construct call
                    (call $self.Reflect.construct<ext.ext>ext
                        (table.get $wat4wasm (i32.const O)) ;; self.OffscreenCanvas
                        (call $self.Array.of<i32.i32>ext 
                            (i32.const 640) 
                            (i32.const 480)
                        )
                    )
                )
            )

            ;; replaceWith
            (call $self.Reflect.construct<ext.ext>ext
                (table.get $wat4wasm (i32.const O)) ;; self.OffscreenCanvas
                (call $self.Array.of<i32.i32>ext 
                    (i32.const 640) 
                    (i32.const 480)
                )
            )
        )

        (reflect.get

            ;; example usage
            (reflect.get 
                (param ext ext)
                (result ext)

                (ref.extern $self.location)
                (text "href")
            )

            ;; conversion walk
            (steps
                (step 0 -> converting text item
                    (reflect.get 
                        (param ext ext)
                        (result ext)
                        (ref.extern $self.location)
                        (table.get $wat4wasm (i32.const T)) ;; href
                    )   
                )

                (step 1 -> converting ref.extern
                     (reflect.get 
                        (param ext ext)
                        (result ext)
                        (table.get $wat4wasm (i32.const N)) ;; self.location
                        (table.get $wat4wasm (i32.const T)) ;; href
                    )
                )

                (step 2 -> Reflecting get call
                    (call $self.Reflect.get<ext.ext>ext
                        (table.get $wat4wasm (i32.const N)) ;; self.location
                        (table.get $wat4wasm (i32.const T)) ;; href
                    )
                )
            )

            ;; replaceWith
            (call $self.Reflect.get<ext.ext>ext
                (table.get $wat4wasm (i32.const N)) ;; self.location
                (table.get $wat4wasm (i32.const T)) ;; href
            )
        )

        (reflect.set

            ;; example usage
            (reflect.set 
                (param ext ext)
                (result ext)

                (ref.extern $self.location)
                (text "href")
                (text "http://target")
            )

            ;; conversion walk
            (steps
                (step 0 -> converting texts item
                    (reflect.set 
                        (param ext ext)
                        (result ext)

                        (ref.extern $self.location)
                        (table.get $wat4wasm (i32.const T)) ;; target
                        (table.get $wat4wasm (i32.const H)) ;; href
                    )
                )

                (step 1 -> converting ref.extern
                     (reflect.set 
                        (param ext ext)
                        (result ext)

                        (table.get $wat4wasm (i32.const L)) ;; self.location
                        (table.get $wat4wasm (i32.const T)) ;; target
                        (table.get $wat4wasm (i32.const H)) ;; href
                    )
                )

                (step 2 -> Reflecting set call
                    (call $self.Reflect.set<ext.ext.ext>
                        (table.get $wat4wasm (i32.const L)) ;; self.location
                        (table.get $wat4wasm (i32.const T)) ;; target
                        (table.get $wat4wasm (i32.const H)) ;; href
                    )
                )
            )

            ;; replaceWith
            (call $self.Reflect.set<ext.ext.ext>
                (table.get $wat4wasm (i32.const L)) ;; self.location
                (table.get $wat4wasm (i32.const T)) ;; target
                (table.get $wat4wasm (i32.const H)) ;; href
            )
        )

        (reflect.apply

            ;; example usage
            (reflect.apply 
                (param ext ext ext)
                (result f32)

                (ref.extern $self.Math.floor)
                (ref.extern $self)
                (array.of 
                    (param f32) (result ext)
                    
                    (f32.const 2.1)
                )
            )

            ;; conversion walk
            (steps
                (step 0 -> converting ref.extern
                    (reflect.apply 
                        (param ext ext ext)
                        (result f32)

                        (table.get $wat4wasm (i32.const f)) ;; self.Math.floor
                        (table.get $wat4wasm (i32.const S)) ;; self
                        (array.of 
                            (param f32) (result ext)
                            
                            (f32.const 2.1)
                        )
                    )
                )

                (step 1 -> converting array
                     (reflect.apply 
                        (param ext ext ext)
                        (result f32)

                        (table.get $wat4wasm (i32.const f)) ;; self.Math.floor
                        (table.get $wat4wasm (i32.const S)) ;; self
                        (call $self.Array.of<f32>ext (f32.const 2.1))
                    )
                )

                (step 2 -> Reflecting apply call
                    (call $self.Reflect.apply<ext.ext.ext>f32 
                        (table.get $wat4wasm (i32.const f)) ;; self.Math.floor
                        (table.get $wat4wasm (i32.const S)) ;; self
                        (call $self.Array.of<f32>ext (f32.const 2.1))
                    )
                )
            )

            ;; replaceWith
            (call $self.Reflect.apply<ext.ext.ext>f32 
                (table.get $wat4wasm (i32.const f)) ;; self.Math.floor
                (table.get $wat4wasm (i32.const S)) ;; self
                (call $self.Array.of<f32>ext (f32.const 2.1))
            )
        )

        (self.get

            (self.get $screen.innerHeight i32)
            ;;                             ^
            ;;                      result of getter

            ;; conversion walk
            (steps
                (step 0 ;; converting expanded wat4wasm tags 
                    (reflect.apply 
                        (param ext ext ext)
                        (result i32)

                        (ref.extern $self.screen.__proto__.innerHeight[getter])
                        (ref.extern $self.screen)
                        (array)  
                    )
                )

                (step 1 ;; processing ref.externs to table item
                    (reflect.apply 
                        (param ext ext ext)
                        (result i32)

                        (table.get $wat4wasm (i32.const N))
                        (table.get $wat4wasm (i32.const M))
                        (array)  
                    )
                )

                (step 2 ;; processing array block
                    (reflect.apply 
                        (param ext ext ext)
                        (result i32)

                        (table.get $wat4wasm (i32.const N))
                        (table.get $wat4wasm (i32.const M))
                        (call $self.Array.of<>ext) 
                    )
                )

                (step 3 ;; Reflect apply call
                    (call $self.Reflect.apply<ext.ext.ext>i32 
                        (table.get $wat4wasm (i32.const N))
                        (table.get $wat4wasm (i32.const M))
                        (call $self.Array.of<>ext) 
                    )
                )
            )

            ;; replaceWith
            (call $self.Reflect.apply<ext.ext.ext>i32 
                (table.get $wat4wasm (i32.const N))
                (table.get $wat4wasm (i32.const M))
                (call $self.Array.of<>ext) 
            )
        )

        (self.set
        
            (self.set $location.href ext (text "http://target"))
            ;;                        ^
            ;;                param for Array.of

            ;; conversion walk
            (steps
                (step 0 ;; converting expanded wat4wasm tags 
                    (apply 
                        (param ext ext ext)
                        (result)

                        (ref.extern $self.location.__proto__.href[setter])
                        (ref.extern $self.location)
                        (array.of 
                            (param ext) 
                            (result ext) 
                            
                            (text "myname")
                        )  
                    )
                )

                (step 1 ;; text to table item 
                    (apply 
                        (param ext ext ext)
                        (result)

                        (ref.extern $self.location.__proto__.href[setter])
                        (ref.extern $self.location)
                        (array.of 
                            (param ext) (result ext) 
                            (table.get $wat4wasm (i32.const T))
                        )  
                    )
                )

                (step 2 ;; processing ref.externs to table item
                    (apply 
                        (param ext ext ext)
                        (result)

                        (table.get $wat4wasm (i32.const N))
                        (table.get $wat4wasm (i32.const M))
                        (array.of 
                            (param ext) (result ext) 
                            (table.get $wat4wasm (i32.const T))
                        )  
                    )
                )

                (step 3 ;; processing array block
                    (apply 
                        (param ext ext ext)
                        (result)

                        (table.get $wat4wasm (i32.const N))
                        (table.get $wat4wasm (i32.const M))
                        (call $self.Array.of<ext>ext 
                            (table.get $wat4wasm (i32.const T))
                        ) 
                    )
                )

                (step 4 ;; Reflect apply call
                    (call $self.Reflect.apply<ext.ext.ext> 
                        (table.get $wat4wasm (i32.const N))
                        (table.get $wat4wasm (i32.const M))
                        (call $self.Array.of<ext>ext 
                            (table.get $wat4wasm (i32.const T))
                        ) 
                    )
                )
            )

            ;; replaceWith
            (call $self.Reflect.apply<ext.ext.ext> 
                (table.get $wat4wasm (i32.const N))
                (table.get $wat4wasm (i32.const M))
                (call $self.Array.of<ext>ext 
                    (table.get $wat4wasm (i32.const T))
                ) 
            )
        )

    )
    
    (proposal for (apply ...)
        
        (module
            ;; definitions made at module scope

            (bind $pnow
                (param) (result f32)                ;; signature will be used 
                                                    ;; for arguments (array.of) and 
                                                    ;; type of reflect.apply's return 

                (ref.extern $self.Performance:now)  ;; function argument of reflect.apply
                (ref.extern $self.performance)      ;; this argument of reflect.apply
                (array)
            )

            (bind $mmax
                (param f32 f32) (result f32)

                (ref.extern $self.Math.floor)       ;; function argument of reflect.apply
                (global.get $self)                  ;; this argument of reflect.apply
                (array.of 
                    (param f32 f32) 
                    (result ext)

                    (local.get 0)
                    (local.get 1)
                )
            )

            (bind $post
                (param $this ext) 
                (param $message ext) 
                (result)

                (ref.extern $self.Worker:postMesage)    ;; function argument of reflect.apply
                (local.get 0)                           ;; this argument of reflect.apply
                (array.of 
                    (param ext) 
                    (result ext)

                    (local.get $message)
                )
            )

            ;; example usage without any parameter
            (func $call_and_return_float
                (result f32)
                (apply $pnow)
            )

            ;; example usage with a local parameter and constant
            (func $call_and_find_maximum
                (param f32)
                (result f32)
                (apply $mmax (f32.const 2.2) (local.get 0))
            )

            ;; a regular global which contains a worker thread object 
            (global $worker (mut extern) (ref.null externref))

            ;; detailed example usage with conversion description
            (func $send_message_from_worker
                (param $data ext)
                (result)
                
                (apply $post 
                    (global.get $worker) 
                    (local.get $data)
                )

                (; conversion:
                    
                    1. get a copy of template (bind $post) for (apply $post)
                    2. find parameter values from (apply $post (param N-1) (param N))
                    3. replace template contents by order as (local N) to (param N)
                    4. replace (bind ...) to (reflect.apply ...)
                    5. replace (apply $post) with modified template 
                    6. wat4wasm will handle rest of job

                    - At the last of wat4wasm request will be replaced with:
                    (call $self.Reflect.apply<ext.ext.ext>
                        (table.get $wat4wasm (i32.const [index]))
                        (global.get $worker) 
                        (call $self.Array.of<ext>ext
                            (local.get $data)
                        )
                    )                   
                ;)
            )
        )
    )
