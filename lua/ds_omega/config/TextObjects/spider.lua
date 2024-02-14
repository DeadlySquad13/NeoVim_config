-- TODO: Add separate mappings as smartword alternative.
return {
  'chrisgrieser/nvim-spider',
  -- event = 'VimEnter',

  --[[ config = function()
    local Hydra = require('hydra')

    -- Reference: [Hydra wiki](https://github.com/anuvyklack/hydra.nvim/wiki/Quick-words)
    Hydra({
       name = 'Quick words',
       config = {
          color = 'pink',
          hint = {
            type = 'statusline',
          },
       },
       mode = { 'n','x','o' },
       body = ',',
       heads = {
          { 'w', '<Plug>WordMotion_w' },
          { 'b', '<Plug>WordMotion_b' },
          { 'e', '<Plug>WordMotion_e' },
          { 'ge', '<Plug>WordMotion_ge' },

          { '<Esc>', nil, { exit = true, mode = 'n' } }
       }
    }) ]]

    --[[ Hydra({
       name = 'Quick words',
       config = {
          color = 'pink',
          hint = {
            type = 'statusline',
          },
       },
       mode = { 'x','o' },
       body = ',',
       heads = {
          { 'iw', '<Plug>WordMotion_W' },
          { 'iW', '<Plug>WordMotion_iW' },

          { '<Esc>', nil, { exit = true, mode = 'n' } }
       }
    }) ]]
  -- end,
}
