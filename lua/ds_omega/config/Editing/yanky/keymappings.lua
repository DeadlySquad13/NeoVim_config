---
---@param type (string)
---@param mode ('n' | 'x')
---@param modifier? ('ShiftRight' | 'ShiftLeft' | 'Filter')
local function with_preserved_position(type, mode, modifier)
  local yanky_wrappers = require('yanky.wrappers')
  local Type = {
      PutAfter = 'p',
      PutBefore = 'P',
      GPutAfter = 'gp',
      GPutBefore = 'gP',
      PutIndentAfter = ']p',
      PutIndentBefore = '[p',
  }
  local Modifier = {
      ShiftRight = '>>',
      ShiftLeft = '<<',
      Filter = '==',
  }

  return function()
    local col = vim.fn.getpos('.')[3]

    local callback

    if not modifier then
      callback = yanky_wrappers.linewise()
    else
      local change_modifier = yanky_wrappers.change(Modifier[modifier])
      callback = yanky_wrappers.linewise(change_modifier)
    end

    require('yanky').put(Type[type], mode == 'x', callback)

    local line
    if string.find(type, 'Before') then
      -- '] - gives us last line of the last edited (put) text.
      -- We need to go one line below it.
      line = vim.fn.getpos("']")[2] + 1
    else
      -- '[ - gives us first line of the last edited (put) text.
      -- We need to go one line above it.
      line = vim.fn.getpos("'[")[2] - 1
    end

    ---@diagnostic disable-next-line: redundant-parameter, param-type-mismatch
    vim.fn.cursor(line, col)
  end
end

---
---@param mode ('n' | 'x')
---@return
local function get_put_keymappings(mode)
  -- Idiomatic '[' and ']' are hard to type so I have chosen 'z' and 'c':
  -- 'z' and 'c' are both operators so their combination with another operator such
  -- as 'p' or 'P' don't exist. Only 'zp' and 'zP' are bound for some rare block pastes.
  return {
      p = { '<Plug>(YankyPutAfter)', 'Put after' },
      P = { '<Plug>(YankyPutBefore)', 'Put before' },
      ['[p'] = { '<Plug>(YankyGPutAfter)', 'G put after' },
      ['[P'] = { '<Plug>(YankyGPutBefore)', 'G put before' },
      -- Adjust indent to the current line.
      -- - Stay on pasted line.
      ['z'] = {
          p = { '<Plug>(YankyPutIndentAfterLinewise)', 'Put after and adjust the indent to the current line' },
          P = { '<Plug>(YankyPutIndentBeforeLinewise)', 'Put before and adjust the indent to the current line' },
      },
      -- - Stay on current line.
      ['m'] = {
          p = {
              with_preserved_position('PutIndentAfter', mode),
              'Put after (adjusted to current line) but stay on current line'
          },
          P = {
              with_preserved_position('PutIndentBefore', mode),
              'Put before (adjusted to current line) but stay on current line',
          },
      },
      -- Indent right.
      ['>'] = {
          -- Stay on pasted line.
          ['z'] = {
              p = { '<Plug>(YankyPutIndentAfterShiftRight)', 'Put after and adjust the indent to the current line' },
              P = { '<Plug>(YankyPutIndentBeforeShiftRight)', 'Put before and adjust the indent to the current line' },
          },
          -- - Stay on current line.
          ['m'] = {
              p = {
                with_preserved_position('PutIndentAfter', mode, 'ShiftRight'),
                'Put after (adjusted to current line) but stay on current line',
                noremap = false,
              },
              P = {
                with_preserved_position('PutIndentBefore', mode, 'ShiftRight'),
                'Put before (adjusted to current line) but stay on current line',
                noremap = false,
              },
          },
      },
  }
end

return {
    n = vim.tbl_extend('error', get_put_keymappings('n'), {
        ['<C-n>'] = { '<Plug>(YankyCycleForward)', 'Cycle forward yank history' },
        ['<C-p>'] = { '<Plug>(YankyCycleBackward)', 'Cycle backward yank history' },
    }),
    x = get_put_keymappings('x'),
}
