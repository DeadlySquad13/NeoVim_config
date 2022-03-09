local which_key = require("which-key")

local builtin = require('telescope.builtin')
local tinykeymap_transitive_catalizator = '.';

-- Utilities. {{{
-- How to specify it programmatically (start and end of the range)?
local special_symbols = {
  -- Mathematical Alphanumeric Symbols (Range: 1D400—1D7FF).
  A = '𝐀',
  B = '𝐁',
  C = '𝐂',
  D = '𝐃',
  E = '𝐄',
  F = '𝐅',
  G = '𝐆',
  H = '𝐇',
  I = '𝐈',
  J = '𝐉',
  K = '𝐊',
  L = '𝐋',
  M = '𝐌',
  N = '𝐍',
  O = '𝐎',
  P = '𝐏',
  Q = '𝐐',
  R = '𝐑',
  S = '𝐒',
  T = '𝐓',
  U = '𝐔',
  V = '𝐕',
  W = '𝐖',
  X = '𝐗',
  Y = '𝐘',
  Z = '𝐙'
}

-- pos - index of a char to replace,
-- str - string we want to modify,
-- r - replacement char (char to replace).
local function replace_char(pos, str, r)
  -- Checking for nil pos (kind of ternary operator). 
  return not pos and str or str:sub(1, pos-1) .. r .. str:sub(pos+1)
end

-- Formats first found character according to dictionary of a special symbols.
-- str - string to format,
-- char - character to find.
local function format(str, char) 
  -- - Checking for nil str and characters that will be interpreted wrong (as regex?).
  if (not str or char == '.') then
    return str
  end

  -- - Case insensitive search because we have only capitals in dictionary.
  return replace_char(str:upper():find(char), str, special_symbols[char])
end

local function format_mappings_names(mappings, group_mapping_key)
  local formatted_mappings = {} 

  for key, mapping in pairs(mappings) do
    if (key == 'name') then
      -- Now have only capitals in dictionary so uppercasing.
      formatted_mappings[key] = format(mapping, group_mapping_key:upper())
    else
      -- Mapping group.
      if (mapping.name) then
        formatted_mappings[key] = format_mappings_names(mapping, key:upper())
      else
        local mapping_name = mapping[2]

        -- Now have only capitals in dictionary so uppercasing.
        mapping[2] = format(mapping_name, key:upper())
        formatted_mappings[key] = mapping
      end
    end
  end

  return formatted_mappings
end

-- Mappings.
-- # Buffer.
local buffer_mappings = {
  name = 'Buffer'
}

-- # File.
local file_mappings = {
  name = 'File'
}

-- # Go. Movement across files.
local go_mappings = {
  name = 'Go',
  -- * Rel.vim /home/dubuntus/.vim/plugged/rel.vim/plugin/rel.vim
  l = { "<Plug>(Rel)", "Link" }
}

-- # Help. Show help pages, documentation. Can lead out of the application,
-- for example, in browser.
local help_mappings = {
  name = 'Help',
}

-- # Jump. Movement inside file.
local jump_mappings = {
  name = 'Jump',
}

-- # Toggle. Mappings that toggle features.
local toggle_mappings = {
  name = 'Toggle',
}

-- # Navigation. Helps find things, used as lookup table (navigation panel).
local navigation_mappings = {
  name = 'Navigation',
  -- * Telescope.
  f = { function() builtin.find_files() end, 'Find in current directory' },
  s = { function() require('session-lens').search_session() end, 'Session Search' },
  g = { function() builtin.live_grep() end, 'Live grep' },
  b = { function() builtin.buffers() end, 'Buffers' },
  h = { function() builtin.help_tags() end, 'Help tags' },
  t = { function() builtin.treesitter() end, 'Treesitter' },
}

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
local yank_mappings = { '<Plug>YADefault', 'Native Yank' }

local z_mappings = {
  h = {
    [tinykeymap_transitive_catalizator] = { 'Horizontal Scroll Mode' }
  }
}

-- Historically ',' for me is a keybind for settings.
local settings_mappings = {
  name = 'Settings',
  v = { 'Open Vim config' },
  -- Colors.
  c = { '<cmd>highlight<cr>', 'Show highlight groups colors' },
  ['*'] = { function() vim.fn['SynStack']() end, 'Show highlight groups under the cursor' }
}

local mappings = {
  name = 'Main',

  ['<leader>'] = {
    name = 'Leader',
    -- a = a_mappings,
    b = buffer_mappings,
    -- c = comment_mappings, -- Not sure, maybe leave <leader><c-/>.
    -- d = d_mappings,
    -- e = e_mappings,
    f = file_mappings,
    g = go_mappings,
    h = help_mappings,
    -- i = i_mappings,
    j = jump_mappings,
    -- k = k_mappings,
    -- l = l_mappings,
    m = major_mappings,
    n = navigation_mappings,
    -- o = o_mappings,
    -- p = p_mappings,
    -- q = q_mappings,
    -- r = r_mappings,
    -- s = s_mappings,
    t = toggle_mappings,
    -- u = u_mappings,
    -- v = v_mappings,
    -- w = w_mappings,
    -- x = x_mappings,
    y = yank_mappings,
    z = z_mappings,

    [','] = settings_mappings,
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

  ['<c-w>'] = {
    [tinykeymap_transitive_catalizator] = { 'Window Mode' }     
  }
}

local x_mappings = {
  name = 'Main',

  ['<leader>'] = {
    name = 'Leader',
    -- a = a_mappings,
    -- b = buffer_mappings,
    -- c = comment_mappings, -- Not sure, maybe leave <leader><c-/>.
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
    -- p = p_mappings,
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
    -- [tinykeymap_transitive_catalizator] = { 'Window Mode' }     
  -- }
}

local options = {
  -- prefix: use "<leader>f" for example for mapping everything related to finding files
  -- the prefix is prepended to every mapping part of `mappings`.
  prefix = '', 
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings.
  silent = true, -- use `silent` when creating keymaps.
  -- use `noremap` when creating keymaps (when command starts with <Plug>,
  -- noremap = false is set automatically).
  noremap = true,
  nowait = false, -- use `nowait` when creating keymaps
}

-- Options for n mode mappings.
local n_options = { mode = 'n', unpack(options) }
which_key.register(format_mappings_names(mappings, 'M'), n_options);

-- Options for x mode mappings.
local x_options = { mode = 'x', unpack(options) }
which_key.register(format_mappings_names(x_mappings, 'M'), x_options);

-- Setup.
which_key.setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `.
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode.
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions.
      suggestions = 20, -- how many suggestions should be shown in the list?.
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim.
    -- No actual key bindings are created.
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion.
      motions = true, -- adds help for motions.
      text_objects = true, -- help for text objects triggered after entering an operator.
      windows = false, -- default bindings on <c-w> (shown via tinykeymap transitive)..
      nav = true, -- misc bindings to work with windows.
      z = true, -- bindings for folds, spelling and others prefixed with z.
      g = true, -- bindings for prefixed with g.
    },
  },

  -- Add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above.
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way..
    -- For example:.
    -- ["<space>"] = "SPC",.
    -- ["<cr>"] = "RET",.
    -- ["<tab>"] = "TAB",.
  },
  icons = {
    breadcrumb = "~>", -- symbol used in the command line area that shows your active key combo.
    separator = "", -- symbol used between a key and it's label.
    group = "", -- symbol prepended to a group.
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup.
    scroll_up = '<c-u>', -- binding to scroll up inside the popup.
  },
  window = {
    border = "shadow", -- [ none, single, double, shadow ].
    position = "bottom", -- [ bottom, top ].
    margin = { 10, 60, 52, 60 }, -- extra window margin [ top, right, bottom, left ].
    padding = { 1, 1, 1, 1 }, -- extra window padding [ top, right, bottom, left ].
    winblend = 10 -- pseudo transparency.
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns.
    width = { min = 20, max = 50 }, -- min and max width of the columns.
    spacing = 3, -- spacing between columns.
    align = "center", -- align columns left, center or right.
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label.
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate.
  show_help = true, -- show help message on the command line when the popup is visible.
  triggers = "auto", -- automatically setup triggers.
-- triggers = {"<leader>"} -- or specify a list manually.
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey.
    -- this is mostly relevant for key maps that start with a native binding.
    -- most people should not need to change this.
    i = { "j", "k" },
    v = { "j", "k" },
  },
}
