return {
  'glepnir/lspsaga.nvim',
  -- branch = 'main',

  opts = function()
    -- change the lsp symbol kind
    -- local lspkind = require('lspsaga.lspkind')

    -- See config structure: https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/init.lua
    return {
      -- ???
      -- lspkind[type_number][2] = icon -- see lua/lspsaga/lspkind.lua

      -- Options with default value
      -- "single" | "double" | "rounded" | "bold" | "plus"
      border_style = 'rounded',
      --the range of 0 for fully opaque window (disabled) to 100 for fully
      --transparent background. Values between 0-30 are typically most useful.
      saga_winblend = 0,
      -- when cursor in saga window you config these to move
      move_in_saga = { prev = '<C-p>', next = '<C-n>' },
      -- Error, Warn, Info, Hint
      -- use emoji like
      -- { "🙀", "😿", "😾", "😺" }
      -- or
      -- { "😡", "😥", "😤", "😐" }
      -- and diagnostic_header can be a function type
      -- must return a string and when diagnostic_header
      -- is function type it will have a param `entry`
      -- entry is a table type has these filed
      -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
      diagnostic_header = { ' ', ' ', ' ', 'ﴞ ' },
      -- show diagnostic source
      -- show_diagnostic_source = true, -- DEPRECATED?
      -- add bracket or something with diagnostic source, just have 2 elements
      -- diagnostic_source_bracket = {}, -- DEPRECATED?
      -- use emoji lightbulb in default
      code_action_icon = '💡',
      -- if true can press number to execute the codeaction in codeaction window
      code_action_num_shortcut = true,
      -- same as nvim-lightbulb but async
      lightbulb = {
        enable = true,
        sign = false,
        sign_priority = 20,
        virtual_text = true,
        ignore = {
          ft = {
            -- Vtsls has a code action that can be applied for every line:
            -- "move code to another file". No need in lightbulb if this action
            -- is not sorted somehow. I don't think it's specific to vtsls: as
            -- far as I remember other typescript lsps had the same action.
            'typescript',
            'typescriptreact',
          }
        }
      },
      -- finder icons
      finder_icons = {
        def = '  ',
        ref = '諭 ',
        link = '  ',
      },
      -- preview lines of lsp_finder and definition preview
      max_preview_lines = 10,
      finder_action_keys = {
        open = 'o',
        vsplit = 's',
        split = 'i',
        tabe = 't',
        quit = 'q',
        scroll_down = '<C-f>',
        scroll_up = '<C-b>', -- quit can be a table
      },
      code_action_keys = {
        quit = 'q',
        exec = '<CR>',
      },
      rename_action_quit = '<C-c>',
      -- definition_preview_icon = '  ', -- DEPRECATED?
      -- show symbols in winbar must nightly
      symbol_in_winbar = {
        in_custom = false,
        enable = false,
        separator = ' ',
        show_file = true,
        click_support = false,
      },
      -- show outline
      show_outline = {
        win_position = 'left',
        -- set the special filetype in there which in left like nvimtree neotree defx
        left_with = '',
        win_width = 140,
        auto_enter = true,
        auto_preview = true,
        virt_text = '┃',
        jump_key = 'h',
        -- auto refresh when change buffer
        auto_refresh = true,
      },
      -- if you don't use nvim-lspconfig you must pass your server name and
      -- the related filetypes into this table
      -- like server_filetype_map = { metals = { "sbt", "scala" } }
      server_filetype_map = {},

      ui = {
         -- Currently, only the round theme exists
        theme = 'round',
        -- This option only works in Neovim 0.9
        title = true,
        -- Border type can be single, double, rounded, solid, shadow.
        border = 'rounded',
        winblend = 0,
        expand = '⮚ ',
        collapse = '⮛ ',
        preview = '👁 ', -- Eye: U+1F441.
        code_action = '💡',
        diagnostic = '🐞 ',
        incoming = '📨 ', -- Incoming envelope: U+1F4E8.
        outgoing = '✉  ', -- Envelope: ^Vu2709.
        hover = '🔍 ', -- Left-Pointing Magnifying Glass: U+1F50D.
        kind = {},
      }
    }
  end,
}
