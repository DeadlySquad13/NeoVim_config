local simple_plugin_setup = require('ds_omega.utils').simple_plugin_setup

local indent_blankline_is_available = simple_plugin_setup('indent_blankline', 'Highlighting')

if not indent_blankline_is_available then
  return
end

local PLUGIN_NAME = 'indent-blankline.nvim'

if not vim.go.termguicolors then
  notify('Please, set `termguicolors` for better experience.', vim.log.levels.INFO, { title = PLUGIN_NAME })
end

if not vim.go.list then
  notify([[Please, enable `list` option!
Also `space` and `eol` characters should be set in `listchars`!]], vim.log.levels.WARN, { title = PLUGIN_NAME })
end
