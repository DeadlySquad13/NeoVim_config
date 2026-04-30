local logging = {}

local outfile = string.format("%s/debug.log", vim.api.nvim_call_function("stdpath", { "data" }))

local inspect_items = function(...)
  local info_items = { ... }

  local formatted_info_items = vim.tbl_map(vim.inspect, info_items)
  local info_message = table.concat(formatted_info_items, " ")

  return info_message
end

--- See [debuglog source](https://github.com/smartpde/debuglog/blob/main/lua/debuglog.lua).
-- TODO: Fork and implement hl, level and custom opts.
logging.log = function(name, hl, opts)
  local debuglog_is_available = prequire('debuglog')

  if debuglog_is_available then
    local debuglog = require('debuglog')
    debuglog.enable(name)
    local dlog = require("ds_omega.utils.dlog").logger(name)

    return function(...)
      dlog(inspect_items(...))
    end
  end

  return function(...)
    local LOG_INTO = require("ds_omega.constants.env").LOG_INTO
    local info_message = inspect_items(...)

    if LOG_INTO.messages then
      vim.api.nvim_echo({
        { os.date("%H:%M:%S:") }, { " " }, { name },
        { ": " }, { info_message }
      }, true, {})
    end
    if LOG_INTO.file then
      local fp = io.open(outfile, "a")
      local str = os.date("%H:%M:%S: ") .. info_message .. "\n"

      if not fp then
        return
      end

      fp:write(str)
      fp:close()
    end
  end
end

local LEVELS = {
  DEBUG = vim.log.levels.DEBUG,
  INFO = vim.log.levels.INFO,
  WARN = vim.log.levels.WARN,
  ERROR = vim.log.levels.ERROR,
}

local LEVEL_HL_MAP = {
  [LEVELS.DEBUG] = "Comment",
  [LEVELS.INFO] = "Normal",
  [LEVELS.WARN] = "WarningMsg",
  [LEVELS.ERROR] = "ErrorMsg",
}

local LEVEL_NAMES = {
  [LEVELS.DEBUG] = "DEBUG",
  [LEVELS.INFO] = "INFO",
  [LEVELS.WARN] = "WARN",
  [LEVELS.ERROR] = "ERROR",
}

--- Prints prettily the data and returns it without any changes. Used for testing.
---@param data any
---@return any
logging.P = function(data)
  vim.print(data)
  return data
end

--- Notify user with nvim.notify. If it is not available, fallback to vim.notify.
---@param message string Message to display.
---@param level? integer Level of notification (see `:h vim.log.levels`).
---@param opts? table|nil Additional options for nvim.notify visualization (see `:h notify.Options`).
logging.notify = function(message, level, opts)
  local nvim_notify_is_available, nvim_notify = pcall(require, "notify")

  local notify = vim.notify
  if nvim_notify_is_available then
    notify = nvim_notify
  end

  local formatted_message = message

  if type(message) ~= "string" then
    formatted_message = vim.inspect(message)
  end

  notify(formatted_message, level, opts)
end

logging.notify_once = vim.notify_once

--- Notify user with nvim.notify. Notifications are throttled on a leading edge with 5s time window.
---@param message string Message to display.
---@param level? integer Level of notification (see `:h vim.log.levels`).
---@param opts? table|nil Additional options for nvim.notify visualization (see `:h notify.Options`).
logging.notify_throttled = require("ds_omega.utils.defer").throttle_leading(logging.notify, 5000)

---@class Notifier
---@field debug fun(self: Notifier, msg: string, ...: any)
---@field info fun(self: Notifier, msg: string, ...: any)
---@field warning fun(self: Notifier, msg: string, ...: any)
---@field error fun(self: Notifier, msg: string, ...: any)
---@field debug_once fun(self: Notifier, msg: string, ...: any)
---@field info_once fun(self: Notifier, msg: string, ...: any)
---@field warning_once fun(self: Notifier, msg: string, ...: any)
---@field error_once fun(self: Notifier, msg: string, ...: any)
---@field debug_throttled fun(self: Notifier, msg: string, ...: any)
---@field info_throttled fun(self: Notifier, msg: string, ...: any)
---@field warning_throttled fun(self: Notifier, msg: string, ...: any)
---@field error_throttled fun(self: Notifier, msg: string, ...: any)

---@class Logger
---@field name string
---@field _log_into table
---@field _default_notifier_opts table|nil
---@field debug fun(self: Logger, msg: string, ...: any)
---@field info fun(self: Logger, msg: string, ...: any)
---@field warning fun(self: Logger, msg: string, ...: any)
---@field error fun(self: Logger, msg: string, ...: any)
---@field set_log_into fun(self: Logger, log_into: TLogInto)
---@field get_notifier fun(self: Logger, opts?: table): Notifier

local Logger = {}
Logger.__index = Logger

function Logger.new(name, opts)
  opts = opts or {}
  return setmetatable({
    name = name,
    _log_into = opts.log_into or require("ds_omega.constants.env").LOG_INTO,
    _default_notifier_opts = opts.default_notifier_opts,
  }, Logger)
end

local function log_to_dlog(logger, level, msg, ...)
  -- TODO: Currently levels are not implemented in debuglog so we have to hack
  -- it using a compound name.
  local logger_level_name = string.format("[%s] %s", LEVEL_NAMES[level], logger.name)

  local dlog = logging.log(logger_level_name, LEVEL_HL_MAP[level], {
    LOG_INTO = logger._log_into,
    hl = LEVEL_HL_MAP[level],
  })
  dlog(msg, ...)
end

function Logger:debug(msg, ...)
  log_to_dlog(self, LEVELS.DEBUG, msg, ...)
end

function Logger:info(msg, ...)
  log_to_dlog(self, LEVELS.INFO, msg, ...)
end

function Logger:warning(msg, ...)
  log_to_dlog(self, LEVELS.WARN, msg, ...)
end

function Logger:error(msg, ...)
  log_to_dlog(self, LEVELS.ERROR, msg, ...)
end

function Logger:set_log_into(log_into)
  self._log_into = log_into
end

--- Returns a Notifier that shows messages to user and logs under the hood.
function Logger:get_notifier(opts)
  local title = self.name
  local notifier_opts = vim.tbl_deep_extend("force", self._default_notifier_opts or {}, opts or {})
  notifier_opts.title = notifier_opts.title or title

  local function do_notify(level, notify_fn, msg, ...)
    log_to_dlog(self, level, msg, ...)
    notify_fn(msg, level, notifier_opts)
  end

  return setmetatable({}, {
    __index = {
      debug = function(_self, msg, ...)
        do_notify(LEVELS.DEBUG, notify, msg, ...)
      end,
      info = function(_self, msg, ...)
        do_notify(LEVELS.INFO, notify, msg, ...)
      end,
      warning = function(_self, msg, ...)
        do_notify(LEVELS.WARN, notify, msg, ...)
      end,
      error = function(_self, msg, ...)
        do_notify(LEVELS.ERROR, notify, msg, ...)
      end,
      debug_once = function(_self, msg, ...)
        do_notify(LEVELS.DEBUG, logging.notify_once, msg, ...)
      end,
      info_once = function(_self, msg, ...)
        do_notify(LEVELS.INFO, logging.notify_once, msg, ...)
      end,
      warning_once = function(_self, msg, ...)
        do_notify(LEVELS.WARN, logging.notify_once, msg, ...)
      end,
      error_once = function(_self, msg, ...)
        do_notify(LEVELS.ERROR, logging.notify_once, msg, ...)
      end,
      debug_throttled = function(_self, msg, ...)
        do_notify(LEVELS.DEBUG, logging.notify_throttled, msg, ...)
      end,
      info_throttled = function(_self, msg, ...)
        do_notify(LEVELS.INFO, logging.notify_throttled, msg, ...)
      end,
      warning_throttled = function(_self, msg, ...)
        do_notify(LEVELS.WARN, logging.notify_throttled, msg, ...)
      end,
      error_throttled = function(_self, msg, ...)
        do_notify(LEVELS.ERROR, logging.notify_throttled, msg, ...)
      end,
    }
  })
end

---@type fun(name: string, opts?: { log_into?: table, default_notifier_opts?: table }): Logger
logging.get_logger = Logger.new

logging.levels = LEVELS

return logging
