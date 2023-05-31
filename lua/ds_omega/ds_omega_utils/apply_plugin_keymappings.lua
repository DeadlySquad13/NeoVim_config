--- 
---@param keymappings (table<Mode, table>)
local function apply_plugin_keymappings(keymappings)
  for mode, keymappings_for_mode in pairs(keymappings) do
    require('ds_omega.config.Ui.which_key.utils').apply_keymappings_once_ready(mode, keymappings_for_mode)
  end
end

return apply_plugin_keymappings
