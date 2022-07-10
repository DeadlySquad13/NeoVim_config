local utils = require('utils')
local create_autocmd = utils.create_autocmd

--- 
---@param filetype_options (table) Table for filetype autocmd factory initialization.
--```python
--{ group = Group, pattern = 'python' }
--```
--TODO: make Group autocomputed from pattern string.
---@return (function) new function to create filetype autocmds.
local function file_type_autocmd_factory(filetype_options)
  return function(options)
    create_autocmd(
      { 'FileType' },
      vim.tbl_deep_extend('error', filetype_options, options)
    )
  end
end

return {
  file_type_autocmd_factory = file_type_autocmd_factory,
}
