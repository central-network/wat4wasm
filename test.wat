(module
	(import "self" "name" (global $myname externref))
    (include "test-sub.wat")
    (memory 10)
    (start $starter)
)