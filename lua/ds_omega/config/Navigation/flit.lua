return {
  'ggandor/flit.nvim',
  dependencies = 'leap.nvim',

  opts = function()
    local leap_settings = require('ds_omega.config.Navigation.leap.settings')

    return {
      keys = { f = 'h', F = 'H', t = 'k', T = 'K' },
      labeled_modes = 'vo',
      multiline = false,
      opts = {
        safe_labels = leap_settings.safe_labels,
      }
    }
  end,

  config = true,
}
