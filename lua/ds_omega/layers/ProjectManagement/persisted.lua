local simple_plugin_setup = require('ds_omega.utils').simple_plugin_setup

simple_plugin_setup('persisted', 'ProjectManagement')

-- To load the telescope extension.
local telescope_status_is_ok, telescope = prequire('telescope')

if not telescope_status_is_ok or not telescope then
  return
end

telescope.load_extension('persisted')
