---@type LazySpec
return {
  'ggandor/flit.nvim',
  dependencies = 'leap.nvim',

  event = require('ds_omega.constants.events').lazy_file,

  -- Don't lazy-load it by keys as flit and leap lazy-loads it by itself.
  -- https://github.com/ggandor/leap.nvim/issues/191

  opts = function()
    local leap_settings = require('ds_omega.config.Navigation.leap.settings')

    return {
      keys = {
        f = 'w', F = 'W',
        t = 'k', T = 'K',
      },
      labeled_modes = 'vo',
      multiline = false,
      opts = {
        safe_labels = leap_settings.safe_labels,
      }
    }
  end,
}
