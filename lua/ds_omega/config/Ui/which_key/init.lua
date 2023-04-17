return {
  'folke/which-key.nvim',

  opts = require('ds_omega.config.Ui.which_key.settings'),
  config = function(_, opts)
    require('which-key').setup(opts)

    local apply_keymappings = require('ds_omega.config.Ui.which_key.utils').apply_keymappings

    local mappings = require('ds_omega.config.keymappings')

    for mode, mode_mappings in pairs(mappings) do
        apply_keymappings(mode, mode_mappings)
    end
  end
}
