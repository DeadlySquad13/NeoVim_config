return {
    'mrjones2014/legendary.nvim',
    opts = {
        keymaps = {
            {
                '<leader>H',
                function()
                  print('hello world!')
                end,
                description = 'Say hello',
            },
        }
    },
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
    --
    config = true,
}
