local M = {}
M.keymappings = require('ds_omega.config.Editing.dial.keymappings')

return {
  'monaqa/dial.nvim',

  opts = require('ds_omega.config.Editing.dial.settings'),

  keys = to_lazy_keys(M.keymappings),

  config = function(_, opts)
    local prequire = require('ds_omega.utils').prequire

    local config_is_available, config = prequire('dial.config')

    if not config_is_available then
      return
    end

    config.augends:register_group(opts)

    require('ds_omega.ds_omega_utils').apply_plugin_keymappings(M.keymappings)
  end,
}
