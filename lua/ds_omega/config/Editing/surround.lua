---@type LazySpec
return {
  'kylechui/nvim-surround',

  event = 'BufEnter',

  opts = {
    keymaps = {
      -- See `:h nvim-surround.config.keymaps`.
      normal = 't',
      normal_cur = 'tt',
      normal_line = 'T',
      normal_cur_line = "fTT",
      visual = 't',
      visual_line = 'T',
      delete = 'lt',
      change = 'mt',
      change_line = 'mT',
    },

    aliases = {
        q = { '"', "'", "`" },
        t = { "}", "]", ")", ">", '"', "'", "`" },
        -- We have text-objects for function mapped to `m` as in "method".
        m = "f",
    }
  },

  config = true,
}


