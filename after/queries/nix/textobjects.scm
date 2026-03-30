; extends

; Narrower expression_statement.lhs
; for `this.some.thing = new Cool()`
;      [       ] [    ] 
;      ^ lhs     ^ rhs
;      [              ]
;      ^ outer
; (expression_statement
;     (assignment_expression
;       (member_expression
;            object: (_) @expression_statement_left.lhs
;            property: (_) @expression_statement_left.rhs
;          )))

; Triggers bigger area but looks not only for assignments but also
; for `programs.git = { enabled = true }`
;      [          ]   [                ]
;      ^ lhs            ^ rhs / inner
;      [                               ]
;      ^ outer
(binding
     attrpath: (_) @expression_statement.lhs
     expression: (_) @expression_statement.rhs @expression_statement.inner
) @expression_statement.outer
