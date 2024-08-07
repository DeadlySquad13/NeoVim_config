-- Optional dependencies.
-- local icons_available, _ = require('nvim-web-devicons');

-- For styling see `:h bufferline-styling`.
return {
  'akinsho/bufferline.nvim',
  dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
  event = 'VimEnter',

  cond = not vim.g.started_by_firenvim,

  opts = {
    options = {
      mode = "buffers", -- set to "tabs" to only show tabpages instead
     --   Unfortunately, most commands work with ordinal numbers relative to currently visible buffers in bufferline.
     -- But "ordinal" option takes all buffers into account. Fix is not likely
     -- to be done in near future: https://github.com/akinsho/bufferline.nvim/issues/249
     --   Absolute numbering will work correctly but it's harder to comprehend (you have to pay attention to numbers)
     -- and it's bad for 10+ buffers.
      -- numbers = "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
      numbers = "none",
      sort_by = 'directory',
      -- Used Bdelete (from plugin bufdelete) instead of bdelete so that the
      --   window layout is persistent.
      close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
      -- NOTE: this plugin is designed with this icon in mind,
      -- and so changing this is NOT recommended, this is intended
      -- as an escape hatch for people who cannot bear it for whatever reason
      indicator = {
        icon = '▎',
        style = 'icon'
      },
      buffer_close_icon = '',
      modified_icon = '●',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      --- name_formatter can be used to change the buffer's label in the bufferline.
      --- Please note some names can/will break the
      --- bufferline so use this at your discretion knowing that it has
      --- some limitations that will *NOT* be fixed.
      -- name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      -- if buf.name == 'index'
      -- if buf.name:match('%.md') then
      --   return vim.fn.fnamemodify(buf.name, ':t:r')
      -- end
      -- end,
      tab_size = 8,           -- min width.
      max_name_length = 18,
      max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
      --   return "("..count..")"
      -- end,
      -- NOTE: this will be called a lot so don't do any heavy processing here
      -- custom_filter = function(buf_number, buf_numbers)
      --   -- filter out filetypes you don't want to see
      --   if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
      --     return true
      --   end
      --   -- filter out by buffer name
      --   if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
      --     return true
      --   end
      --   -- filter out based on arbitrary rules
      --   -- e.g. filter out vim wiki buffer from tabline in your work repo
      --   if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
      --     return true
      --   end
      --   -- filter out by it's index number in list (don't show first buffer)
      --   if buf_numbers[1] ~= buf_number then
      --     return true
      --   end
      -- end,

      --offsets = {{filetype = "NvimTree", text = "File Explorer" | function , text_align = "left" | "center" | "right"}},
      color_icons = true,              -- whether or not to add the filetype icon highlights
      show_buffer_icons = true,        -- whether or not enable filetype icons for buffers
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = true,
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      -- can also be a table containing 2 custom separators
      -- [focused and unfocused]. eg: { '|', '|' }
      separator_style = 'thin',

      enforce_regular_tabs = false,

      always_show_bufferline = false, -- Hides when there's only 1 file (helps with disabling it on dahboard).
      --sort_by = 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
      -- add custom logic
      --return buffer_a.modified > buffer_b.modified
      --end
    },
    -- For highlight groups see `:h bufferline-highlights`.
  },

  config = true,
}
