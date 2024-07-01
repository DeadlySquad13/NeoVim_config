---@class Bookmark
---@field sign string
---@field virt_text string

return {
  'chentoast/marks.nvim',

  opts = {
    -- Whether to map keybinds or not.
    -- Default true.
    default_mappings = false,
    -- Which builtin marks to show.
    -- Default {}.
    builtin_marks = { --[[ ".",  ]] "<", ">", "^" },
    -- Whether movements cycle back to the beginning/end of buffer.
    -- Default true.
    cyclic = true,
    -- Whether the shada file is updated after modifying uppercase marks.
    -- Default false.
    force_write_shada = false,
    -- How often (in ms) to redraw signs/recompute mark positions.
    --   Higher values will have better performance but may cause visual lag,
    --   while lower values may cause performance penalties.
    -- Default 150.
    refresh_interval = 250,
    -- Sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
    --   marks, and bookmarks.
    -- Can be either a table with all/none of the keys, or a single number, in which case
    --   the priority applies to all marks.
    -- Default 10.
    sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
    -- Disables mark tracking for specific filetypes. default {}.
    excluded_filetypes = {
      '', -- Hover popups such as Treesitter syntax investigation popup, lsp popups...
      'TelescopePrompt',
      --'toggleterm',
    },
    -- Marks.nvim allows you to configure up to 10 bookmark groups, each with its own.
    -- Sign/virttext. Bookmarks can be used to group together positions and quickly move.
    -- Across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and.
    -- Default virt_text is ""..
    ---@type Bookmark
    bookmark_0 = {
      sign = "⚑a",
      -- Interrupted to refactor, to investigate, to document something.
      virt_text = "interrupted"
    },
    ---@type Bookmark
    bookmark_1 = {
      sign = "⚑e",
      -- Need to pay attention to that part. Mainly just use it as a visual nugging indicator.
      virt_text = "attention"
    },
    ---@type Bookmark
    bookmark_2 = {
      sign = "⚑i",
      -- Reminder to comeback and remove this part (was testing something, for
      -- example).
      virt_text = "remove"
    },
    ---@type Bookmark
    -- QUESTION: Separate into clarify and investigate?
    bookmark_3 = {
      sign = "⚑h",
      -- Need to clarify that part by looking into documentation or asking
      -- someone. Sometimes even by investigating into source code and testing it yourself.
      virt_text = "clarify"
    },
    -- After that go my typical comment types. Marks duplicate them to make
    -- process smoother: add mark and go on, once ready - come back and
    -- complete them. Otherwise comment them now properly or even create tasks.
    ---@type Bookmark
    bookmark_4 = {
      sign = "⚑u",
      virt_text = "todo"
    },
    ---@type Bookmark
    bookmark_5 = {
      sign = "⚑o",
      virt_text = "fix"
    },
    ---@type Bookmark
    bookmark_6 = {
      sign = "⚑y",
      virt_text = "style"
    },
    ---@type Bookmark
    bookmark_7 = {
      sign = "⚑k",
      virt_text = "test"
    },
    ---@type Bookmark
    bookmark_8 = {
      sign = "⚑.",
      virt_text = "refactor"
    },
    ---@type Bookmark
    bookmark_9 = {
      sign = "⚑q",
      virt_text = "question"
    },
  },

  config = true,
}
