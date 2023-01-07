return {
  ['Integrations'] = {
    'toggleterm', -- Terminal integration.
  },

  ['Workspace'] = {
    -- * Status line.
    -- 'tpipeline', -- Move status line to the tmux.
    -- 'lualine', -- Pretty status line in lua.

    -- * Buffers.
    'bufferline', -- Buffer line.
    'jabs', -- Buffer management popup.

    -- * Winbar: statusline at the top of the window.
    'incline',

    -- * Remove Distraction.
    'true_zen', -- Clear screen space from the ui clutter.
    'twilight', -- Dim everything except current block.

    -- 'neoscroll' -- Smooth scroll.
  },

  ['WindowManagement'] = {
    'bufdelete', -- Keep window layout after closing the buffer.
    -- Focus on window: keep it dynamically larger, remove numbers, cursor
    --   and signcolumn on inactive windows.
    'focus',
    --'window', -- Jump to specified window.
    'winshift', -- Move windows without changing layout.
  },

  ['Navigation'] = {
    -- * Inside  file.
    -- Was lagging :(
    -- 'quick_scope', -- More efficient jumping inside a line.
    'lightspeed',
    'marks', -- Marks and bookmarks.

    -- * Across files.
    -- - Harpoon?
    'rnvimr', -- Ranger filemanager.
    'neo_tree', -- Browse file tree.
    'dirbuf', -- Browse editable file tree like dired.

    'other', -- Alternate and cycle between files of different types but the same business functionality.

    'rel', -- Jumping to file under cursor.

    -- * Telescope.
    'telescope',
    'telescope_file_browser',
  },

  ['Editing'] = {
    'autopairs', -- Automatically insert brackets.
    'comments', -- Keybindings for commenting.
    'surround', -- Manipulate surrounding elements such as commas and tags.
    'multi_cursors',
    'abolish', -- Case permutations (from snake_case to camelCase and so on).
    'tabout', -- Quick jump out of parentheses.
    'easy_align', -- Align by symbol or regex pattern.
    'splitjoin' -- Change object from inline to multi-line and vice versa.
  },

  ['TextObjects'] = {
    'textobjects', -- Core for this layer.
    'word_column', -- Columns.
    'indented_paragraph', -- Indented paragraph.
    'indent', -- Indents.
    'hydrogen', -- Hydrogen (jupyter notebook cells).
    'word', -- Case delimited and _ delimited words.
  },

  ['Lsp'] = {
    'lsp',
    'typescript', -- Typesript lsp utils.
    'neodev', -- Lua better lsp settings.

    'lspsaga', -- Better UI for lsp handlers.
    'illuminate', -- Highlight symbol under cursor.
    --'tex',
    -- # Ai language assitance.
    -- It was laggy :(
    -- 'copilot',

    -- ft = {
    --   'css',
    --   'html',

    --   -- 'webdevelopment'
    -- }, 
  },

   -- Linting, formatting and additional code actions.
  ['Assistance'] = {
    'null_ls',
  },

  --   Everything that helps you manage the project (sessions, documentation,
  -- notes)
  ['ProjectManagement'] = {
      'todo_comments', -- Highlight and search for todo comments like `TODO`, `HACK`, `FIX` in your project.
      'auto_session',
  },

  ['Ui'] = {
    'dressing', -- Prettier wrappers for vim.ui.select. Can use telescope layouts.
    'notify', -- Add nice looking ui for notifications.
  --   'fidget', -- Progress handler.
    'which_key', -- Mappings visualization.
    'ufo', -- Folding.
    'conceal', -- Conceal chosen language constructors with treesitter's aid.
    'headlines', -- Background whole line highlights (for code blocks, headers...).
  },

  -- ['Writing'] = {
  --   'vimtex',
  -- }
}

-- In the future you will need pass at least one language to
-- enable them.

-- Make dependencies:
-- * Plugin -> Layer (Autocomplete.lsp -> LSP).
-- * Layer -> Layer (Python -> LSP, Editing...).
-- By making a new field in a Layer:
--   dependencies (or requires) = {
--     ['LayerNameToFullyRequire'],
--
--     ['LayerName'] = {
--        'specificPluginsToRequire', -- Configuration will be get from existing layer.
--
--        'pluginWithSpecificConfigurations' = {
--           event = ...
--           ...
--           config = ...
--        },
--     },
--   }

