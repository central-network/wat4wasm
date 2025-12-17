
    (func $path:test/sub-folder/test-sub-wat
        (text "özgür")
        (text "özpolat")

        (self.ext $Array)
        (self.ext $ArrayBuffer:byteLength/get)
        (self.ext $ArrayBuffer:growable/set)
        (self.ext $ArrayBuffer:growable/get)
        (self.ext $Array.isArray)
        (self.ext $Array:push)
        (self.ext $Array:slice)
        (self.ext $Array:splice)

        (nop)
        (self.f32 $performance.timeOrigin)
        (self.i32 $length)
        (self.i32 $WebGL2RenderingContext.ARRAY_BUFFER)
        (self.i32 $WebGL2RenderingContext.FLOAT)
        (self.i32 $WebGL2RenderingContext.UNSIGNED)
        (self.ext $GPUAdapter:requestDevice)
        (self.ref $navigator.gpu)

        (nop)
        (call_direct (result f32) (self.fun $Math.random))
        (call_direct (param i32) (result i64) (i32.const 4) (self.fun $Date.now))
    )

    (start $path:test/sub-folder/test-sub-wat)