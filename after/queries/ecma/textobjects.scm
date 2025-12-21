; extends

; See this well-written post: https://www.josean.com/posts/nvim-treesitter-and-textobjects
(object
  (pair
    key: (_) @property.lhs
    value: (_) @property.inner @property.rhs) @property.outer)

; TODO: Couldn't figure our how to get this range:
; and `const something = new Cool()`
;      [             ]
;      ^ lhs
; (lexical_declaration
;   (
;     (#any-of? "const" "let" "var")
;     (variable_declarator
;       name: (_) ; @assignment.lhs
;     )
;   ) @assignment_left.outer
;   )
; (lexical_declaration
;   (
;    (#any-of? "const" "let" "var")
;    .
;    (variable_declarator
;     (identifier))
;    ) @assignment_left.outer
;   )

; Triggers bigger area but looks not only for assignments but also
; for `this.something = new Cool()`
;      [            ]   [        ]
;      ^ lhs            ^ rhs / inner
;      [                          ]
;      ^ outer
(expression_statement
    (assignment_expression
      left: (_) @expression_statement.lhs
      right: (_) @expression_statement.rhs @expression_statement.inner
    ) @expression_statement.outer)

; Narrower expression_statement.lhs
; for `this.some.thing = new Cool()`
;      [       ] [    ] 
;      ^ lhs     ^ rhs
;      [              ]
;      ^ outer
(expression_statement
    (assignment_expression
      (member_expression
           object: (_) @expression_statement_left.lhs
           property: (_) @expression_statement_left.rhs
         )))
