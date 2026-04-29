local M = {}

M.setup = function()
    require('ds_omega.modules.opencode_launcher.commands').create_user_command()
end

return M
