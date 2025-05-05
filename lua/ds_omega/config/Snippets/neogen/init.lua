local M = {}

M.keymappings = require('ds_omega.config.Snippets.neogen.keymappings')

return {
  'danymat/neogen',

  dependencies = 'nvim-treesitter/nvim-treesitter',

  cmd = { 'Neogen func', 'Neogen file', 'Neogen class', 'Neogen type' },
  keys = to_lazy_keys(M.keymappings),

  opts = function()
    local settings_dir = 'ds_omega.config.Snippets.neogen.settings';

    local python = require(settings_dir .. '.python');
    --local lua = require(settings_dir .. '.lua');

    return {
      enabled = true,
      input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
      languages = {
        python = python,
        --lua = lua,
        --  },
      },
    }
  end,

  config = function(_, opts)
    local prequire = require('ds_omega.utils').prequire;

    local neogen_is_available, neogen = prequire('neogen');

    if not neogen_is_available then
      return;
    end

    neogen.setup(opts);

    local ds_omega_utils_is_available, ds_omega_utils = prequire('ds_omega.ds_omega_utils')

    if not ds_omega_utils_is_available then
      return
    end

    ds_omega_utils.apply_plugin_keymappings(M.keymappings)
  end
}
