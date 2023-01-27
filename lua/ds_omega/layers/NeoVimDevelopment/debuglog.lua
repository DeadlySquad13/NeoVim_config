local simple_plugin_setup = require('ds_omega.utils').simple_plugin_setup

local debuglog_is_available,debuglog = simple_plugin_setup('debuglog', 'NeoVimDevelopment')

if not debuglog_is_available then
  return
end

P(debuglog)

-- Core, NullLs
debuglog.enable("*")
