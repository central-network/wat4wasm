(module
    (func $main

        ;; {ref_extern $self.x} :
        (ref.extern $self.x) 
        (drop)
        
        ;; {i32_extern $self.x} :
        (i32.extern $self.x) 
        (drop)

        ;; {global_get $self.x} :
        (global.get $self.x) 
        (drop)
        
        ;; {global_get $self.x f32} :
        (global.get $self.x f32) 
        (drop)
        
        ;; {global_get $self.y} :
        (global.get $self.y) 
        (drop)

        ;; [self_get $TypedArray:slice]
        (self.get $TypedArray:slice)
        (drop)

        ;; [self_get $navigation.activation.entry.index i32]
        (self.get $navigation.activation.entry.index i32)
        (drop)

        ;; [self_set $navigation.activation.entry.index [text "2"]]
        (self.set $navigation.activation.entry.index (text "2"))

        ;; [self_set $navigation.activation.entry.index [text "2"] i32]
        (self.set $navigation.activation.entry.index (text "2") i32)

        ;; [self_set $navigation.activation.entry.index i32 [i32.const 2] i32]
        (self.set $navigation.activation.entry.index i32 (i32.const 2))

        ;; [self_set $navigation.activation.entry.index fun [...nested block..]]
        (self.set $navigation.activation.entry.index fun 
            (call $any_inner_nested_block
                (result funcref)
                (ref.func $main)
            )
        )


        ;; [self_has $navigation.activation.entry [text "index"]]
        (self.has $navigation.activation.entry (text "index"))

        ;; [self_has $navigation.activation.entry [text "index"] f32]
        (self.has $navigation.activation.entry (text "index") f32)


        ;; [self_new $WebSocket [text "http://url"] ext]
        (self.new $WebSocket (text "http://url") ext)

        ;; [self_new $WebSocket [text "http://url"]]
        (self.new $WebSocket (text "http://url"))

        ;; [self_new $WebSocket ext [text "http://url"] ext]
        (self.new $WebSocket (text "http://url") ext)

        ;; [self_new $WebSocket ext [text "http://url"]]
        (self.new $WebSocket 
            (param ext i32 fun)
            (result ext)

            (array 
                (param ext ext fun i32)
                (result ext)

                (text "http://url")
                (ref.extern $self.location.pathName)
                (ref.func $main)
                (i32.const 2)
            )
            (i32.const 2)
            (ref.func $main)
        )
    )
)