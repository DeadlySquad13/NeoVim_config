return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VimEnter',
  -- Uses treesitter to calculate indentation when possible.
  after = 'deadly-gruv',

  opts = function ()
    local scope_highlight = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
    }

    return {
        indent = { highlight = scope_highlight },
        scope = {
            highlight = "IndentBlanklineScope",
        },
    }
  end,

  config = function(_, opts)

    local prequire = require('ds_omega.utils').prequire

    local indent_blankline_is_available, indent_blankline = prequire('ibl')

    if not indent_blankline_is_available then
      return
    end

    local PLUGIN_NAME = 'indent-blankline.nvim'

    if not vim.go.termguicolors then
      notify('Please, set `termguicolors` for better experience.', vim.log.levels.INFO, { title = PLUGIN_NAME })
    end

    -- ARCHIVE: Was useful for lines.
    -- if not vim.go.list then
    --   notify([[Please, enable `list` option!
    -- Also `space` and `eol` characters should be set in `listchars`!]], vim.log.levels.WARN, { title = PLUGIN_NAME })
    -- end

    indent_blankline.setup(opts)
  end
}
