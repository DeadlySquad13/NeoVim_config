local apply_bufferlocal_keymappings = require('ds_omega.config.Ui.which_key.utils').apply_bufferlocal_keymappings

-- Reference: https://vim.fandom.com/wiki/Learn_to_use_help
apply_bufferlocal_keymappings('n', {
    ['<Cr>'] = { '<C-]>', 'Jump to topic under cursor' },
    ['<Bs>'] = { '<C-T>', 'Return to last topic' },
    o = { [[/'\l\{2,\}'<Cr>]], 'To next option' },
    O = { [[?'\l\{2,\}'<Cr>]], 'To previous option' },
    -- Not sure how should it work but it selects everything.
    -- s = { [[/\|\zs\S\+\ze\|<Cr>]], 'To the next subject' },
    -- S = { [[?\|\zs\S\+\ze\|<Cr>]], 'To the previous subject' },
}, { prefix = '' })
