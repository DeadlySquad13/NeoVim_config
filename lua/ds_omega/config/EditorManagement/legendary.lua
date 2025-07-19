---@type LazySpec
return {
    'mrjones2014/legendary.nvim',
    lazy = false,
    -- Since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins.
    priority = 10000,
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
