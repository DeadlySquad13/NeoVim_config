local apply_bufferlocal_keymappings = require('config.which_key.utils').apply_bufferlocal_keymappings

apply_bufferlocal_keymappings('n', {
  ['<Cr>'] = { function() require('utils.exec').for_current_file({ 'go', 'run', '.' }) end, 'Run current project' },
})
