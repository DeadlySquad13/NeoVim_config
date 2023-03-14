return {
  'monaqa/dial.nvim',

  opts = require('config.Editing.dial.settings'),

  config = function(_, opts)
    local prequire = require('utils').prequire

    local config_is_available, config = prequire('dial.config')

    if not config_is_available then
      return 
    end

    config.augends:register_group(opts)

    local keymappings = require('config.Editing.dial.keymappings')
    require('ds_omega.utils').apply_plugin_keymappings(keymappings)
  end,
}
