(module

    (func $main

        ;; {ref_extern $self.x} :
        (self.extern $location.href) 
        (drop)

        (self.i32 $location.href) 
        (drop)

        (self.get $location.href ext) 
        (drop)

    )
)