return {
  'luk400/vim-jukit',
  enabled = false,

  opts = require('ds_omega.config.Notebooks.Jupyter.jukit.settings'),
  -- keys = require('ds_omega.config.Jupyter.jukit.keymappings'),

  config = function(_, opts)
    local utils = require('ds_omega.utils')

    local _, keymappings = utils.get_plugin_config('jukit', 'Notebooks.Jupyter')

    require('ds_omega.utils.setters').set_global_variables(opts)

    if keymappings then
      utils.apply_plugin_keymappings(keymappings)
    end
  end,
}
