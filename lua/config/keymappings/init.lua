--local prequire = require('utils').prequire;
local tinykeymap_transitive_catalizator = '.'

local forward_slash = '<c-_>'
local backslash = [[\]]

-- Split line by delimiter: '<,'>s;\(delimiter\) ;\1\r;g
-- Uppercase all comments and add dot at the end:
--   '<,'>s;^\(-- \w\)\(.*\);\U\1\e\2.;

local comment_mappings = {
  D = { ':Neogen<cr>', 'Create Documentation comment' },

  ['>'] = {
    '<CMD>set operatorfunc=v:lua.___comment_semantically<CR>g@',
    'Comment semantically',
  },
  ['<'] = {
    '<CMD>set operatorfunc=v:lua.___uncomment_semantically<CR>g@',
    'Uncomment semantically',
  },

  ['>>'] = {
    '<cmd>lua ___comment_semantically_current_line()<cr>',
    'Comment semantically current line',
  },
  ['<<'] = {
    '<cmd>lua ___uncomment_semantically_current_line()<cr>',
    'Uncomment semantically current line',
  },
}

local e_mappings = {
  name = 'Edit',

  e = { ':ChooseAndEditConfigs<cr>', 'Choose and Edit configs' },
  -- Open vimrc in vertical split.
  v = { '<cmd>vsplit $MYVIMRC<cr>', 'Vimrc' },

  h = { ':e <c-r>=expand("%:h")<cr>', 'Relative to current file Head'},

  -- * Snippets.
  -- Relevant snippet engine command will be called to edit snippets
  --   definitions.
  -- TODO: better pass here a function where it's decides how to edit.
  -- - Appropriate for current file.
  s = { '<cmd>SnippetsEdit<cr>', 'Snippets definitions' },
  -- - Choose from all available sources for current file.
  S = { '<cmd>ChooseSnippetsEdit<cr>', 'Choose Snippets definitions' },
}

-- # File.
-- Buffer mappings are mostly used, for now don't know what to place here.
local file_mappings = {
  name = 'File',
}

-- # Go. Movement across files.
local go_mappings = {
  name = 'Go',
  -- * Rel.vim /home/dubuntus/.vim/plugged/rel.vim/plugin/rel.vim
  l = { '<Plug>(Rel)', 'Link' },
}

-- # Help. Show help pages, documentation. Can lead out of the application,
-- for example, in browser.
local help_mappings = {
  name = 'Help',

  -- `<c-r><c-w>` won't work on namespaced commands like
  --   vim.split - it will send you to vim or split depending on your cursor
  --   location. Default command K can work on visually selected text solving
  --   this issue. Unfortunately, I can't get visually selected by myself, it
  --   seems complicated to achieve with marks.
  -- Maybe this might help:
  --   https://github.com/theHamsta/nvim-treesitter/blob/a5f2970d7af947c066fb65aef2220335008242b7/lua/nvim-treesitter/incremental_selection.lua#L22-L30
  -- But here author gets only range, I still don't understand how to get the
  --   text by that range.
  -- Here author gets text somehow but in vimscript:
  --   https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
  --Should be `:set keywordprg=:help` (on Linux will be `:Man` by default!)
  v = { 'K', 'Vim help' },
  m = { ':Man <c-r><c-w><cr>', 'Man page' },
}

-- # Jump. Movement inside file.
local jump_mappings = {
  name = 'Jump',
}

-- # Rename. Search and replace mappings.
local rename_mappings = {
  name = 'Rename',

  -- Current word under cursor.
  w = {
    [[:%s;\<<c-r><c-w>\>;;g<left><left>]],
    'Current word under cursor',
    silent = false,
  },
  -- vnoremap <leader>sw <esc>:%s;\<<c-r><c-w>\>;;g<left><left>
  -- Don't really remember why I needed it...
  t = { [[:%s;<\w*>\(<\\\w*>\)\?;;g<left><left>]], 'Tag' },
}

-- # Session. Everything related to sessions, saving, sourcing...
-- Change from silent to vim.notify?
local session_mappings = {
  name = 'Session',

  w = { ':w<cr>', 'Write file' },
  v = { ':source $MYVIMRC<cr>', 'Source Vimrc', silent = false },
  V = {
    ':w<cr><cmd>source $MYVIMRC<cr>',
    'Save current file and source Vimrc',
    silent = false,
  },
  -- Source current file (indented for lua file).

  s = { ':source %<cr>', 'Source current file', silent = false },
  S = { ':LuaSnipSource<cr>', 'Source LuaSnip' },
  -- Recompile settings after changing Packer configuration.
  p = {
    ':source $HOME/.config/nvim/lua/plugins.lua<cr>:PackerCompile<cr>',
    'Recompile packer',
    silent = false,
  },
}

-- # Toggle. Mappings that toggle features.
local toggle_mappings = {
  name = 'Toggle',

  f = { ':FocusToggle<cr>', 'Focus' },
  i = {
    function()
      require('incline').toggle()
    end,
    'Incline (winbar)',
  },

  m = { ':FocusMaxOrEqual<cr>', 'Between Maximize and Equal' },

  q = { ':QuickScopeToggle<cr>', 'QuickScope' },
}

local telescope_builtin = require('telescope.builtin')
local telescope_extensions = require('telescope').extensions

-- # Navigation. Helps find things, used as lookup table (navigation panel).
local navigation_mappings = {
  name = 'Navigation',
  -- * Telescope.
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

  [backslash] = { ':Neotree<cr>', 'Filetree'},
}

-- Open something.
local open_mappings = {
  name = 'Open',
  -- * Telescope.
  s = {
    telescope_extensions.persisted.persisted,
    'Session',
  },
}

local paste_mappings = { '"+p', 'Paste from clipboard register' }

-- # Major. Like major mode in spacemacs: filetype mappings.
local major_mappings = {
  name = 'Major',
}

-- * Rnvimr.
-- nmap <leader><c-\> :RnvimrToggle<cr>

--  " Find files relative to root directory (don't understand how lua functions
--  "   work).
--  "lua <<EOF
--  "my_fd = function(opts)
--    "opts = opts or {}
--    "opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
--    "require'telescope.builtin'.find_files(opts)
--  "end
--  "EOF
--
local yank_mappings = { '"+y', 'Yank into clipboard register' }
-- local yank_mappings = { '<Plug>YADefault', 'Native Yank' } -- Maybe move into localleader?

local z_mappings = {
  h = {
    [tinykeymap_transitive_catalizator] = { 'Horizontal Scroll Mode' },
  },
}

-- Historically ',' for me is a keybind for settings.
local settings_mappings = {
  name = 'Settings',
  -- Colors.
  c = { '<cmd>highlight<cr>', 'Show highlight groups colors' },
  --['*'] = { function() vim.fn['SynStack']() end, 'Show highlight groups under the cursor' }
  ['*'] = {
    ':TSHighlightCapturesUnderCursor<cr>',
    'Show highlight groups under the cursor',
  },
  ['h'] = { ':noh<cr>', 'Turn off the highlight after search' },
}

local window_mappings = {
  name = 'Window',
  -- List of windows like in tmux?
  --w = {  },

  -- Made it similar to tmux, even though there's ctrl-w_w shortcut in vim for
  -- such jump.
  o = { [[:lua require('nvim-window').pick()<CR>]], 'Pick window' },
  ['<c-o>'] = { [[:lua require('nvim-window').pick()<CR>]], 'Pick window' },

  m = { ':FocusMaximise<cr>', 'Maximise window' },

  [tinykeymap_transitive_catalizator] = { 'Window Mode' },
}

local mappings = {
  name = 'Main',

  ['<leader>'] = {
    name = 'Leader',
    -- a = a_mappings,
    b = require('config.keymappings.buffer'),
    c = vim.tbl_extend('error', comment_mappings, {
      d = {':lcd %:h<cr>', 'Change cwd to current file directory'},
    }),
    -- d = d_mappings,
    e = e_mappings,
    f = file_mappings,
    g = go_mappings,
    h = help_mappings,
    -- i = i_mappings,
    j = jump_mappings,
    -- k = k_mappings,
    -- l = l_mappings,
    m = major_mappings,
    n = navigation_mappings,
    o = open_mappings,
    p = paste_mappings,
    -- q = q_mappings,
    r = rename_mappings,
    s = session_mappings,
    t = toggle_mappings,
    -- u = u_mappings,
    -- v = v_mappings,
    -- w = w_mappings,
    -- x = x_mappings,
    y = yank_mappings,
    z = z_mappings,

    [','] = settings_mappings,
  },

  -- Alternate mappings (functions simillar to `g`).
  [';'] = {
    name = 'Alternate',
    s = {
      '<Plug>Lightspeed_gs',
      'Down/right (successors in the window tree)',
    },
    S = { '<Plug>Lightspeed_gS', 'Up/left (predecessors in the window tree)' },
  },

  -- a = a_mappings,
  -- b = b_mappings,
  -- c = c_mappings,
  -- d = d_mappings,
  -- e = e_mappings,
  -- f = f_mappings,
  -- g = g_mappings,
  -- h = h_mappings,
  -- i = i_mappings,
  -- j = j_mappings,
  -- k = k_mappings,
  -- l = l_mappings,
  -- m = m_mappings,
  -- n = n_mappings,
  -- o = o_mappings,
  -- p = p_mappings,
  -- q = q_mappings,
  -- r = r_mappings,
  -- s = s_mappings,
  -- t = t_mappings,
  -- u = u_mappings,
  -- v = v_mappings,
  --w = w_mappings,
  -- x = x_mappings,
  -- y = y_mappings,
  -- z = z_mappings,

  ['<c-w>'] = window_mappings,
  -- Swap mark jumps.
  -- ["'"] = { '`' },
  -- ['`'] = { "'" },
  -- ["''"] = { '``' },
  -- ["``"] = { "''" },
}

-- vim.cmd([[:QuickScopeToggle<cr>:execute "normal \<Plug>Lightspeed_f"<cr>]])
-- Unfortunately, bindings above don't work.
-- Swap mark jumps.
vim.cmd("nnoremap ' `")
vim.cmd("nnoremap ` '")
vim.cmd("nnoremap '' ``")
vim.cmd("nnoremap `` ''")

local x_mappings = {
  name = 'Main',

  ['<leader>'] = {
    name = 'Leader',
    -- a = a_mappings,
    -- b = buffer_mappings,
    c = comment_mappings, -- <leader><c-/> can be used instead if there's a candidate for `c`.
    -- d = d_mappings,
    -- e = e_mappings,
    -- f = file_mappings,
    -- g = go_mappings,
    -- h = help_mappings,
    -- i = i_mappings,
    -- j = jump_mappings,
    -- k = k_mappings,
    -- l = l_mappings,
    -- m = major_mappings,
    -- n = navigation_mappings,
    -- o = o_mappings,
    p = paste_mappings,
    -- q = q_mappings,
    -- r = r_mappings,
    -- s = s_mappings,
    -- t = toggle_mappings,
    -- u = u_mappings,
    -- v = v_mappings,
    -- w = w_mappings,
    -- x = x_mappings,
    y = yank_mappings,
    -- z = z_mappings,

    -- [','] = settings_mappings,

    -- Comments.
    -- Unfortunately, gv doesn't work at the end, it get's overriden by
    --   something...
    ['>'] = {
      '<esc><cmd>lua ___comment_semantically(vim.fn.visualmode())<cr>',
      'Comment semantically',
    },
    ['<'] = {
      '<esc><cmd>lua ___uncomment_semantically(vim.fn.visualmode())<cr>',
      'Uncomment semantically',
    },
  },

  -- Alternate mappings (functions simillar to `g`).
  [';'] = {
    name = 'Alternate',
    s = {
      '<Plug>Lightspeed_gs',
      'Down/right (successors in the window tree)',
    },
    S = { '<Plug>Lightspeed_gS', 'Up/left (predecessors in the window tree)' },
  },

  -- a = a_mappings,
  -- b = b_mappings,
  -- c = c_mappings,
  -- d = d_mappings,
  -- e = e_mappings,
  -- f = f_mappings,
  -- g = g_mappings,
  -- h = h_mappings,
  -- i = i_mappings,
  -- j = j_mappings,
  -- k = k_mappings,
  -- l = l_mappings,
  -- m = m_mappings,
  -- n = n_mappings,
  -- o = o_mappings,
  -- p = p_mappings,
  -- q = q_mappings,
  -- r = r_mappings,
  -- s = s_mappings,
  -- t = t_mappings,
  -- u = u_mappings,
  -- v = v_mappings,
  -- w = w_mappings,
  -- x = x_mappings,
  -- y = y_mappings,
  -- z = z_mappings,

  -- ['<c-w>'] = {
  -- [tinykeymap_transitive_catalizator] = { 'Window Mode' },
  -- }

  --['<c-i>'] = { '<cmd>lua require("luasnip.util.util").store_selection()<cr>gv"_s', 'Store selection and start inserting snippet'},
}

local i_mappings = {
  name = 'Main',

  -- Unfortunately, have default <c-t> mapped in
  ['<c-m>'] = { '<c-t>', 'Indent once' },

  [forward_slash] = {
    -- '<esc>:lua require("Comment.api").toggle_current_linewise()<CR>`ti',
    '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>',
    'Comment current line',
  },
}

return {
  n = mappings,
  x = x_mappings,
  i = i_mappings,
}
