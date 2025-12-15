(module
    (include "./test-sub.wat")
    (memory 10 10 shared)

    (func $test
        (local $arguments externref)
        (local.set $arguments (array))        
        
        (text "Bu bir çoklu satir örneğidir.
            içinde de \"maske\" kelime var."
        )

        (new 
            (param externref externref)
            (result externref)

            (ref.extern $self.WebSocket)
            (local.get $arguments)
        )

        (get 
            (param externref i32)
            (result externref) 
            
            (local.get $arguments)
            (i32.const 0)
        )

        (set 
            (param externref i32 i32)
            (result)
            
            (local.get $arguments)
            (i32.const 0)
            (memory.size)
        )

        (call_direct $self.Math.atan
            (param f32 f64)
            (result f32)

            (call_direct $Math.random (result f32))
            (call_direct $Date.now (result f64))
        )

        (call_direct $self.Math.max
            (param f32 f32)
            (result f32)

            (call_direct $Date.now (result f32))
            (call_bound $performance.now (result f32))
        )

        (call_direct $self.requestAnimationFrame
            (param funcref)
            (result i32)
            (ref.func $onanimationframe)
        )
    )

    (func $main
        (call_direct $self.console.log
            (text "interal text converted to table.get!")
        )

        (apply 
            (type $mySig)                    
            (ref.extern $self.console.log)   ;; 2. Target
            (global.get $self)               ;; 3. This
            (array 
                (param externref)            ;; 4. Args (Array)
                (text "Standart görünüm harika!")
            )
        )

        (apply
            ;; Varsayılan Signature: 
            ;; (param externref externref externref) 
            ;; (result)
            (ref.extern $self.console.log)       
            (global.get $self)               
            (array 
                (param externref)        
                (text "Standart görünüm harika!")
            )
        )

        ;; KULLANIM 2: Inline Param ile
        (apply 
            (param funcref externref externref) ;; 1. Signature (Görmezden gelinecek)
            (result i32)
            
            (ref.extern $self.alert)            ;; 2. Target
            (null)                              ;; 3. This
            (array (param i32)                  ;; 4. Args
                (i32.const 123)
            )
        )

        (call_direct $self.requestAnimationFrame
            (param funcref)
            (result i32)
            (ref.func $inlinefunction<f32>)
        )
    )
    
    (func $inlinefunction<f32>
        (param $performance.now f32)

        (call_direct $self.console.log
            (param externref i32)

            (text "animation frame ready:") 
            (call_bound $performance.now (result f32))
        )
    )

    (start $main)

    (type $mySig (param externref externref externref) (result i64))   
)