; Types

; Javascript

; Variables
;-----------
(identifier) @variable

; Properties
;-----------

(property_identifier) @property
;; obj = {
;;   shorthand_property, // highlight as normal variable, not as field.
;; }
(shorthand_property_identifier) @variable
(private_property_identifier) @property

(variable_declarator
  name: (object_pattern
    (shorthand_property_identifier_pattern))) @variable

; Special identifiers
;--------------------

((identifier) @constructor
 (#lua-match? @constructor "^[A-Z]"))

((identifier) @constant
 (#lua-match? @constant "^[A-Z_][A-Z%d_]+$"))

((shorthand_property_identifier) @constant
 (#lua-match? @constant "^[A-Z_][A-Z%d_]+$"))

((identifier) @variable.builtin
 (#vim-match? @variable.builtin "^(arguments|module|console|window|document)$"))

((identifier) @function.builtin
 (#eq? @function.builtin "require"))

; Function and method definitions
;--------------------------------

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

(pair
  key: (property_identifier) @method
  value: (function))
(pair
  key: (property_identifier) @method
  value: (arrow_function))

(assignment_expression
  left: (member_expression
    property: (property_identifier) @method)
  right: (arrow_function))
(assignment_expression
  left: (member_expression
    property: (property_identifier) @method)
  right: (function))

(variable_declarator
  name: (identifier) @function
  value: (arrow_function))
(variable_declarator
  name: (identifier) @function
  value: (function))

(assignment_expression
  left: (identifier) @function
  right: (arrow_function))
(assignment_expression
  left: (identifier) @function
  right: (function))

; Function and method calls
;--------------------------

(call_expression
  function: (identifier) @function)

(call_expression
  function: (member_expression
    property: [(property_identifier) (private_property_identifier)] @method))

; Variables
;----------
(namespace_import
  (identifier) @namespace)

; Literals
;---------

(this) @variable.builtin
(super) @variable.builtin

(true) @boolean
(false) @boolean
(null) @constant.builtin
[
(comment)
(hash_bang_line)
] @comment
(string) @string
(regex) @punctuation.delimiter
(regex_pattern) @string.regex
(template_string) @string
(escape_sequence) @string.escape
(number) @number

; Punctuation
;------------

"..." @punctuation.special

";" @punctuation.delimiter
"." @punctuation.delimiter
"," @punctuation.delimiter
"?." @punctuation.delimiter

(pair ":" @punctuation.delimiter)

[
  "--"
  "-"
  "-="
  "&&"
  "+"
  "++"
  "+="
  "&="
  "/="
  "**="
  "<<="
  "<"
  "<="
  "<<"
  "="
  "=="
  "==="
  "!="
  "!=="
  "=>"
  ">"
  ">="
  ">>"
  "||"
  "%"
  "%="
  "*"
  "**"
  ">>>"
  "&"
  "|"
  "^"
  "??"
  "*="
  ">>="
  ">>>="
  "^="
  "|="
  "&&="
  "||="
  "??="
] @operator

(binary_expression "/" @operator)
(ternary_expression ["?" ":"] @conditional)
(unary_expression ["!" "~" "-" "+" "delete" "void" "typeof"]  @operator)

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

((template_substitution ["${" "}"] @punctuation.special) @none)

; Keywords
;----------

[
"if"
"else"
"switch"
"case"
"default"
] @conditional

[
"import"
"from"
"as"
] @include

[
"for"
"of"
"do"
"while"
"continue"
] @repeat

[
"async"
"await"
"break"
"class"
"debugger"
"extends"
"get"
"in"
"instanceof"
"set"
"static"
"switch"
"target"
"typeof"
"void"
"with"
] @keyword

[
 "export"
 ] @keyword.export

[
 "const"
 "let"
 "var"
] @keyword.declaration

[
"return"
"yield"
] @keyword.return

[
 "function"
] @keyword.function

[
 "new"
 "delete"
] @keyword.operator

[
 "throw"
 "try"
 "catch"
 "finally"
] @exception

;; can I use `inherits: ecma`?
[
"abstract"
"declare"
"enum"
"export"
"implements"
"interface"
"keyof"
"namespace"
"private"
"protected"
"public"
"type"
"readonly"
] @keyword

; types

(type_identifier) @type
(predefined_type) @type.builtin

(import_statement "type"
  (import_clause
    (named_imports
      ((import_specifier
          name: (identifier) @type)))))

; punctuation

(type_arguments
  "<" @punctuation.bracket
  ">" @punctuation.bracket)

(union_type 
  "|" @punctuation.delimiter)

(intersection_type 
  "&" @punctuation.delimiter)

(type_annotation
  ":" @punctuation.delimiter)

(pair
  ":" @punctuation.delimiter)

(property_signature "?" @punctuation.special)
(optional_parameter "?" @punctuation.special)

; Variables

(undefined) @variable.builtin

;;; Parameters
(required_parameter (identifier) @parameter)
(optional_parameter (identifier) @parameter)

(required_parameter
  (rest_pattern
    (identifier) @parameter))

;; ({ a }) => null
(required_parameter
  (object_pattern
    (shorthand_property_identifier_pattern) @parameter))

;; ({ a: b }) => null
(required_parameter
  (object_pattern
    (pair_pattern
      value: (identifier) @parameter)))

;; ([ a ]) => null
(required_parameter
  (array_pattern
    (identifier) @parameter))

;; a => null
(arrow_function
  parameter: (identifier) @parameter)

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
