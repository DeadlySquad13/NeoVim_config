; extends

(function
  name: (identifier) @function)
(function_declaration
  name: (identifier) @function.declaration)
(generator_function
  name: (identifier) @function)
(generator_function_declaration
  name: (identifier) @function.declaration)
(method_definition
  name: [(property_identifier) (private_property_identifier)] @method)


("export") @keyword.export

[
 "const"
 "let"
 "var"
] @keyword.declaration

(class_declaration
  name: (type_identifier) @class)

;; Built-in classes
;; @see [Global Objects in Mozilla Reference](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects)
;; ----------------------------
((identifier) @class.builtin.fundamental
  (#any-of? @class.builtin.fundamental
  "Object"
  "Function"
  "Boolean"
  "Symbol"
  )
)

((identifier) @class.builtin.error
  (#any-of? @class.builtin.error
  "Error"
  "AggregateError"
  "EvalError"
  "InternalError Non-Standard"
  "RangeError"
  "ReferenceError"
  "SyntaxError"
  "TypeError"
  "URIError"
  )
) 

((identifier) @class.builtin.number_or_date
  (#any-of? @class.builtin.number_or_date
  "Number"
  "BigInt"
  "Math"
  "Date"
  )
) 

((identifier) @class.builtin.text_processing
  (#any-of? @class.builtin.text_processing
  "String"
  "RegExp"
  )
) 

((identifier) @class.builtin.indexed_collection
  (#any-of? @class.builtin.indexed_collection
  "Array"
  "Int8Array"
  "Uint8Array"
  "Uint8ClampedArray"
  "Int16Array"
  "Uint16Array"
  "Int32Array"
  "Uint32Array"
  "Float32Array"
  "Float64Array"
  "BigInt64Array"
  "BigUint64Array"
  )
) 

((identifier) @class.builtin.keyed_collection
  (#any-of? @class.builtin.keyed_collection
  "Map"
  "Set"
  "WeakMap"
  "WeakSet"
  )
) 

((identifier) @class.builtin.structured_data
  (#any-of? @class.builtin.structured_data
   "ArrayBuffer"
   "SharedArrayBuffer"
   "Atomics"
   "DataView"
   "JSON"
  )
)
((identifier) @class.builtin.control_abstraction
  (#any-of? @class.builtin.control_abstraction
   "Promise"
   "Generator"
   "GeneratorFunction"
   "AsyncFunction"
  )
) 

((identifier) @class.builtin.reflection
  (#any-of? @class.builtin.reflection
   "Reflect"
   "Proxy"
  )
)

;; Conceals.
(("abstract" @type.qualifier) (#set! conceal "a"))
(("private" @type.qualifier) (#set! conceal "🚪")) ;; Door (U+1F6AA)
(("protected" @type.qualifier) (#set! conceal "⛨")) ;; Black cross on Shield (U+26E8).
(("public" @type.qualifier) (#set! conceal "🍂")) ;; Fallen Leaf (U+1F342)
(("readonly" @type.qualifier) (#set! conceal "r"))

;; TODO: Move to ecma.
(("const" @keyword.declaration) (#set! conceal "c"))
(("let" @keyword.declaration) (#set! conceal "l"))
(("var" @keyword.declaration) (#set! conceal "v"))
