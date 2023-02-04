local cmd = require('config.keymappings._common.utils').cmd

return {
  n = {
    -- Format keymappings.
    ['<Leader>f'] = {
      j = { cmd 'TSJJoin', 'Join node under cursor' },
      s = { cmd 'TSJSplit', 'Split node under cursor' },
    }
  },
}
