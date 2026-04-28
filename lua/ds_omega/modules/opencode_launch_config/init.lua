local M = {}

M.setup = function()
    require('ds_omega.modules.opencode_launch_config.commands').create_user_command()
end

return M
