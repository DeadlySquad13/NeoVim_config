return {
    'hiphish/rainbow-delimiters.nvim',

    ---@type rainbow_delimiters.config
    opts = {
        highlight = {
            'rainbowcol1',
            'rainbowcol2',
            'rainbowcol3',
            'rainbowcol4',
            'rainbowcol5',
            'rainbowcol6',
            'rainbowcol7',
        },
    },
    
    config = function(_, opts)
        vim.g.rainbow_delimiters = opts
    end
}
