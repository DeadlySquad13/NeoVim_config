return {
  'gbprod/yanky.nvim',

  opts = require('config.Editing.yanky.settings'),

  config = function(_, opts)
    require('yanky').setup(opts)

    keymappings = require('config.Editing.yanky.keymappings')
    require('ds_omega.utils').apply_plugin_keymappings(keymappings)

    local prequire = require('utils').prequire

    local telescope_is_available, telescope = prequire('telescope')

    if telescope_is_available then
      telescope.load_extension('yank_history')
    end
  end,
}
