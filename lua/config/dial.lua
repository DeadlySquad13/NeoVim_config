local prequire = require('utils').prequire

local dial_map_is_available, dial_map = prequire('dial.map')

if not dial_map_is_available then
  return 
end

vim.api.nvim_set_keymap("n", "<C-a>", dial_map.inc_normal(), {noremap = true})
vim.api.nvim_set_keymap("n", "<C-x>", dial_map.dec_normal(), {noremap = true})
vim.api.nvim_set_keymap("v", "<C-a>", dial_map.inc_visual(), {noremap = true})
vim.api.nvim_set_keymap("v", "<C-x>", dial_map.dec_visual(), {noremap = true})
vim.api.nvim_set_keymap("v", "g<C-a>",dial_map.inc_gvisual(), {noremap = true})
vim.api.nvim_set_keymap("v", "g<C-x>",dial_map.dec_gvisual(), {noremap = true})

local augend_is_available, augend = prequire('dial.augend')

if not augend_is_available then
  return 
end

require("dial.config").augends:register_group{
  -- default augends used when no group name is specified
  default = {
    augend.constant.alias.bool,    -- boolean value (true <-> false)
    augend.integer.alias.decimal,   -- nonnegative decimal number (0, 1, 2, 3, ...)
    augend.integer.alias.hex,       -- nonnegative hex number  (0x01, 0x1a1f, etc.)
    augend.date.alias["%Y/%m/%d"],  -- date (2022/02/19, etc.)
  },
}
