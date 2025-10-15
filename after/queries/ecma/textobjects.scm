; extends

; See this well-written post: https://www.josean.com/posts/nvim-treesitter-and-textobjects
(object
  (pair
    key: (_) @property.lhs
    value: (_) @property.inner @property.rhs) @property.outer)


(expression_statement
    (assignment_expression
      left: (_) @expression_statement.lhs
      right: (_) @expression_statement.rhs @expression_statement.inner
    ) @expression_statement.outer)
