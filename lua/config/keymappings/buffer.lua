local Hydra = require('hydra')

local cmd = require('hydra.keymap-util').cmd
local pcmd = require('hydra.keymap-util').pcmd

local common_keymappings = {
  -- Navigation.
  h = { cmd 'BufferLineCyclePrev' },
  l = { cmd 'BufferLineCycleNext' },

  -- Moving buffers.
  H = { cmd 'BufferLineMovePrev', 'Move left' },
  L = { cmd 'BufferLineMoveNext', 'Move right' },

  P = { cmd 'BufferLineTogglePin', 'Toggle Pin' },

  -- Deletes buffer without closing vim if it was in the only window.
  d = { cmd 'Bdelete', 'Delete' },
  z = { cmd '%bdelete|edit#', 'Delete all buffer except for current one' },

  --see the [lua api](https://github.com/akinsho/bufferline.nvim/blob/main/lua/bufferline.lua)
  --p = { function() bufferline.pick_buffer() end, 'Pick' },
  -- Picking.
  p = { function() vim.cmd('BufferLinePick') end, 'Pick' },

  -- Sorting.
  s = { cmd 'bufferLineSortByRelativeDirectory', 'Sort by relative directory' },
}

local function transform_to_hydra(key)
  local keymapping = common_keymappings[key]

  return { key, keymapping[1], { desc = keymapping[2] } }
end

local buffer_hydra = Hydra({
  name = 'Buffer',
  heads = vim.tbl_extend('force', vim.tbl_map(transform_to_hydra, vim.tbl_keys(common_keymappings)), {
    { 'p', function() vim.cmd('BufferLinePick') end, { desc = 'Pick' } },

    { '<Esc>', nil, { exit = true } }
  }),
})

--- Activate only when there're multiple buffers.
local function activate_buffer_hydra()
  if #vim.fn.getbufinfo({ buflisted = true }) > 1 then
    buffer_hydra:activate()
  end
end

return vim.tbl_extend('error', common_keymappings, {
  name = 'Buffer',

  [require('config.keymappings._common.constants').transitive_catalizator] = {
    activate_buffer_hydra,
    'Activate window mode'
  },
})
