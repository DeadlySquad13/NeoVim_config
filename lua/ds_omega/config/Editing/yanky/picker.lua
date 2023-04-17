return function()
  local utils = require('yanky.utils')
  local mapping = require('yanky.telescope.mapping')

  return {
      --   Simple picker to perform quick action.
      -- See [select action yanky doc](https://github.com/gbprod/yanky.nvim#pickerselectacion)
      select = {
          backend = 'telescope',
          telescope = require('telescope.themes').get_cursor({
              layout_config = {
                  height = 13, -- 9 lines of put lines.
              },
          }),
      },

      -- General purpose command center for manipulating register contents.
      telescope = {
          mappings = {
              default = mapping.put('p'),
              i = {
                  -- ["<c-p>"] = mapping.put("p"),
                  -- ["<c-k>"] = mapping.put("P"),
                  ['<c-x>'] = mapping.delete(),
                  ['<c-r>'] = mapping.set_register(utils.get_default_register()),
              },
              n = {
                  p = mapping.put('p'),
                  P = mapping.put('P'),
                  d = mapping.delete(),
                  r = mapping.set_register(utils.get_default_register())
              },
          },
      }
  }
end
