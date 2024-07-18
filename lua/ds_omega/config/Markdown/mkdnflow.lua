return {
  'jakewvincent/mkdnflow.nvim',

  ft = { 'markdown' },

  opts = {
    --[[ perspective = {
      -- Specify algorithm to search for bibtex and other links.
      priority = "root",
      -- Easy way to tell the root point even on hosted servers without .git.
      root_tell = "index.md",
    }, ]]
    bib = {
      -- default_path = require('ds_omega.constants.env').REFERENCES .. "/Personal.bib"
      default_path = require('ds_omega.constants.env').REFERENCES .. "/Zotero.bib"
    },
    mappings = {
      MkdnEnter = { { 'i', 'n', 'v' }, '<CR>' }, -- This monolithic command has the aforementioned
      -- insert-mode-specific behavior and also will trigger row jumping in tables. Outside
      -- of lists and tables, it behaves as <CR> normally does.
      -- MkdnNewListItem = {'i', '<CR>'} -- Use this command instead if you only want <CR> in
      -- insert mode to add a new list item (and behave as usual outside of lists).
      MkdnTab = false,
      MkdnSTab = false,
      MkdnNextLink = { 'n', '<Tab>' },
      MkdnPrevLink = { 'n', '<S-Tab>' },
      MkdnNextHeading = { 'n', ']]' },
      MkdnPrevHeading = { 'n', '[[' },
      -- - Buffer history (seems like a good idea overall. Especially for a lot
      -- of jumps through Zettelkasten).
      MkdnGoBack = { 'n', '<BS>' },
      MkdnGoForward = { 'n', '<Del>' }, -- Conflicts with my `x` mapping.
      MkdnCreateLink = false,                                       -- see MkdnEnter
      MkdnCreateLinkFromClipboard = { { 'n', 'v' }, '<leader>lp' }, -- see MkdnEnter
      MkdnFollowLink = false,                                       -- see MkdnEnter
      MkdnNewListItemBelowInsert = { 'n', '.' },
      MkdnNewListItemAboveInsert = { 'n', ':' },
      MkdnTableNextCell = { 'i', '<Tab>' },
      MkdnTablePrevCell = { 'i', '<S-Tab>' },
      -- TODO: Create proper keymappings:
      MkdnDestroyLink = false,        -- { 'n', '<M-CR>' },
      MkdnTableNextRow = false,
      MkdnTablePrevRow = false,       -- { 'i', '<M-CR>' },
      -- TODO: Consider these commands and keymap them if needed.
      MkdnTagSpan = false,            -- { 'v', '<M-CR>' },
      MkdnMoveSource = false,         -- { 'n', '<F2>' },
      MkdnYankAnchorLink = false,     -- { 'n', 'yaa' },
      MkdnYankFileAnchorLink = false, -- { 'n', 'yfa' },
      MkdnToggleToDo = false,         -- { { 'n', 'v' }, '<C-Space>' },
      -- - Something like <Leader>o and <Leader>O.
      MkdnTableNewRowBelow = false,   -- { 'n', '<leader>ir' },
      MkdnTableNewRowAbove = false,   -- { 'n', '<leader>iR' },
      -- -
      MkdnTableNewColAfter = false,   -- { 'n', '<leader>ic' },
      MkdnTableNewColBefore = false,  -- { 'n', '<leader>iC' },

      -- Not needed:
      -- - Dial.
      MkdnIncreaseHeading = false,
      MkdnDecreaseHeading = false,

      -- - Much easier to type manually.
      MkdnNewListItem = false,
      MkdnExtendList = false,
      -- - Prefer double enter functionality.
      MkdnUpdateNumbering = false,

      -- - Seems like ufo is better? Especially with lsp.
      MkdnFoldSection = false,   -- { 'n', '<leader>f' },
      MkdnUnfoldSection = false, -- { 'n', '<leader>F' }
    },
  },

  config = true,
}
