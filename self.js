function self(match) {
    let blockName = match.blockName; // Örn: navigator.gpu

    if (blockName.includes(":") === true) blockName = blockName.replaceAll(":", ".prototype.");
    if (blockName.startsWith("self") === false) blockName = `self.${blockName}`;

    const isGetter = blockName.endsWith("/get");
    const isSetter = blockName.endsWith("/set");

    let descriptorKey = "value";

    if (isGetter || isSetter) {
        if (isGetter) descriptorKey = "get";
        if (isSetter) descriptorKey = "set";
        blockName = blockName.substring(0,
            blockName.lastIndexOf(`/${descriptorKey}`)
        );
    }

    const descriptorKeys = [];
    descriptorKeys.push(descriptorKey);

    if (!descriptorKeys.includes("value")) { descriptorKeys.push("value"); }
    if (!descriptorKeys.includes("get")) { descriptorKeys.push("get"); }
    if (!descriptorKeys.includes("set")) { descriptorKeys.push("set"); }

    let pathWalk = blockName.split(".").map((p, i, t) => {
        if (i) {
            return `${t.slice(0, i).join(".")}.${p}`;
        }
        return p;
    });

    const propertyName = blockName.split(".").pop();
    const resultType = match.tagSubType;

    const globalize = `
            (globalized $${match.blockName} (mut ${this.longType[resultType]}) (${this.defaultValue[resultType]}))

        ${pathWalk.map((p, i, t) => {
        switch (i) {
            case 0: return `
                    (pathwalk $${p} 
                        (local.set $level/0 (global.get $${p}))
                    )
                `;

            case t.length - 1: return `
                    (pathwalk $${p} 


                        (if (call $self.Reflect.has<ext.ext>i32
                                (local.get $level/${i - 1})
                                (texxt "${propertyName}")
                            ) 
                            (then 
                                (local.get $prototype
                                    (call $self.Reflect.getPrototypeOf<ext>ext
                                        (local.get $level/${i - 1})
                                    )
                                )

                                (if (call $self.Reflect.has<ext.ext>i32
                                        (local.get $prototype)
                                        (texxt "${propertyName}")
                                    ) 
                                    (then
                                        (local.get $descriptorContainer
                                            (local.get $prototype)
                                        )
                                    )
                                    (else
                                        ;; object has property key but prototype hasn't
                                        ;; which means key its objects own and
                                        ;; descriptor defined on object
                                        (local.set $descriptorContainer
                                            (local.get $level/${i - 1})
                                        )
                                    )
                                )

                                (local.set $descriptor
                                    (call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
                                        (local.get $descriptorContainer)
                                        (texxt "${propertyName}")
                                    )
                                )

                                (block $descriptorKeys
                                    (br_if $descriptorKeys 
                                        (call $self.Reflect.has<ext.ext>i32
                                            (local.get $descriptor)
                                            (local.tee $descriptorKey (texxt "${descriptorKeys[0]}"))
                                        )
                                    )
                                    
                                    (br_if $descriptorKeys 
                                        (call $self.Reflect.has<ext.ext>i32
                                            (local.get $descriptor)
                                            (local.tee $descriptorKey (texxt "${descriptorKeys[1]}"))
                                        )
                                    )

                                    (local.set $descriptorKey (texxt "${descriptorKeys[2]}"))
                                    (br_if $descriptorKeys 
                                        (call $self.Reflect.has<ext.ext>i32
                                            (local.get $descriptor)
                                            (local.tee $descriptorKey (texxt "${descriptorKeys[2]}"))
                                        )
                                    )

                                    (unreachable)
                                )

                                (local.set $valueFetcher
                                    (call $self.Reflect.get<ext.ext>ext
                                        (local.get $descriptor)
                                        (local.get $descriptorKey)
                                    )
                                )

                                (if (call $self.Reflect.has<ext.ext>i32
                                        (local.get $descriptor)
                                        (texxt "${descriptorKeys[0]}")
                                    )
                                    (then 
                                        

                                        (local.set $value
                                            (call $self.Reflect.apply<ext.ext.ext>${resultType}
                                                (local.get $valueFetcher)
                                                (local.get $level/${i - 1})
                                                (global.get $self)
                                            )
                                        )
                                    )
                                    (else 
                                        (local.set $value
                                            (call $self.Reflect.get<ext.ext>${resultType}
                                                (local.get $level/${i - 1})
                                                (texxt "${propertyName}")
                                            )
                                        )
                                    )
                                )

                                (local.set $value 
                                    (call $self.Reflect.get<ext.ext>${resultType}
                                        (local.get $level/${i - 1})
                                        (texxt "${propertyName}")
                                    )
                                )
                            )
                            (else ;; it's object's value
                                (if (call $self.Reflect.has<ext.ext>i32
                                        (local.get $level/${i - 1})
                                        (texxt "${propertyName}")
                                    ) 
                                    (then
                                        (local.set $descriptor
                                            (call $self.Reflect.getOwnPropertyDescriptor<ext.ext>ext
                                                (local.get $level/${i - 1})
                                                (texxt "${propertyName}")
                                            )
                                        )

                                        (local.set $descriptor (local.get $level/${i - 1})) 
                                        (local.set $descriptorKey (texxt "${propertyName}")) 
                                    )
                                    (else

                                    )
                                )
                            )
                        )


                        (local.set $hasPropertyValue
                            (call $self.Reflect.has<ext.ext>i32
                                (local.get $level/${i - 1})
                                (texxt "${propertyName}")
                            )
                        )

                        (local.set $hasOwnProperty
                            (call $self.Reflect.has<ext.ext>i32
                                (local.get $level/${i - 1})
                                (texxt "${propertyName}")
                            )
                        )

                        (if (call $self.Reflect.has<ext.ext>i32
                                (local.get $level/${i - 1})
                                (texxt "${propertyName}")
                            )
                            (then
                                (local.set $value
                                    (call $self.Reflect.get<ext.ext>${match.tagSubType}
                                        (local.get $descriptor)
                                        (texxt "${descriptorKey}")
                                    )
                                )
                            )
                            (else
                                (local.set $value
                                    (call $self.Reflect.get<ext.ext>${match.tagSubType}
                                        (local.get $level/${i - 1})
                                        (texxt "${p}")
                                    )
                                )
                            )
                        )

                        (global.set $${match.blockName} (local.get $value))
                    )
                `;

            default: return `
                    (pathwalk $${p} 
                        (local.set $level/${i}
                            (call $self.Reflect.get<ext.ext>ext
                                (local.get $level/${i - 1})
                                (texxt "${propertyName}")
                            )
                        )
                    )
                `;
        }
    }
    ).join("\n")}
            (global.get $${match.blockName})
        `;

    return globalize;
}