    
    (type $pointArgs (param i32 i32 externref))
    
    (func $test-sub

    )

    (func $main-2
        ;; 3. Array kullanımı (Sanal Tip ile)
        ;; Burada (text) kullandık, stringe inat :)
        (call_direct $console.log
            (param externref) 
            (array 
                (type $pointArgs)
                (i32.const 100)
                (i32.const 200)
                (text "millet_yerine_text_kullanımını_özendirelim_aşkım")
            )
        )
  )