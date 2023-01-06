-- Execution related utilities. They help interacting with your system.
local exec = {}

local exec_meta = {}

---@alias notify_opts (table|nil) Additional options for vim.notify / nvim.notify visualization (see `:h
--notify.Options`).

---  Execute command.
---@param command (table<string>|string) Command to execute.
---@param opts (table<string|notify_opts, any> | nil) Command options.
--Accepts options of jobstart(`h: jobstart`) and notify field for
--additional options for vim.notify / nvim.notify visualization (see `:h notify.Options`).
---@example:
-- exec({ 'run', 'go', '.'}, {
--   cwd = vim.fn.expand('%:h'),
--   notify = {
--     title = 'Run'
--   },
-- })
exec_meta.__call = function(self, command, opts)
  opts = opts or {}
  local command_opts = opts
  command_opts.notify = nil
  local notify_opts = opts.notify or {}

  local output = ""
  local notification
  local command_notify = function(msg, level)
    local merged_notify_opts = vim.tbl_extend(
      "keep",
      notify_opts,
      ---  It seems that `replace` helps to avoid ghost messages returned
      -- from on_stdout.
      { title = table.concat(command, " "), replace = notification }
    )
    notification = vim.notify(msg, level, merged_notify_opts)
  end

  local on_data = function(_, data)
    table.remove(data) -- Removing empty line at the end which represents final newline.
    output = output .. table.concat(data, "\n")
    command_notify(output, vim.log.levels.INFO)
  end
  local merged_command_opts = vim.tbl_extend('keep', command_opts, {
    cwd = vim.fn.expand('%:h'),
    on_stdout = on_data,
    on_stderr = on_data,
    on_exit = function(_, code)
      if #output == 0 then
        command_notify("No output of command, exit code: " .. code, vim.log.levels.WARN)
      end
    end,
  })

  vim.fn.jobstart(command, merged_command_opts)
end

setmetatable(exec, exec_meta)

exec.for_current_file = {}
local exec_for_current_file_meta = {}

---  Execute command in directory of the currently opened file.
-- Created this function to use go command in correct directory (directory of
-- the file) without cwd in vim.
---@param command (table<string>|string) command to execute.
---@param opts (table<string, any|notify_opts> | nil) Command options.
--Accepts options of jobstart(`h: jobstart`) and `notify` field for
--additional options for vim.notify / nvim.notify visualization (see `:h notify.Options`).
exec_for_current_file_meta.__call = function(self, command, opts)
  opts = opts or {}
  opts.cwd = vim.fn.expand('%:h')

  exec(command, opts)
end

setmetatable(exec.for_current_file, exec_for_current_file_meta)

return exec
