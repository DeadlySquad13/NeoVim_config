local options = {
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,
}

require('ds_omega.utils.setters').set_local_settings(options)

local apply_bufferlocal_keymappings = require('ds_omega.config.Ui.which_key.utils').apply_bufferlocal_keymappings

apply_bufferlocal_keymappings('n', {
  ['<Cr>'] = { '<Cmd>:!python %<Cr>', 'Run current file' },
})
