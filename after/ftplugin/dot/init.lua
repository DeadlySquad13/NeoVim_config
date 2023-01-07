local apply_bufferlocal_keymappings = require('config.Ui.which_key.utils').apply_bufferlocal_keymappings

apply_bufferlocal_keymappings('n', {
  ['<Cr>'] = { [[<Cmd>! dotPng %:r<Cr>]], 'Create png from name of the current file' }, -- Use kroki like in mermaid?
  ['sr'] =  {[[^"yct-<Esc>2W"yP"yD^X"yPa<Space><Esc>]], 'Swap relationships' } -- Unpolished.

})
