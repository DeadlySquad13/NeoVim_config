local prequire = require('ds_omega.utils').prequire

local leap_is_available, leap = prequire('leap')

if not leap_is_available then
  return 
end

--   see [multi-cursor ':normal'](https://github.com/ggandor/leap.nvim#calling-leap-with-custom-arguments)
--   The following example showcases a custom action, using `multiselect`. We're
-- executing a `normal!` command at each selected position (this could be even
-- more useful if we'd pass in custom targets too).
function multi_normal(targets)
  -- Get the :normal sequence to be executed.
  local input = vim.fn.input("normal! ")
  if #input < 1 then return end

  local ns = vim.api.nvim_create_namespace("")

  --   Set an extmark as an anchor for each target, so that we can also execute
  -- commands that modify the positions of other targets (insert/change/delete).
  for _, target in ipairs(targets) do
    local line, col = unpack(target.pos)
    id = vim.api.nvim_buf_set_extmark(0, ns, line - 1, col - 1, {})
    target.extmark_id = id
  end

  --   Jump to each extmark (anchored to the "moving" targets), and execute the
  -- command sequence.
  for _, target in ipairs(targets) do
    local id = target.extmark_id
    local pos = vim.api.nvim_buf_get_extmark_by_id(0, ns, id, {})
    vim.fn.cursor(pos[1] + 1, pos[2] + 1)
    vim.cmd("normal! " .. input)
  end

  -- Clean up the extmarks.
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

-- Usage:
local create_user_command = require('ds_omega.commands.utils').create_user_command

create_user_command(
  'MultiNormal',
  function()
    leap.leap({
      target_windows = { vim.fn.win_getid() },
      action = multi_normal,
      multiselect = true,
    })
  end,
  { nargs = 0 }
)

return multi_normal
