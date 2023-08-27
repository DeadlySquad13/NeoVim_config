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
    }
  },

  config = true,
}


