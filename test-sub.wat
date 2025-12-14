    (func $test-sub

    )

    (func $main-2
    ;; Bellekten okunan (Hızlı)
    (call $log (text "Merhaba Dünya"))

    ;; Runtime oluşturulan (Yavaş ama Dinamik)
    (call $alert (string "alert"))
    (call $alert (string "alert"))
    (call $alert (string "özgür"))

    ;; Örnek 1: Getter'ın kendisine erişim (/get)
    ;; self.ArrayBuffer.prototype.byteLength descriptor'ından "get" fonksiyonunu çeker.
    (call $log (ref.extern $self.ArrayBuffer.prototype.byteLength/get))
    
    ;; Örnek 2: Prototype kısayolu (:)
    ;; self.WebAssembly.Memory.prototype.grow haline gelir.
    (call $log (ref.extern $self.WebAssembly.Memory:grow))

    ;; Örnek 3: TypedArray ve Prototype birleşimi
    ;; self.Uint8Array.__proto__.prototype.set haline gelir (veya TypedArray globaline bağlı)
    ;; Not: TypedArray soyut bir sınıf olduğu için doğrudan globalde olmayabilir,
    ;; bu yüzden __proto__ değişimi yaptın, harika oldu.
    (call $log (ref.extern $self.TypedArray:set))

    ;; 2. Array kullanımı (Inline Tip ile)
    (call $log 
        (array (param i32 i32) 
            (i32.const 10) 
            (i32.const 20)
        )
        (array)
    )

    ;; 3. Array kullanımı (Sanal Tip ile)
    ;; Burada (text) kullandık, string'e inat :)
    (call $log 
        (array (type $pointArgs)
            (i32.const 100)
            (i32.const 200)
            (text "millete_string_yerine_text_kullanımını_özendirelim_aşkım")
        )
    )
  )


  (type $pointArgs (param i32 i32 externref))