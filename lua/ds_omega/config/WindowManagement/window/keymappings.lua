return {
    n = {
        ['<C-w>'] = {
            -- Made it similar to tmux, even though there's ctrl-w_w shortcut in vim for
            -- such jump.
            o = { function() require('nvim-window').pick() end, 'Pick window' },
            ['<c-o>'] = { function() require('nvim-window').pick() end, 'Pick window' },
        },
    },
}
