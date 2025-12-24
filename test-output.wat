(module
	(import "console" "log"  (func $self.console.log<f32>  (param f32)))
	(import "console" "warn" (func $self.console.warn<f32> (param f32)))
	(import "console" "warn" (func $self.console.warn<i32> (param i32)))

	(func $Array
		(table.get $wat4wasm (i32.const 7))
		(drop)

		(table.get $wat4wasm (i32.const 6))
		(drop)

		(table.get $wat4wasm (i32.const 5))
		(drop)

		(table.get $wat4wasm (i32.const 4))
		(drop)

		(table.get $wat4wasm (i32.const 3))
		(drop)

		(table.get $wat4wasm (i32.const 2))
		(drop)

		(table.get $wat4wasm (i32.const 1))
		(drop)

	)
	(data $filread "file://test-out.txt")
	;;(nop)
	(start $Array)

	(func $calc)
	(export "calc" (func $calc))
	(table $wat4wasm 8 externref)
)