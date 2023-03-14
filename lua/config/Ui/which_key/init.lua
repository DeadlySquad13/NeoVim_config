return {
  'folke/which-key.nvim',

  opts = require('config.Ui.which_key.settings'),
  config = function(_, opts)
    require('which-key').setup(opts)

    local apply_keymappings = require('config.Ui.which_key.utils').apply_keymappings

    local mappings = require('config.keymappings')

    for mode, mode_mappings in pairs(mappings) do
        apply_keymappings(mode, mode_mappings)
    end
  end
}
