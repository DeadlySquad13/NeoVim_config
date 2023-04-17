local telescope_builtin = require('telescope.builtin')

local KEY = require('config.keymappings._common.constants').KEY

return {
  name = 'Navigation',
  -- * Telescope.
  n = {
    function()
      telescope_builtin.resume()
    end,
    'Resume'
  },
  f = {
    function()
      telescope_builtin.find_files()
    end,
    'Find in current directory',
  },
  F = {
    ':RnvimrToggle<cr>',
    'Files via Rnvimr'
  },
  -- s = {
  --   require('session-lens').search_session()
  --   'Session search',
  -- },
  g = {
    function()
      telescope_builtin.live_grep()
    end,
    'Live grep',
  },
  b = {
    function()
      telescope_builtin.buffers()
    end,
    'Buffers',
  },
  h = {
    function()
      telescope_builtin.help_tags()
    end,
    'Help tags',
  },
  t = {
    function()
      telescope_builtin.treesitter()
    end,
    'Treesitter',
  },

  [KEY.backslash] = { ':Neotree<cr>', 'Filetree'},
}

