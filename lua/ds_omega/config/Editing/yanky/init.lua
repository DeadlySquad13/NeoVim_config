return {
  'gbprod/yanky.nvim',

  opts = require('ds_omega.config.Editing.yanky.settings'),

  config = function(_, opts)
    require('yanky').setup(opts)

    local keymappings = require('ds_omega.config.Editing.yanky.keymappings')
    require('ds_omega.ds_omega_utils').apply_plugin_keymappings(keymappings)

    local prequire = require('ds_omega.utils').prequire

    local telescope_is_available, telescope = prequire('telescope')

    if telescope_is_available then
      telescope.load_extension('yank_history')
    end
  end,
}
