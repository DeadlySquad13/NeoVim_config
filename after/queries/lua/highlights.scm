;; extends 

;; Keywords

"return" @keyword.return

[
 "goto"
 "in"
] @keyword

[
 "local"
 ] @keyword.declaration

(label_statement) @label

(break_statement) @keyword

(do_statement
[
  "do"
  "end"
] @keyword)

(while_statement
[
  "while"
  "do"
  "end"
] @repeat)

(repeat_statement
[
  "repeat"
  "until"
] @repeat)

(if_statement
[
  "if"
  "elseif"
  "else"
  "then"
  "end"
] @conditional)

(elseif_statement
[
  "elseif"
  "then"
  "end"
] @conditional)

(else_statement
[
  "else"
  "end"
] @conditional)

(for_statement
[
  "for"
  "do"
  "end"
] @repeat)

(function_declaration
[
  "function"
  "end"
] @keyword.function)

(function_definition
[
  "function"
  "end"
] @keyword.function)

;; Operators

[
 "and"
 "not"
 "or"
] @keyword.operator

[
  "+"
  "-"
  "*"
  "/"
  "%"
  "^"
  "#"
  "=="
  "~="
  "<="
  ">="
  "<"
  ">"
  "="
  "&"
  "~"
  "|"
  "<<"
  ">>"
  "//"
  ".."
] @operator

;; Punctuations

[
  ";"
  ":"
  ","
  "."
] @punctuation.delimiter

;; Brackets

[
 "("
 ")"
 "["
 "]"
 "{"
 "}"
] @punctuation.bracket

;; Variables

(identifier) @variable

((identifier) @variable.builtin
 (#eq? @variable.builtin "self"))

;; Constants

((identifier) @constant
 (#lua-match? @constant "^[A-Z][A-Z_0-9]*$"))

(vararg_expression) @constant

(nil) @constant.builtin

[
  (false)
  (true)
] @boolean

;; Tables

(field name: (identifier) @field)

(dot_index_expression field: (identifier) @field)

(table_constructor
[
  "{"
  "}"
] @constructor)

;; Functions

(parameters (identifier) @parameter)

(function_call name: (identifier) @function)
(function_declaration name: (identifier) @function)

(function_call name: (dot_index_expression field: (identifier) @function))
(function_declaration name: (dot_index_expression field: (identifier) @function))

(method_index_expression method: (identifier) @method)

(function_call
  (identifier) @function.builtin
  (#any-of? @function.builtin
    ;; built-in functions in Lua 5.1
    "assert" "collectgarbage" "dofile" "error" "getfenv" "getmetatable" "ipairs"
    "load" "loadfile" "loadstring" "module" "next" "pairs" "pcall" "print"
    "rawequal" "rawget" "rawset" "require" "select" "setfenv" "setmetatable"
    "tonumber" "tostring" "type" "unpack" "xpcall"))

;; Others

(comment) @comment

(hash_bang_line) @comment

(number) @number

(string) @string

;; Error
(ERROR) @error

;; Conceals
(("then" @conditional) (#set! conceal "{"))
(("else" @conditional) (#set! conceal "e"))
(("elseif" @conditional) (#set! conceal "e"))
((if_statement "end" @conditional) (#set! conceal "}"))

(("do" @repeat) (#set! conceal "{"))
(while_statement "end"  @repeat) (#set conceal "}")
(for_statement "end"  @repeat) (#set conceal "}")

(("function" @keyword.function) (#set! conceal "f"))
((function_declaration "end" @keyword.function) (#set! conceal ""))
((function_definition "end" @keyword.function) (#set! conceal ""))

((function_call name: (identifier) @function.builtin (#eq? @function.builtin "require")) (#set! conceal "r"))

(("local" @keyword) (#set! conceal "l"))
