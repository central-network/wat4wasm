# Some Skills for Wat2WASM 

Some helper abilities for regular wat2wasm compiler (at this time you need to install regular wat2wasm compiler). 

## Include another WAT file to your code

You can use "include" keyword to replace your code with given path file:

```webassembly
(include "some-path.wat")
```

This code segment will be replaced with content of "some-path.wat" file. Compiler reads file as a string and replaces with (include "some-path.wat") frame. This skill works recursively, so you can use another "include" code in your sub-content wat files.

For example, consider that your project folder has two files: 
- test.wat 
- test-sub.wat


and your test.wat file content is:
 ```webassembly
(module 
    (import "a" "b" (global $ab i32))

    (include "./test-sub.wat")

    (func $second)
)
```


and your test-sub.wat file content is:
 ```webassembly
    (func $test-sub)
    (global $num i32 
        (i32.const 0)
    )
```

then your compiled wat file will be:
 ```webassembly
(module 
    (import "a" "b" (global $ab i32))
    
    (func $test-sub)
    (global $num i32 
        (i32.const 0)
    )

    (func $second)
)
```


## Use "start" keyword to define and trigger start function

You can use "start" keyword to define and trigger at the same time:

```webassembly
(module
    (start $main
        (local $any i32)
    )
)
```

then your code will be replaced with:
```webassembly
(module
    (start $main) 
    
    (func $main
        (local $any i32)
    )
)
```


## Use "text" keyword to create an externref for text content

Use "text" type keyword to create a string content with externref behaviour:

```webassembly
(text "hello world!")
```

Compiler will encode your string with char codes and stores in a data segment as u16 integers. When instance raises then start function begins to generate text contents and stores and table to able for getter calls. Every text calls returns an externref value from an externref table.

You can see console output if you want to:
```webassembly
(module
    (import "console" "log" (func $log (param externref)))

    (start $main
        (call $log (text "hello world!"))
    )
)
```