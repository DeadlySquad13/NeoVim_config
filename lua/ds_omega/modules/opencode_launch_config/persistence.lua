local M = {}

M.read_launch_config = function()
    local f = io.open(require('ds_omega.modules.opencode_launch_config.config').CONFIG_FILE, "r")
    if not f then
        return require('ds_omega.modules.opencode_launch_config.config').DEFAULT_LAUNCH_MODE
    end
    local mode = f:read("*a"):gsub("%s+", ""):gsub("\n", "")
    f:close()
    if mode == "" then
        return require('ds_omega.modules.opencode_launch_config.config').DEFAULT_LAUNCH_MODE
    end
    return mode
end

M.write_launch_config = function(mode)
    local f = io.open(require('ds_omega.modules.opencode_launch_config.config').CONFIG_FILE, "w")
    if not f then
        require('ds_omega.modules.opencode_launch_config.logging').notify_once(
            "Failed to open config file for writing", vim.log.levels.ERROR
        )
        return
    end
    f:write(mode)
    f:close()
end

return M
