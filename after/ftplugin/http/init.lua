local apply_bufferlocal_keymappings = require('ds_omega.config.Ui.which_key.utils').apply_bufferlocal_keymappings

apply_bufferlocal_keymappings('n', {
    x = { '<Plug>RestNvim', 'Run rest.nvim under cursor' },
    X = { '<Plug>RestNvimPreview', 'Preview cURL command' },
})
