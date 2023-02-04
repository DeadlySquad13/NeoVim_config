local ft = require('constants').filetypes

local is_focus_bugged = false

return {
  -- The focused window will no longer automatically resize. Other focus
  --   features are still available.
  autoresize = not is_focus_bugged,
  -- Prevents focus automatically resizing windows based on configured excluded
  --   filetypes or buftypes Query filetypes using :lua print(vim.bo.ft) or
  --   buftypes using :lua print(vim.bo.buftype).
  excluded_filetypes = {
    '', -- Hover popups such as Treesitter syntax investigation popup, lsp popups...
    'TelescopePrompt',
    'toggleterm',
    'qf', -- Quickfix list.
  },
  excluded_buftypes = {
    'nofile',
    'help',
    'prompt',
    'popup',
    'quickfix' -- Quickfix list.
  },
  -- Enable resizing for excluded filetypes using forced_filetypes.
  --forced_filetypes = { 'dan_repl' },

  -- Force width for the focused window.
  -- Default: Calculated based on golden ratio.
  --width = 120,

  -- Force minimum width for the unfocused window.
  -- Default: Calculated based on golden ratio.
  -- min_width = 80,

  -- Force height for the focused window.
  -- Default: Calculated based on golden ratio.
  --height = 40,

  -- Sets the width of directory tree buffers such as NerdTree, NvimTree and
  --   CHADTree.
  -- Default: vim.g.nvim_tree_width or 30
  --treewidth = 20,

  -- True: When a :Focus.. command creates a new split window, initialise it as
  --   a new blank buffer.
  -- False: When a :Focus.. command creates a new split, retain a copy of the
  --   current window in the new window.
  --bufnew =  false,

  -- Prevents focus automatically resizing windows based on configured file
  -- trees. Query filetypes using `:lua print(vim.bo.ft)`.
  -- Default: { 'nvimtree', 'nerdtree', 'chadtree', 'fern' }.
  compatible_filetrees = ft.filetrees,

  -- Displays a cursorline in the focused window only.
  -- Not displayed in unfocused windows.
  cursorline = not is_focus_bugged,

  -- Displays a sign column in the focused window only
  -- Gets the vim variable setcolumn when focus.setup() is run
  -- See :h signcolumn for more options e.g :set signcolum=yes
  -- Default: true, signcolumn=auto
  signcolumn = not is_focus_bugged,

  -- Displays a cursor column in the focused window only.
  -- See :h cursorcolumn for more options.
  -- Default: false.
  --cursorcolumn = true,

  -- Displays a color column in the focused window only.
  -- See `:h colorcolumn` for more options.
  -- Default: enable = false, width = 80.
  colorcolumn = { enable = not is_focus_bugged, width = 80 },

  -- Displays line numbers in the focused window only.
  -- Not displayed in unfocused windows.
  -- Default: true.
  --number = true,
  -- Displays relative line numbers in the focused window only.
  -- Not displayed in unfocused windows.
  -- Default: true.
  --relativenumber = true,

  -- Displays hybrid line numbers in the focused window only.
  -- Not displayed in unfocused windows.
  -- Combination of :h relativenumber, but also displays the line number of the
  --   current line only.
  -- Default: false.
  hybridnumber = not is_focus_bugged,

  -- Preserve absolute numbers in the unfocused windows.
  -- Works in combination with relativenumber or hybridnumber.
  -- Default: false.
  --absolutenumber_unfocussed = true,

  -- Enable auto highlighting for focused/unfocused windows
  -- Default: false
  --winhighlight = true,

  -- By default, the highlight groups are setup as such:
  --   hi default link FocusedWindow VertSplit
  --   hi default link UnfocusedWindow Normal
  -- To change them, you can link them to a different highlight group, see `:h hi-default` for more info.
  --vim.cmd('hi link UnfocusedWindow CursorLine')
  --vim.cmd('hi link FocusedWindow VisualNOS')
};

