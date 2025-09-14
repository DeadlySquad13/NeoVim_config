---@class Item
---@field name (string) Name of the entry.
---@field path (string) Path (can be at first index).
---@field opts (table | nil) Telescope picker options.

---@alias Target Item|function

---@alias Targets table<Target>

---@param selected_target (Target)
local function run_edit_callback_for_target(selected_target)
  -- Special callback.
  if type(selected_target[1]) == 'function' then
    return selected_target[1]()
  end

  local path = selected_target[1] or selected_target.path
  local opts = selected_target.opts

  require('ds_omega.utils.file').open(path, opts or {})
end

---@param items (Targets)
local choose_and_edit_target = function(items)
  if vim.tbl_count(items) == 1 then
    return run_edit_callback_for_target(items[1])
  end

  --[[ local target_names = vim.tbl_map(
    function(value) return value.name end,
    vim.tbl_values(items)
  )
]]

  vim.ui.select(vim.tbl_keys(items), {
    prompt = 'Choose target to edit',
    format_item = function(item)
      return items[item].name
    end,
    telescope = require('telescope.themes').get_dropdown(),
  }, function(selected)
    if not selected then
      return
    end

    local selected_target = items[selected]

    run_edit_callback_for_target(selected_target)
  end)
end

return choose_and_edit_target
