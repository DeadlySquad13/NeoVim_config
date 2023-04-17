local prequire = require('ds_omega.utils').prequire

local substitute_is_available, substitute = prequire('substitute')

if not substitute_is_available or not substitute then
  return
end

local substitute_range = require('substitute.range')

-- Though of substitute as replacement so 'r'.
return {
  n = {
    r = { substitute.operator, 'Replace' },
    rs = { substitute.line, 'Replace line' },
    R = { substitute.eol, 'Replace to end of line' },

    --   There's prompt current text that may be useful:
    -- https://github.com/gbprod/substitute.nvim#rangeprompt_current_text

    ['<Leader>'] = {
      r = {
        function()
          substitute_range.operator({
            group_substituted_text = true,
          })
        end,
        'Replace range',
      },

      rr = {
        function()
          substitute_range.word({
            group_substituted_text = true,
          })
        end,
        'Replace word under cursor',
      },

      R = {
        function()
          substitute_range.operator({
            group_substituted_text = true,
            prefix = 'S',
          }) -- For abolish substituion.
        end,
        'Replace range'
      },
    },
  },

  x = {
    r = { substitute.visual, 'Replace', },
    ['<Leader>r'] = { substitute_range.visual, 'Replace range' },
  },
}
