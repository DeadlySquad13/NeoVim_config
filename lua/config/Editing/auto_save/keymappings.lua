local cmd = require('config.keymappings._common.utils').cmd

return {
  n = {
    ['<Leader>t'] = {
      s = { cmd 'ASToggle', 'Auto Save'}
    }
  }
}
