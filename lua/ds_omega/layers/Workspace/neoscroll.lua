local simple_plugin_setup = require('ds_omega.utils').simple_plugin_setup

simple_plugin_setup('neoscroll', 'neoscroll')

local prequire = require('utils').prequire
local is_neoscroll_config_available, neoscroll_config = prequire('neoscroll.config')
if not is_neoscroll_config_available then
  return
end

-- Syntax: `[keys] = {function, {function arguments}}`.
local scroll_mappings = {
  -- Use the "sine" easing function.
  ['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '250', [['sine']]}},
  ['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '250', [['sine']]}},
  -- Use the "circular" easing function.
  ['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '450', [['circular']]}},
  ['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '450', [['circular']]}},
  -- Pass "nil" to disable the easing animation (constant scrolling speed).
  ['<C-y>'] = {'scroll', {'-0.10', 'false', '100', nil}},
  ['<C-e>'] = {'scroll', { '0.10', 'false', '100', nil}},
  -- When no easing function is provided the default easing function (in this case "quadratic") will be used.
  ['zt']    = {'zt', {'300'}},
  ['zz']    = {'zz', {'300'}},
  ['zb']    = {'zb', {'300'}},
}

neoscroll_config.set_mappings(scroll_mappings)
