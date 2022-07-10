local utils = require('config.queries.utils')
local read_query_files, get_query_files, set_query =
utils.read_query_files, utils.get_query_files, utils.set_query

local old_highlight_query = read_query_files(
  get_query_files('css', 'highlights')
)

local new_highlight_query = old_highlight_query
    --[=[ :gsub(
      vim.pesc([[
[
 (class_name)
 (id_name)
 (namespace_name)
 (property_name)
 (feature_name)
 (attribute_name)
 ] @property]]),
      [[
[
 (namespace_name)
 (property_name)
 (feature_name)
 (attribute_name)
 ] @property


(class_name) @selector.class
(id_name) @selector.id
  ]]
    ) ]=]
    :gsub(
      vim.pesc([[
[
 "#"
 ","
 "."
 ":"
 "::"
 ";"
 ] @punctuation.delimiter
]]),
      [[
[
 ","
 ";"
 ] @punctuation.delimiter

 "." @punctuation.delimiter.class
 "#" @punctuation.delimiter.id
 ":" @punctuation.delimiter.pseudo_class
 "::" @punctuation.delimiter.pseudo_element
]]
    )

set_query('css', 'highlights', new_highlight_query)
require('nvim-treesitter.highlight').set_custom_captures({
  ['selector.class'] = 'TSSelectorClass',
  ['selector.id'] = 'TSSelectorId',
  ['punctuation.delimiter.class'] = 'TSPunctDelimiterClass',
  ['punctuation.delimiter.id'] = 'TSPunctDelimiterId',
  ['punctuation.delimiter.pseudo_class'] = 'TSPunctDelimiterPseudoClass',
  ['punctuation.delimiter.pseudo_element'] = 'TSPunctDelimiterPseudoElement',
})
