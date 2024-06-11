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
    bookmark_0 = {
      sign = "⚑a",
      virt_text = "started refactoring"
    },
    bookmark_1 = {
      sign = "⚑e",
      virt_text = "definitions research"
    },
    bookmark_2 = {
      sign = "⚑i",
      virt_text = "moving"
    },
    bookmark_3 = {
      sign = "⚑h",
      virt_text = "help"
    },
    bookmark_4 = {
      sign = "⚑u",
      virt_text = "todo"
    },
    bookmark_5 = {
      sign = "⚑o",
      virt_text = "fix"
    },
    bookmark_6 = {
      sign = "⚑y",
      virt_text = "hello world"
    },
    bookmark_7 = {
      sign = "⚑k",
      virt_text = "hello world"
    },
    bookmark_8 = {
      sign = "⚑.",
      virt_text = "hello world"
    },
    bookmark_9 = {
      sign = "⚑q",
      virt_text = "hello world"
    },
  },

  config = true,
}
