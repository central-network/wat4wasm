(module
    (include "./test-sub.wat")

    (global $self.screen.width f32)
    (global $self.Math externref)
    (global $self.Math.max externref)
    (global $self.location.origin externref)
    (global $self.console.warn externref)
    (global $self.MessageEvent.prototype.data/get externref)
    (global $self.Worker:onmessage/set externref)

    (global $ANY_TEXT_GLOBAL "any text 
        \\"masked\\"
    global")

    (memory 10 10 shared)

    (func $test
        (local $arg0 i32)
        
        (local.set 0 (text "Bu bir
            çoklu satır örneğidir.
            İçinde \"escaped\" tırnaklar var."))

        (local.set 0 i32(24))


        this
        (warn<i32>)

        self
        (warn<ref>)

        null
        (warn<ref>)


        ;; construct
        (new $self.Worker<refx2>ref
            (text "worker.js")
            (call $self.Object.fromEntries<ref>ref
                (call $self.Array<ref>ref
                    (call $self.Array.of<refx2>ref
                        (text "name")
                        (text "özgür")
                    )
                )
            )
        )        
        (warn<ref>)

        (get <refx2>ref self (text "origin"))        
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

    (global $self.navigator.hardwareConcurrency i32)

    (on $message
        (param $event externref)
        (log<ref> this)
        (log<ref> (text "hello özgür"))
    )

    (start $main

        (log<ref> (text "interal text converted to table.get!"))
        (log<ref> (global.get $self.location.origin))
        (log<f32> (global.get $self.screen.width))
        (log<ref> (global.get $self.MessageEvent.prototype.data/get))
        (log<ref> (global.get $self.Worker:onmessage/set))
        (warn<ref> (global.get $ANY_TEXT_GLOBAL))

        (apply 
            (type $mySig)                    ;; 1. Signature (Görmezden gelinecek)
            (ref.extern $self.console.log)   ;; 2. Target
            (global.get $self)               ;; 3. This
            (array (param externref)         ;; 4. Args (Array)
                (text "Standart görünüm harika!")
            )
        )

        ;; KULLANIM 2: Inline Param ile
        (apply 
            (param funcref externref externref) ;; 1. Signature (Görmezden gelinecek)
            (ref.extern $self.alert)            ;; 2. Target
            (null)                              ;; 3. This
            (array (param i32)                  ;; 4. Args
            (i32.const 123)
            )
        )

        (call $self.requestAnimationFrame<fun>
            (func $inlinefunction<f32>
                (param $performance.now f32)

                (log<ref.f32>
                    (text "animation frame ready:") 
                    (local.get $performance.now)
                )
            )
        )
    )

    (type $mySig (param externref externref externref))   
)