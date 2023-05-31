return {
  'ggandor/leap.nvim',

  opts = require('ds_omega.config.Navigation.leap.settings'),
  -- keys = require('ds_omega.config.Navigation.leap.keymappings'),

  config = function (_, opts)
    local leap_is_available, leap = require('ds_omega.ds_omega_utils').prequire_plugin('leap')
    if not leap_is_available then
      return
    end

    --   Should be  done in `leap.opt.key = value` fashion. Just assigning
    -- a table doesn't work.
    for key, setting in pairs(opts) do
      leap.opts[key] = setting
    end

    -- Without first parameter = true it won't override existing keymappings.
    leap.add_default_mappings()

    local ds_omega_utils_is_available, ds_omega_utils = prequire('ds_omega.ds_omega_utils')
    ds_omega_utils.apply_plugin_keymappings(require('ds_omega.config.Navigation.leap.keymappings'))
  end

  -- -- commands = {
  -- --   multi_normal = require('ds_omega.config.Navigation.leap.multi_normal'),
  -- -- }
}
