return {
    'danymat/neogen',

    dependencies = 'nvim-treesitter/nvim-treesitter',

    opts = function()
      local settings_dir = 'config.Snippets.neogen.settings';

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
      local prequire = require('utils').prequire;

      local neogen_is_available, neogen = prequire('neogen');

      if not neogen_is_available then
        return;
      end

      neogen.setup(opts);
    end
}
