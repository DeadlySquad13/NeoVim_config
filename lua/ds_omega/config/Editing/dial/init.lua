return {
  'monaqa/dial.nvim',

  opts = require('ds_omega.config.Editing.dial.settings'),

  config = function(_, opts)
    local prequire = require('ds_omega.utils').prequire

    local config_is_available, config = prequire('dial.config')

    if not config_is_available then
      return 
    end

    config.augends:register_group(opts)

    local keymappings = require('ds_omega.config.Editing.dial.keymappings')
    require('ds_omega.ds_omega_utils').apply_plugin_keymappings(keymappings)
  end,
}
