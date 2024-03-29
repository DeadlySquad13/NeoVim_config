return {
    'smartpde/debuglog',

    config = function()
      local prequire = require('ds_omega.utils').prequire

      local debuglog_is_available, debuglog = prequire('debuglog')

      if not debuglog_is_available then
        return
      end

      -- Core, NullLs
      debuglog.enable('*')
    end,
}
