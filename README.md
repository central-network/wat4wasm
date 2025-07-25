# Some Skills for Wat2WASM 

Some helper abilities for regular wat2wasm compiler (at this time you need to install regular wat2wasm compiler). You can compile your "wat" file with regular parameters:
```javascript
node wat2wasm test.wat --enable-multi-memory --debug-names
```

useable:
```webassembly      
(include "some-path.wat")                               ;; replace with file content
(text "hello world!")                                   ;; text to externref
(start $main (local $any i32) ...)                      ;; start to start + func
(global $self.location.origin externref)                ;; text from table get
(global $ANY_TEXT_GLOBAL "any text global")             ;; text as global 
(call $self.Array.of<i32>ref (i32.const 2))             ;; direct call
(call $self.Math.random f32)                            ;; direct imported call
(apply $self.Math.random f32)                           ;; Reflect.apply applied
(log<ref> (global.get $self.location.origin))           ;; console.log
(new $self.Uint8Array<i32> (i32.const 4))               ;; constructor

(get <refx2>ref self (text "origin"))                   ;; getter
(set <refx2.fun> self text("onresize") func($onresize)) ;; setter 

(call $self.requestAnimationFrame<fun>                  ;; auto imported
    (func $inlinefunction<f32>                          ;; inline function
        (param $performance.now f32)
        (error<f32> (local.get $performance.now))       ;; console.error
    )
)

(apply $self.Math.max<i32x3.f32>i32                     ;; function
    (self)                                              ;; this
    (param                                              ;; arguments array
        (i32.const 2)
        (i32.const 4)
        (i32.const 5)
        (f32.const 1122.2)
    )
)

(new $self.Worker<refx2>ref
    (text "worker.js")
    (call $self.Object.fromEntries<ref>ref
        (call $self.Array<ref>ref
            (call $self.Array.of<refx2>ref
                (text "name")
                (text "özgür")
            )
        )
    )
)

(async                                                  ;; promise working
    (call $self.navigator.gpu.requestAdapter)           ;; converted to global
    (then $onadapter                                    ;; moved to outer scope as func
        (param $adapter externref)
        (warn <ref> this)
    )
    (catch $onfail                                      ;; moved to outer scope as func
        (param $msg externref)
        (error <ref> local($msg))
    )
)  

i32(2)                                                  ;; type(N -> (type.const N
f32(1.2)                                                ;; type(N -> (type.const N
...
(self|this|null)                                        ;; replaces paranthesis to spaces:
 self                                                   ;; (global.get $wat2wasm/self)                
 this                                                   ;; (local.get 0)                
 null                                                   ;; (ref.null extern)                
```

## keyword: include

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


## keyword: start

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


## keyword: text (table)

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

## keyword: text (global) 

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


## keyword: ref.func (elem)

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

## keyword: apply

Compiler will convert your Reflect.apply requests as well as:

```webassembly
(func $example 

    ... body

    (apply $self.Math.max<i32x3.f32>i32     ;; function
        (self)                              ;; this
        (param                              ;; arguments array
            (i32.const 2)
            (i32.const 4)
            (i32.const 5)
            (f32.const 1122.2)
        )
    )

    (error<i32>)

    body ...
)
```

you don't need to define (global $self.Math.max externref) your code turns into:
```webassembly
(func $example 

    ... body

    (call $self.Reflect.apply<refx3>i32     ;; inputs always ref.ref.ref / output from you
        (global.get $self.Math.max)         ;; auto reflected import
        (global.get $wat2wasm/self)         ;; default wat2wasm import
        (call $self.Array.of<i32x3.f32>ref  ;; inputs from you / output always externref
            (i32.const 2)
            (i32.const 4)
            (i32.const 5)
            (f32.const 1122.2)
        )
    )

    (call $self.console.error<i32>)

    body ...
)
```

those examples also works:
```webassembly
(apply $self.Math.random)           ;; no result, no mean :) (no typed, result is empty)
(nop)

(apply $self.Math.random<>ref)      ;; result is externref (typed in function name)
(drop)

(apply $self.Math.random f32)       ;; result is float 32 (typed like global definition)
(drop)

(apply $self.Math.random externref) ;; result is externref (typed like global definition)
(drop)

(apply $self.Math.random ref)       ;; result is externref (typed shorten global definition)
(drop)

```

## keyword: new, construct

Compiler will convert your Reflect.construct requests as well as:

```webassembly
(func $example 

    ... body

    (construct $self.Uint8Array<i32>ref     ;; constructor
        (param                              ;; arguments array
            (i32.const 4)
        )
    )

    (error<ref>)

    body ...
)
```

you don't need to define (global $self.Uint8Array externref) your code turns into:
```webassembly
(func $example 

    ... body

    (call $self.Reflect.construct<refx2>ref ;; inputs always ref.ref / output always ref
        (global.get $self.Uint8Array)       ;; auto reflected import for constructor
        (call $self.Array.of<i32>ref        ;; inputs from you / output always externref
            (i32.const 4)
        )
    )

    (call $self.console.error<ref>)

    body ...
)
```

those examples also works:
```webassembly
(new $self.Array)                           ;; no output/args (always externref)          
(new $self.Uint8Array<i32> (i32.const 4))   ;; no param
(new $self.Number<f32> f32(4.4))            ;; Type(N -> (Type.const N)
(new $self.Worker<ref> (text "worker.js"))  ;; result always externref
(construct $self.Worker<refx2>ref           ;; long but understanable
    (param
        (text "worker.js")
        (new $Object)
    )
)
(construct $self.Worker<refx2>ref           ;; no param expressed
    (text "worker.js") 
    (new $Object)
)
```

## keyword: async

Compiler will know you are working with promises and binds then/catch/finally functions to moved outer scope functions. Maximum 3 level deeper self object are allowed in here. Also "call" requests turns into "apply" requests because of deeper objects requires parent object for "this" parameter.

```webassembly
(func $example 

    ... body

    (async
        (call $self.navigator.gpu.requestAdapter)
        (then $onadapter
            (param $adapter externref)
            (warn <ref> this)
        )
        (catch $onfail
            (param $msg externref)
            (error <ref> local($msg))
        )
    ) 

    body ...
)
```

converted into:
```webassembly
(func $example 

    ... body

    (call $self.Reflect.apply<refx3>
        (global.get $self.Promise.prototype.catch)
        (call $self.Reflect.apply<refx3>ref
            (global.get $self.Promise.prototype.then)
            (call $self.Reflect.apply<refx3>ref 
                (global.get $self.navigator.gpu.requestAdapter) 
                (global.get $self.navigator.gpu) 
                (call $self.Array.of<>ref)
            )
            (call $self.Array.of<fun>ref
                (ref.func $async1_onadapter)
            )
        )
        (call $self.Array.of<fun>ref
            (ref.func $async2_onfail)
        )
    )

    body ...
)

(func $async1_onadapter
    (param $adapter externref)
    (call $self.console.warn<ref> (local.get 0))
)

(func $async2_onfail
    (param $msg externref)
    (call $self.console.error<ref> (local.get $msg))
)

(elem $wat2wasm/async funcref 
    (ref.func $async1_onadapter)
    (ref.func $async2_onfail)
)
```

also appended to module scope:
```webassembly
(global $self.Promise.prototype.then (mut externref) ref.null extern)
(global $self.Promise.prototype.catch (mut externref) ref.null extern)	
(global $self.navigator.gpu (mut externref) ref.null extern)
(global $self.navigator.gpu.requestAdapter (mut externref) ref.null extern)
```

and start function includes more global setters:
```webassembly
(global.set $self.Promise.prototype.then
    (call $wat2wasm/Reflect.get<refx2>ref
        (call $wat2wasm/Reflect.get<refx2>ref 
                    (call $wat2wasm/Reflect.get<refx2>ref 
                        (global.get $wat2wasm/self) 
                        (table.get $extern (i32.const 22)) 
                    ) 
                    (table.get $extern (i32.const 16)) 
                )
        (table.get $extern (i32.const 23)) 
    )
)

(global.set $self.Promise.prototype.catch
    (call $wat2wasm/Reflect.get<refx2>ref
        (call $wat2wasm/Reflect.get<refx2>ref 
                    (call $wat2wasm/Reflect.get<refx2>ref 
                        (global.get $wat2wasm/self) 
                        (table.get $extern (i32.const 22)) 
                    ) 
                    (table.get $extern (i32.const 16)) 
                )
        (table.get $extern (i32.const 24)) 
    )
)

(global.set $self.navigator.gpu
    (call $wat2wasm/Reflect.get<refx2>ref
        (call $wat2wasm/Reflect.get<refx2>ref 
            (global.get $wat2wasm/self) 
            (table.get $extern (i32.const 27)) 
        )
        (table.get $extern (i32.const 28)) 
    )
)

(global.set $self.navigator.gpu.requestAdapter
    (call $wat2wasm/Reflect.get<refx2>ref
        (call $wat2wasm/Reflect.get<refx2>ref 
            (call $wat2wasm/Reflect.get<refx2>ref 
                (global.get $wat2wasm/self) 
                (table.get $extern (i32.const 27)) 
            ) 
            (table.get $extern (i32.const 28)) 
        )
        (table.get $extern (i32.const 29)) 
    )
)
```

Notice that you can/need to define result parameter. Otherwise no result will be return for chain: 
```webassembly
(warn<ref>
    (async externref
        ...
    )
) 
```

## keyword: get, set

Compiler will convert your Reflect.get / Reflect.set requests as well as:

```webassembly
(func $example 

    ... body

    (get <refx2>ref self (text "origin"))        
    (warn<ref>)

    (set <refx2.fun> self text("onresize") func($onresize))        

    body ...
)
```

you don't need to define (global $self.Uint8Array externref) your code turns into:
```webassembly
(func $example 

    ... body

    (call $self.Reflect.get<refx2>ref       ;; input / output comes from you
        (global.get $wat2wasm/self)         ;; self -> global.get ...
        (table.get $extern (i32.const N))   ;; text -> table.get ...
    )

    (call $self.console.warn<ref>)

    (call $self.Reflect.set<refx2.fun>      ;; input / output comes from you
        (global.get $wat2wasm/self)         ;; self -> global.get ...
        (table.get $extern (i32.const N))   ;; text -> table.get ...
        (ref.func $onresize)                ;; func -> ref.func ...
    )

    body ...
)
```

## keyword: i32, f32, i64, f64

Compiler will turn your constants into formal type:
```webassembly
i32(4)              --> (i32.const 4)                
f32(3.4)            --> (f32.const 3.4)
i64(511235124)      --> (i64.const 511235124)                            
f64(3241.55114)     --> (f64.const 3241.55114)    
```

## keyword: local, global, func, table

Compiler will turn your constants into formal type:
```webassembly
local(0)            --> (local.get 0)                
local($a)           --> (local.get $a)                
global($A)          --> (global.get $A)
func($on)           --> (ref.func $on)                            
table($db)          --> (table.get $db)                            
```

## keyword: this, self, null

Compiler will turn your constants into formal type:
```webassembly
this                --> (local.get 0)                
self                --> (global.get $wat2wasm/self)                
null                --> (ref.null extern)                
```


## keyword: log, warn, error

use without call requests:
```webassembly
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

## name: $self... (import)

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

 <img width="100%" alt="console output" src="image.png">


compiler also knows : means .prototype. and replaces at first. 


## name: $self... (call)

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



## shorten: (self)

Compiler will convert your globalThis getter:

```webassembly
(self)
```

uses:
```webassembly
(import "self" "self" (global $wat2wasm/self externref))
```


## shorten: (null)

Compiler will convert your null reference getter:

```webassembly
(null)
```

turns into:
```webassembly
(ref.null extern)
```

## inline functions

You can use inline functions. Compiler will be copy your function to outer scope and replace it's place with "ref.func". You can see at example:

```webassembly
(func $outer 

    ... body

    (call $self.requestAnimationFrame<fun>
        (func $inlinefunction<f32>
            (param $performance.now f32)
            (error<f32> (local.get $performance.now))
        )
    )

    body ...
)
```

will be replaced with (elem definitions also will be generated):
```webassembly
(func $inlinefunction<f32>
    (param $performance.now f32)

    (call $self.console.error<f32>
        (local.get $performance.now)
    )
)

(func $outer 

    ... body

    (call $self.requestAnimationFrame<fun>
        (ref.func $inlinefunction<f32>)
    )

    body ...

)

```
