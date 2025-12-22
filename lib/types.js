
export const TYPES = {
    // Map Short -> Long
    long: {
        "ext": "externref",
        "fun": "funcref",
        "externref": "externref",
        "funcref": "funcref",
        "i32": "i32",
        "i64": "i64",
        "f32": "f32",
        "f64": "f64",
        "v128": "v128",
        "anyref": "anyref",
        "eqref": "eqref"
    },
    // Map Long -> Short
    short: {
        "externref": "ext",
        "funcref": "fun",
        "ext": "ext",
        "fun": "fun",
        "i32": "i32",
        "i64": "i64",
        "f32": "f32",
        "f64": "f64",
        "v128": "v128"
    },

    simdType: [
        "i8x16",
        "i16x8",
        "i32x4",
        "f32x4",
        "i64x2",
        "f64x2"
    ],

    decimalLength: {
        "i32": 1,
        "f32": 1,
        "i64": 1,
        "f64": 1,
        "i8x16": 8,
        "i16x8": 8,
        "i32x4": 4,
        "f32x4": 4,
        "i64x2": 2,
        "f64x2": 2
    },

    // Normalize to long type (default to externref if unknown/custom but looks like type?)
    toLong: (t) => TYPES.long[t] || (TYPES.isKnown(t) ? t : "externref"),

    // Normalize to short type
    toShort: (t) => TYPES.short[t] || "ext",

    isKnown: (t) => !!TYPES.long[t],

    isSimdType: (t) => TYPES.simdType.includes(t),

    decimalCount: (t) => TYPES.decimalLength[t]
};
