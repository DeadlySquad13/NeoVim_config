local apply_bufferlocal_keymappings = require('config.which_key.utils').apply_bufferlocal_keymappings

apply_bufferlocal_keymappings('n', {
  ['<Cr>'] = { [[<Cmd>:!kroki convert % --type mermaid && kroki convert % --type mermaid --format png<Cr>]], 'Convert current file to svg and png' },
})
