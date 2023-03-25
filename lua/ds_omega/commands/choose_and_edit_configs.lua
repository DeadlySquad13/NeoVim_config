local choose_and_edit_target = require('ds_omega.commands.choose_and_edit_target')

local function choose_and_edit_configs()
  local items = require('config.choose_and_edit_target')
  choose_and_edit_target(items)
end

return choose_and_edit_configs
