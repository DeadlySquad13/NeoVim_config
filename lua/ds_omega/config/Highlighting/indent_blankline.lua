-- REFACTOR: Move to a theme instead of centralizing here.
local highlight_themes = {
  ["deadly-gruv"] = {
    indent = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
      "IndentBlanklineIndent3",
      "IndentBlanklineIndent4",
    },
    scope = "IndentBlanklineScope",
  },
  ["__default__"] = {
    indent = {
      "RainbowDelimiterCyan",
      "RainbowDelimiterViolet",
      "RainbowDelimiterGreen",
      "RainbowDelimiterOrange",
      "RainbowDelimiterBlue",
      "RainbowDelimiterYellow",
      "RainbowDelimiterRed",
    },
    scope = nil, -- default is fine
  }
}

---@type LazySpec
return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VimEnter',
  -- Uses treesitter to calculate indentation when possible.
  after = 'deadly-gruv',

  opts = function()
    local highlight_theme = vim.g.colors_name == "deadly-gruv" and highlight_themes[vim.g.colors_name] or
        highlight_themes["__default__"]

    return {
      indent = { highlight = highlight_theme['indent'] },
      scope = { highlight = highlight_theme.scope },
      exclude = { filetypes = require('ds_omega.constants.filetypes').start_screens }
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
    vim.g.indent_blankline_filetype_exclude = { 'dashboard' }
    indent_blankline.setup(opts)
  end
}
