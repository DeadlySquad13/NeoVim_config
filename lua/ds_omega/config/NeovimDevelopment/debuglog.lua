---@type LazySpec
return {
  'smartpde/debuglog',

  config = function()
    local debuglog_is_available = prequire('debuglog')

    if not debuglog_is_available then
      return
    end

    local debuglog = require('debuglog')

    local LOG_INTO = require('ds_omega.constants.env').LOG_INTO
    debuglog.setup({
      log_to_console = LOG_INTO.messages or false,
      log_to_file = LOG_INTO.file or false,
      -- The highlight group for printing the time column in console
      time_hl_group = "Comment",
    })

    -- Core, NullLs
    debuglog.enable('*')
  end,
}
