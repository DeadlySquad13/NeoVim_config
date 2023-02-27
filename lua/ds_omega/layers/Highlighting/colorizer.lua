local utils = require('ds_omega.utils')

local settings = utils.get_plugin_config('colorizer', 'Highlighting')

local colorizer_is_available, colorizer = prequire('colorizer')

if not colorizer_is_available then
  return
end

colorizer.setup(settings.filetype, settings.global)
