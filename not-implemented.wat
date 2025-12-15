
(log 
    (param externref i32) 
    (result) 
    
    (local.get $arguments)
    (i32.const 0)
)

(object
    (entry 
        (param externref externref)
        (result externref)

        (text "name") 
        (text "cpu")
    )
    (entry 
        (param externref externref)
        (result externref)

        (text "type") 
        (text "module")
    )
    (entry
        (param externref i32)
        (result externref)

        (text "idbw")
        (i32.const 2)
    )
)    

(apply 
    (ref.extern $self.Worker:postMessage)
    (local.get $worker_instance)
    (array (param externref)
        (local.get $transferable_items)
    )
)

(async
    (apply 
        (param externref externref externref)
        (result externref)

        (ref.extern $self.GPU:requestAdapter)
        (ref.extern $self.navigator.gpu)
        (array)
    )
    (then 
        (param $adapter externref)
        (result externref)

        (global.set $gpu.adapter 
            (local.get $adapter)
        )
        
        (apply
            (param externref externref externref)
            (result externref)                

            (ref.extern $self.GPUAdapter:requestDecice)
            (local.get $adapter)
            (array)
        )
    )
    (then $ondevice
        (param $device externref)
        
        (global.set $gpu.device 
            (local.get $device)
        )
    )
    (catch $ongpufailure
        (param $error Error)
        (log 
            (param externref) 
            (local.get $error)
        )
    )
    (finally $onlaststage
        (log 
            (param externref) 
            (text "gpu last")
        )
    )
)   