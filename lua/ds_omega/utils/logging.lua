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
---@function
---@param message string Message to display.
---@param level? integer Level of notification (see `:h vim.log.levels`).
---@param opts? table|nil Additional options for nvim.notify visualization (see `:h notify.Options`).

--- Notify user with nvim.notify. If it is not available, fallback to vim.notify.
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

---@class NotifierOptions
---@field title string
---@field skip_log boolean

---@class NotifyOptions: NotifierOptions
---@field msg string

---@alias MsgPayload string|NotifyOptions

---@class Notifier
---@field debug fun(self: Notifier, msg_payload: MsgPayload, ...: any)
---@field info fun(self: Notifier, msg_payload: MsgPayload, ...: any)
---@field warning fun(self: Notifier, msg_payload: MsgPayload, ...: any)
---@field error fun(self: Notifier, msg_payload: MsgPayload, ...: any)
---@field debug_once fun(self: Notifier, msg_payload: MsgPayload, ...: any)
---@field info_once fun(self: Notifier, msg_payload: MsgPayload, ...: any)
---@field warning_once fun(self: Notifier, msg_payload: MsgPayload, ...: any)
---@field error_once fun(self: Notifier, msg_payload: MsgPayload, ...: any)
---@field debug_throttled fun(self: Notifier, msg_payload: MsgPayload, ...: any)
---@field info_throttled fun(self: Notifier, msg_payload: MsgPayload, ...: any)
---@field warning_throttled fun(self: Notifier, msg_payload: MsgPayload, ...: any)
---@field error_throttled fun(self: Notifier, msg_payload: MsgPayload, ...: any)

---@class Logger
---@field name string
---@field _log_into table
---@field _default_notifier_opts table|nil
---@field debug fun(self: Logger, msg: string, ...: any)
---@field info fun(self: Logger, msg: string, ...: any)
---@field warning fun(self: Logger, msg: string, ...: any)
---@field error fun(self: Logger, msg: string, ...: any)
---@field set_log_into fun(self: Logger, log_into: TLogInto)
---@field get_notifier fun(self: Logger, opts?: NotifierOptions): Notifier
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

-- TODO: Currently modifies values of current instance. Create methods to
-- derive new instance of logger.
function Logger:set_log_into(log_into)
  self._log_into = log_into
end

--- Returns a Notifier that shows messages to user and logs under the hood.
function Logger:get_notifier(opts)
  ---@type NotifierOptions
  local notifier_opts = vim.tbl_deep_extend("force", self._default_notifier_opts or {}, opts or {})
  notifier_opts.title = notifier_opts.title or self.name

  ---
  ---@param level number
  ---@param notify_fn function(msg: string, level: number, notify_opts: NotifyOptions)
  ---@param msg_payload (MsgPayload)
  ---@param ... (any)
  local function do_notify(level, notify_fn, msg_payload, ...)
    local notify_opts = notifier_opts
    local msg = "Nothing in msg_payload payload"

    if type(msg_payload) == "table" then
      ---@cast notify_opts NotifyOptions
      notify_opts = vim.tbl_deep_extend("force", notify_opts, msg_payload)
      msg = msg_payload.msg
    elseif type(msg_payload) == "string" then
      msg = msg_payload
    else
      error("Wrong param type msg_payload passed to notfy")
      return
    end

    if not notify_opts.skip_log then
      log_to_dlog(self, level, msg, ...)
    end
    notify_fn(msg, level, notify_opts)
  end

  ---@class Notifier
  Notifier =
  {
    -- Base.
    debug = function(_self, msg_payload, ...)
      do_notify(LEVELS.DEBUG, notify, msg_payload, ...)
    end,
    info = function(_self, msg_payload, ...)
      do_notify(LEVELS.INFO, notify, msg_payload, ...)
    end,
    warning = function(_self, msg_payload, ...)
      do_notify(LEVELS.WARN, notify, msg_payload, ...)
    end,
    error = function(_self, msg_payload, ...)
      do_notify(LEVELS.ERROR, notify, msg_payload, ...)
    end,
    -- One-shot.
    debug_once = function(_self, msg_payload, ...)
      do_notify(LEVELS.DEBUG, logging.notify_once, msg_payload, ...)
    end,
    info_once = function(_self, msg_payload, ...)
      do_notify(LEVELS.INFO, logging.notify_once, msg_payload, ...)
    end,
    warning_once = function(_self, msg_payload, ...)
      do_notify(LEVELS.WARN, logging.notify_once, msg_payload, ...)
    end,
    error_once = function(_self, msg_payload, ...)
      do_notify(LEVELS.ERROR, logging.notify_once, msg_payload, ...)
    end,
    -- Throttled.
    debug_throttled = function(_self, msg_payload, ...)
      do_notify(LEVELS.DEBUG, logging.notify_throttled, msg_payload, ...)
    end,
    info_throttled = function(_self, msg_payload, ...)
      do_notify(LEVELS.INFO, logging.notify_throttled, msg_payload, ...)
    end,
    warning_throttled = function(_self, msg_payload, ...)
      do_notify(LEVELS.WARN, logging.notify_throttled, msg_payload, ...)
    end,
    error_throttled = function(_self, msg_payload, ...)
      do_notify(LEVELS.ERROR, logging.notify_throttled, msg_payload, ...)
    end,
  }

  return setmetatable({}, {
    __index = Notifier
  })
end

---@type fun(name: string, opts?: { log_into?: table, default_notifier_opts?: table }): Logger
logging.get_logger = Logger.new

logging.levels = LEVELS

return logging
