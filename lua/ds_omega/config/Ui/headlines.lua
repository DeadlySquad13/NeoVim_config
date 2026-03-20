---@type LazySpec
return {
  'lukas-reineke/headlines.nvim',

  ft = {
    "markdown",
    "dockerfile",
    "yaml",
  },

  -- INFO: Without function it's `vim.treesitter.query.parse`
  -- is activated too early. Adding treesitter to the deps and BufEnter to
  -- events didn't help.
  opts = function()
    -- INFO: To create queries, see `:TSEditQuery highlights` in filetype
    -- you're interested in. Grab query and instead of assigning default
    -- highlight, use one of the special highlights used in this plugin:
    -- `@headline`, `@dash`, `@codeblock`, `@quote`
    -- For instance:
    -- ```query
    --   [
    --     "FROM"
    --     "WORKDIR"
    --   ] @keyword
    -- ```
    -- was transformed into:
    -- ```query
    --   [
    --     "FROM"
    --     "WORKDIR"
    --   ] @headline
    -- ```
    return {
      markdown = {
        headline_highlights = false,
      },
      yaml = {
        query = vim.treesitter.query.parse(
          "yaml",
          [[
                (
                    (comment) @dash
                    (#match? @dash "^# ---+$")
                )
            ]]
        ),
        dash_highlight = "Dash",
      },
      dockerfile = {
        query = vim.treesitter.query.parse(
          "dockerfile",
          [[
           [
            "FROM"
            "WORKDIR"
           ] @headline
          ]]
        ),
        headline_highlights = { "Headline" },
        bullet_highlights = {
          "@text.title.1.marker.markdown",
          "@text.title.2.marker.markdown",
          "@text.title.3.marker.markdown",
          "@text.title.4.marker.markdown",
          "@text.title.5.marker.markdown",
          "@text.title.6.marker.markdown",
        },
        -- bullets = { "◉", "○", "✸", "✿" },
        --   codeblock_highlight = "CodeBlock",
        --   dash_highlight = "Dash",
        --   dash_string = "-",
        --   quote_highlight = "Quote",
        --   quote_string = "┃",
          fat_headlines = true,
          fat_headline_upper_string = "▄",
          fat_headline_lower_string = "▀",
      },
    }
  end,
  config = true,
}
