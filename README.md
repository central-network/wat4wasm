# Some Skills for Wat2WASM 

Some helper abilities for regular wat2wasm compiler (at this time you need to install regular wat2wasm compiler). You can compile your "wat" file with regular parameters:
```javascript
node wat2wasm test.wat --enable-multi-memory --debug-names
```

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

## Use "$self..." path to assign globals (reflected import)

No need to use "import" keyword anymore!
Now, you can use "global" definitions to reach any object that starts with global path like self.screen.width. Compiler will be split your path and starts to reach last property definition. This process runs in the "start" functions' body and uses Reflect.get and/or Reflect.getOwnPropertyDescriptor calls which means you can assign "getter" and "setter" functions as an externref global too. 

Be aware those "self" globals are always mutable.

Basic definition examples:
```webassembly
(global $self.screen.width f32)
(global $self.location.origin externref)
(global $self.MessageEvent.prototype.data/get externref)
(global $self.Worker:onmessage/set externref)
```

ans full source to see console outputs:
```webassembly
(module
    (import "console" "log" (func $log<ref> (param externref)))
    (import "console" "log" (func $log<f32> (param f32)))

    (include "./test-sub.wat")

    (global $self.screen.width f32)
    (global $self.location.origin externref)
    (global $self.MessageEvent.prototype.data/get externref)
    (global $self.Worker:onmessage/set externref)

    (memory 10 10 shared)

    (start $main
        (call $log<ref> (text "Text to externref is easy!"))
        (call $log<ref> (global.get $self.location.origin))
        (call $log<f32> (global.get $self.screen.width))
        (call $log<ref> (global.get $self.MessageEvent.prototype.data/get))
        (call $log<ref> (global.get $self.Worker:onmessage/set))
    )
)
```

 <img width="100%" alt="console output" src="examples/image.png">


compiler also knows : means .prototype. and replaces at first. 


## Use texts as globals 

In general, text definitions runs over table get calls. This method also gives opportunitiy to set texts' external references to global variables. 
```webassembly
(global $ANY_TEXT_GLOBAL "any text global")
```

Compiler modifies your global definiton to mutable externref type and sets global value at the begining of instance. Basic example:
```webassembly
(module
    (import "console" "log" (func $log<ref> (param externref)))
    (import "console" "log" (func $log<f32> (param f32)))

    (include "./test-sub.wat")

    (global $self.screen.width f32)
    (global $self.location.origin externref)
    (global $self.MessageEvent.prototype.data/get externref)
    (global $self.Worker:onmessage/set externref)

    (global $ANY_TEXT_GLOBAL "any text global")

    (memory 10 10 shared)

    (start $main
        (call $log<ref> (text "interal text converted to table.get!"))
        (call $log<ref> (global.get $self.location.origin))
        (call $log<f32> (global.get $self.screen.width))
        (call $log<ref> (global.get $self.MessageEvent.prototype.data/get))
        (call $log<ref> (global.get $self.Worker:onmessage/set))
        (call $log<ref> (global.get $ANY_TEXT_GLOBAL))
    )
)
```


## Auto "elem" definitions for "ref.func" usage

Compiler will create an "elem" segment and puts all necessary function pointers. You can simply use ref.func call like before, this is for just "elem" segment definition:

```webassembly
(ref.func $any_of_your_func)
```

will generate:
```webassembly
(elem $wat2wasm/refs funcref (ref.func $any_of_your_func))
```

multiple references will be joined:
```webassembly
(elem $wat2wasm/refs funcref (ref.func $ref1) (ref.func $ref2) ... (ref.func $refN))
```

## Auto "imports" for "$self..." calls

Compiler will create import definitions for your $self. prefixed calls. Maximum level of deep objects is 2 which means you can use for *Number, Boolean, console.log, Math.floor* etc.. but you can **NOT** use *navigator.permissions.query* because of path has three level of deepness.

use without definition import:
```webassembly
(call $self.console.log<i32> (i32.const 2))
```

compiler appends import definition to wat code:
```webassembly
(import "console" "log" (func $self.console.log<i32> (param i32)))
```

The end of the name definition is important because of parameters and result types cames from it. Between the &lt;bracets&gt; defines input arguments which every one of it is "param" and result type comes to end. Every type sperates with a dot (.) like i32.f32.i32 and you can also use multiplier (x) symbol like i32x3.. Externref shortened with "ref" keyword and funcref is shortened with "fun" keyword..

Examine those definitions to understand:
<table>
    <thead>
        <tr>
            <td>Your WAT Code</td>
            <td align="center">Input</td>
            <td align="center">Output</td>
            <td>Import definition</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>(call $name&lt;i32.f32&gt;ref .. )</td>
            <td align="center">i32, i32</td>
            <td align="center">externref</td>
            <td>(func $name (param i32 f32) (result externref))</td>
        </tr>
        <tr>
            <td>(call $name&lt;f32x2&gt; .. )</td>
            <td align="center">f32 f32</td>
            <td align="center"></td>
            <td>(func $name (param f32 f32))</td>
        </tr>
        <tr>
            <td>(call $name&lt;&gt;i32)</td>
            <td align="center"></td>
            <td align="center">i32</td>
            <td>(func $name (result i32))</td>
        </tr>
    </tbody>
</table>

## log, warn and error keywords for shorten calls of $self.console..

use without call requests:
```webassembly
;;[color:red]
(log<i32> (i32.const 2))
(warn<ref> (ref.null extern))
(error<i32.f32x2> (i32.const 2) (f32.const 2.2) (f32.const 0.1))
```

will be replaced by:
```webassembly
(call $self.console.log<i32> (i32.const 2))
(call $self.console.warn<ref> (ref.null extern))
(call $self.console.error<i32.f32x2> (i32.const 2) (f32.const 2.2) (f32.const 0.1))
```


At this time you can use combitaions of abilities:
```webassembly
(module
    (include "./test-sub.wat")

    (global $self.screen.width f32)
    (global $self.location.origin externref)
    (global $self.console.warn externref)
    (global $self.MessageEvent.prototype.data/get externref)
    (global $self.Worker:onmessage/set externref)

    (global $ANY_TEXT_GLOBAL "any text global")

    (memory 10 10 shared)

    (start $main
        (log<ref> (text "interal text converted to table.get!"))
        (log<ref> (global.get $self.location.origin))
        (log<f32> (global.get $self.screen.width))
        (log<ref> (global.get $self.MessageEvent.prototype.data/get))
        (log<ref> (global.get $self.Worker:onmessage/set))
        (log<ref> (global.get $ANY_TEXT_GLOBAL))


        (call $self.console.error<ref>
            (call $self.Array.of<i32x3.f32>ref
                (i32.const 2)
                (i32.const 4)
                (i32.const 5)
                (f32.const 2.2)
            )
        )

        (call $self.requestAnimationFrame<fun>
            (ref.func $onanimationframe<f32>)
        )

        (call $self.setTimeout<fun.i32>
            (ref.func $ontimeout)
            (i32.const 1000)
        )
    )

    (func $onanimationframe<f32>
        (param $performance.now f32)
        (warn<ref.f32>
            (text "animation frame ready:") 
            (local.get $performance.now)
        )
    )

    (func $ontimeout
        (error<ref> 
            (text "timer done, 1000ms passed..")
        )
    )
)
```
