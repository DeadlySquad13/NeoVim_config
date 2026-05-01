return {
      lsp = {
        -- Override markdown rendering so that **cmp** and other plugins use **Treesitter**.
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },

        -- Conflicts with lsp_signature.
        -- TODO: Find out how it looks and compare
        -- what should be enabled.
        signature = {
          enabled = false,
        },
      },
      -- You can enable a preset for easier configuration.
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
      messages = {
        enabled = true,
        -- See `:h noice.nvim-noice-(nice,-noise,-notice)-views`

        view = "mini",               -- Default view for messages. Here also come logs that we throw into messages. That's where our logging messages show by default.
        view_error = "notify",       -- view for errors
        view_warn = "notify",        -- view for warnings
        view_history = "messages",   -- view for :messages
        view_search = "virtualtext", --
      }
    }
