local cmd = require('hydra.keymap-util').cmd

return {
  n = {
    -- I use `i` for jumps extensively. `o` for outline.
    ['<Leader>io'] = {
      cmd 'AerialToggle',
      'Toggle Aerial',
    },
  }
}
