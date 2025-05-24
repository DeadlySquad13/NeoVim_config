; extends

; ((type_arguments) @type.inner (
;     #any-of?
;       predefined_type
;       type_identifier
;       nested_type_identifier
;     )
; ) @type.outer

[(predefined_type) (type_identifier) (nested_type_identifier) (type)] @type.outer
