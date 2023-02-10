return {
  enable = true,

  -- Determine the fallback method used when we cannot calculate indent by tree-sitter:
  --   "auto": fallback to vim auto indent,
  --   "asis": use current indent as-is,
  --   "cindent": see `:h cindent()`
  --   or a custom function return the final indent result.
  default_fallback = 'auto',
}
