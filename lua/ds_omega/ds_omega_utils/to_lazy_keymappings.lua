--- 
---@param keymappings (table<Mode, table>)
local function to_lazy_keymappings(keymappings)
  for mode, keymappings_for_mode in pairs(keymappings) do
    require('ds_omega.config.Ui.which_key.utils').to_lazy_keymappings(mode, keymappings_for_mode)
  end
end

return to_lazy_keymappings
