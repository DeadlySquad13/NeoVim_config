local M = {}

local logging = require('ds_omega.modules.opencode_launch_config.logging')

M.DEFAULT_PATH_MAP = function(self, host_path)
    return host_path
end

M.DEFAULT_SPAWN_COMMAND = function(self, port, url)
    return true
end

M.DEFAULT_KILL_COMMAND = function(self, env_name)
    return true
end

---@class OpencodeOpenStrategyConfig
---@field name string
---@field path_map function
---@field spawn_command function
---@field kill_command function

---@class OpencodeOpenStrategy
---@field name string
---@field path_map function
---@field spawn_command function
---@field kill_command function

---
---@param config (OpencodeOpenStrategyConfig)
---@return (boolean) result Has validation passed
local function validate_config(config)
    local is_function = require('ds_omega.utils').is_function
    if not config then
        logging.notify("No strategy config provided", vim.log.levels.ERROR)
        return false
    end

    if type(config) ~= "table" then
        logging.notify("Strategy config must be a table", vim.log.levels.ERROR)
        return false
    end

    if not config.spawn_command or not is_function(config.spawn_command) then
        logging.notify("spawn_command must be a function", vim.log.levels.ERROR)
        config.spawn_command = DEFAULT_SPAWN_COMMAND
    end

    if not config.path_map or not is_function(config.path_map) then
        logging.notify("path_map must be a function", vim.log.levels.ERROR)
        config.path_map = DEFAULT_PATH_MAP
    end

    if not config.kill_command or not is_function(config.kill_command) then
        logging.notify("kill_command must be a function", vim.log.levels.ERROR)
        config.kill_command = DEFAULT_KILL_COMMAND
    end

    if config.name then
        logging.notify(string.format("Custom strategy using environment: %s", config.name))
    else
        logging.notify("Custom strategy without specific environment name")
    end

    return true
end

---
---@param config (OpencodeOpenStrategyConfig)
---@return (OpencodeOpenStrategy) strategy
M.create_custom_strategy = function(config)
    validate_config(config)
    local name = config.name or "custom"
    logging.log(string.format("Creating custom strategy: %s", name))

    return setmetatable({
        name = name,
        spawn_command = config.spawn_command or DEFAULT_SPAWN_COMMAND,
        path_map = config.path_map or DEFAULT_PATH_MAP,
        kill_command = config.kill_command or DEFAULT_KILL_COMMAND
    }, {
        __index = function(t, k)
            if k == "path_map" then
                return t.path_map
            elseif k == "spawn_command" then
                logging.notify(string.format("Starting OpenCode strategy: %s", name))
                return t.spawn_command
            elseif k == "kill_command" then
                local name = name
                logging.notify(string.format("Stopping OpenCode strategy: %s", name))
                return t.kill_command(name)
            end
        end
    })
end

---
---@param mode string
---@return (OpencodeOpenStrategy) strategy
M.create_strategy = function(mode)
    local strategies_index = IndexBy(require('ds_omega.modules.opencode_launch_config.strategies.config').strategies, 'name')

    local strategy_for_current_mode = strategies_index[mode]

    if strategy_for_current_mode then
        return strategy_for_current_mode
    end

    return M.create_custom_strategy {
        name = require('ds_omega.modules.opencode_launch_config.config').DEFAULT_LAUNCH_MODE,
        spawn_command = DEFAULT_SPAWN_COMMAND,
        path_map = DEFAULT_PATH_MAP,
        kill_command = DEFAULT_KILL_COMMAND
    }
end

M.get_strategy = function()
    local mode = require('ds_omega.modules.opencode_launch_config.persistence').read_launch_config()
    logging.notify_once(string.format("Using strategy corresponding to selected mode: %s", mode), vim.log.levels.INFO)

    return M.create_strategy(mode)
end

--- 
---@param strategy 
---@return (table<string>) strategies Available strategies (names)
M.get_available_strategies = function()
    return vim.tbl_map(function(strategy)
        return strategy.name
    end, require('ds_omega.modules.opencode_launch_config.strategies.config').strategies)
end

return M
