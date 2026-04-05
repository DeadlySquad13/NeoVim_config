;; extends 


; [h1]
(table (bare_key) @table1 (#set! "priority" 101))
; [h1.h2]
(dotted_key 
  (bare_key) @table1
  (bare_key) @table2 (#set! "priority" 101))
; [h1.h2.h3]
(dotted_key
  (dotted_key 
    (bare_key) ; Already @table1
    (bare_key)) ; Already @table2
  (bare_key) @table3 (#set! "priority" 101))
