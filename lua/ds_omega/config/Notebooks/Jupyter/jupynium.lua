---@type LazySpec
return {
  'kiyoon/jupynium.nvim',

  event = require("ds_omega.constants.events").jupyter_notebooks,

  ---@type Jupynium.UserConfig
  opts = {
    python_host = { "pixi", "run", "python" },
  },

  config = function(_, opts)
    local prequire = require('ds_omega.utils').prequire

    local jupynium_is_available, jupynium = prequire('jupynium')

    if not jupynium_is_available then
      return
    end

    jupynium.setup(opts)

    local cmp_is_available, cmp = prequire('cmp')

    if not cmp_is_available then
      return
    end

    local config = cmp.get_config()
    table.insert(config.sources, 1, { name = 'jupynium' })

    cmp.setup(config)
  end,

  -- Use pipx instead. Or even better always install jupynium in venv.
  -- build = 'pip3 install --user .',
}
