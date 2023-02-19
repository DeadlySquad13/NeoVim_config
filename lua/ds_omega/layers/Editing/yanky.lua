local simple_plugin_setup = require('ds_omega.utils').simple_plugin_setup

simple_plugin_setup('yanky', 'Editing')

local prequire = require('utils').prequire

local telescope_is_available, telescope = prequire('telescope')

if telescope_is_available then
  telescope.load_extension('yank_history')
end
