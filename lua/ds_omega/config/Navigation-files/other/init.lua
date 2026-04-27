local M = {}

M.opts = require('ds_omega.config.Navigation-files.other.settings')
M.keymappings = require('ds_omega.config.Navigation-files.other.keymappings')

---@type LazySpec
return {
  'DeadlySquad13/other.nvim',
  branch = 'create-file',

  opts = M.opts,

  keys = to_lazy_keys(M.keymappings),

  config = function(_, opts)
    require('other-nvim').setup(opts)

    local ds_omega_utils_is_available, ds_omega_utils = prequire('ds_omega.ds_omega_utils')
    if not ds_omega_utils_is_available then
      return
    end

    ds_omega_utils.apply_plugin_keymappings(M.keymappings)
  end,
}
