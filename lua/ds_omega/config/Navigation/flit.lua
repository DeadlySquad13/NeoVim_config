return {
  'ggandor/flit.nvim',
  dependencies = 'leap.nvim',

  opts = function()
    local leap_settings = require('ds_omega.config.Navigation.leap.settings')

    return {
      labeled_modes = 'vo',
      multiline = false,
      opts = {
        safe_labels = leap_settings.safe_labels,
      }
    }
  end,

  config = true,
}
