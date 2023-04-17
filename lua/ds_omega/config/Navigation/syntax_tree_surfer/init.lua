return {
  'ziontee113/syntax-tree-surfer',
  opts = require('ds_omega.config.Navigation.syntax_tree_surfer.settings'),

  config = function(_, opts)
    local ds_omega_utils_is_available, ds_omega_utils = prequire('ds_omega.ds_omega_utils')
    if not ds_omega_utils_is_available then
      return
    end

    ds_omega_utils.apply_plugin_keymappings(require('ds_omega.config.Navigation.syntax_tree_surfer.keymappings'))

    require('syntax-tree-surfer').setup(opts)
  end,
}
