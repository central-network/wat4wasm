(module 
    (func $main
        (ref.func $unreferenced_by_user)
        (drop)
    )

    (func $unreferenced_by_user)
)