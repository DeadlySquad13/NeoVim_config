---@type LazySpec
return {
    'kalafut/vim-taskjuggler',

    config = function()
        local utils = require('ds_omega.utils')
        local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd

        local TaskJuggler = create_augroup('TaskJuggler', { clear = true })

        create_autocmd({ 'BufWinEnter' }, {
            group = TaskJuggler,
            desc = "Remove vim-taskjuggler autocmds I don't need",
            pattern = { '*.tji', '*.tjp' },

            callback = function()
                -- Remove this autogroup (removes trailiing white spaces)
                -- because it jumps to the beginning of the line on each save.
                -- https://github.com/kalafut/vim-taskjuggler/blob/e94c9a0b06022d11a34310ad5f82c1c2bcd86fb7/ftplugin/tjp.vim
                vim.api.nvim_clear_autocmds({
                    group = 'TaskJugglerSource',
                })
            end,
        })
    end
}
