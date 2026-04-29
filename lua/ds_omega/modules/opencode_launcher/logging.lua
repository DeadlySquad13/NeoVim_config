local M = {}

M.log = log("Opencode")

---@param message (string) Message to display.
---@param level? (vim.log.levels)
M.notify = function(msg, level)
    notify(msg, level or vim.log.levels.DEBUG, { title = "Opencode" })
end

---@param message (string) Message to display.
---@param level? (vim.log.levels)
M.notify_once = function(msg, level)
    notify_once(msg, level or vim.log.levels.DEBUG, { title = "Opencode" })
end
return M
