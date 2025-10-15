---@type LazySpec
return {
    'kevinhwang91/nvim-ufo',

    dependencies = 'kevinhwang91/promise-async',

    config = function(_, opts)
        ---@class Ufo
        local ufo = require('ufo')
        local setters_is_available = prequire('ds_omega.utils.setters')

        local setters = require('ds_omega.utils.setters')

        if setters_is_available then
            setters.set_settings({
                -- Pretty fold column ([even prettier one](https://github.com/kevinhwang91/nvim-ufo/issues/4)):
                -- Arrows are U+2B9{B,A}
                fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],

                foldcolumn = vim.g.started_by_firenvim and '0' or '1',

                foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value
                foldlevelstart = 99,
                -- foldlevelstart = 6
                foldenable = true,
            })
        end


        -- It seems to be overriden by setup_lsp_keymappings. Use amend keymappings plugin for that?
        -- local function peekOrHover()
        --   local winid = ufo.peekFoldedLinesUnderCursor()
        --   if not winid then
        --     vim.lsp.buf.hover()
        --   end
        -- end

        local apply_keymappings_once_ready = require('ds_omega.config.Ui.which_key.utils').apply_keymappings_once_ready
        apply_keymappings_once_ready('n', {
            -- Using ufo provider need remap `zR` and `zM`.
            z = {
                R = { ufo.openAllFolds, 'Close all folds' },
                M = { ufo.closeAllFolds, 'Open all folds' },
            },

            ['<C-j>'] = { ufo.peekFoldedLinesUnderCursor, 'Peek lines' },
        })

        local get_customized_selector = require('ds_omega.config.Ui.ufo.get_customized_selector')
            .get_customized_selector
        local fold_virt_text_handler = require('ds_omega.config.Ui.ufo.fold_virt_text_handler')

        ufo.setup({
            -- Global handler
            -- fold_virt_text_handler = fold_virt_text_handler,
            provider_selector = get_customized_selector,
            open_fold_hl_timeout = 200,
        })

        -- buffer scope handler
        -- will override global handler if it is existed
        local bufnr = vim.api.nvim_get_current_buf()
        ufo.setFoldVirtTextHandler(bufnr, fold_virt_text_handler)

        require('ds_omega.config.Ui.ufo.fold_on_file_open').setup_autocmds()
    end,
}
