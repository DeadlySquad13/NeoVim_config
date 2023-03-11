--------------------------------------------------------------------
-- The most often used utility functions. Reside in global scope. --
--------------------------------------------------------------------

local env = require('constants.env')

--  Prints prettily the data and returns it without any changes. Used for
--testing.
---@param data any data.
---@return data without changes.
_G.P = function(data)
  vim.pretty_print(data)
  return data
end

--- Notify user with nvim.notify. If it is not available, fallback to
--vim.notify.
---@param message (string) Message to display.
---@param level #Level of notification (see `:h vim.log.levels`).
---@param opts (table|nil) Additional options for nvim.notify visualization (see `:h
--notify.Options`).
_G.notify = function(message, level, opts)
  local nvim_notify_is_available, nvim_notify = pcall(require, 'notify')

  local notify = vim.notify
  if nvim_notify_is_available then
    notify = nvim_notify
  end

  notify(message, level, opts)
end

--- Protected require of the module.
---@param module_name (string)
---@return (boolean), module|nil)
local function prequire(module_name)
  local module_loading_error_handler = function(error)
    notify(
      'Error in loading module ' .. module_name .. '!',
      vim.log.levels.ERROR
    )
  end

  local status_ok, module = xpcall(
    require,
    module_loading_error_handler,
    module_name
  )

  if not status_ok then
    return status_ok, nil
  end

  return status_ok, module
end

_G.prequire = prequire

local outfile = string.format("%s/debug.log", vim.api.nvim_call_function("stdpath", {"data"}))

-- See [debuglog source](https://github.com/smartpde/debuglog/blob/main/lua/debuglog.lua).
_G.log = function(name, hl, opts)
  local debuglog_is_available, debuglog = prequire('debuglog')

  --   dlog is just a shim to a debuglog plugin. It won't work until plugin is
  -- loaded therefore I can't use logging before plugins loading.
  if debuglog_is_available then
    -- FIX: Somehow it's delayed if invoked in layer configurations.
    debuglog.enable(name)
    return require('utils.dlog')(name, hl, opts)
  end

  return function(...)
    if LOG_INTO.messages then
      local message = string.format(...)
      vim.api.nvim_echo({
        {os.date("%H:%M:%S:")}, {" "}, {name},
        {": "}, {message}
      }, true, {})
    end
    if LOG_INTO.file then
      local fp = io.open(outfile, "a")
      local str = os.date("%H:%M:%S: ") .. string.format(...) .. "\n"

      if not fp then
        return
      end

      fp:write(str)
      fp:close()
    end
  end
end

