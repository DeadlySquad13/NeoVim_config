local prequire = require('ds_omega.utils').prequire


local keymappings = require("ds_omega.config.keymappings._common.constants").keymappings
local utils = require("ds_omega.config.keymappings._common.utils")
local cmd = utils.cmd

local common_keymappings = {
    -- Navigation.
    h = { cmd 'BufferLineCyclePrev', 'Previous buffer' },
    l = { cmd 'BufferLineCycleNext', 'Next buffer' },
    [keymappings.previous] = { cmd 'BufferLineCyclePrev', 'Previous buffer' },
    [keymappings.next] = { cmd 'BufferLineCycleNext', 'Next buffer' },
    -- Moving buffers.
    H = { cmd 'BufferLineMovePrev', 'Move left' },
    L = { cmd 'BufferLineMoveNext', 'Move right' },
    P = { cmd 'BufferLineTogglePin', 'Toggle Pin' },
    -- Deletes buffer without closing vim if it was in the only window.
    d = { cmd 'Bdelete', 'Delete' },
    D = { cmd '%bdelete', 'Delete' },
    z = { cmd '%bdelete|edit#', 'Delete all buffer except for current one' },
    --see the [lua api](https://github.com/akinsho/bufferline.nvim/blob/main/lua/bufferline.lua)
    --p = { function() bufferline.pick_buffer() end, 'Pick' },
    -- Picking.
    p = { function() vim.cmd('BufferLinePick') end, 'Pick' },
    -- Sorting.
    s = { cmd 'BufferLineSortByRelativeDirectory', 'Sort by relative directory' },
}

local hydra_is_available, Hydra = prequire('hydra')

if hydra_is_available and Hydra then
    local buffer_hydra = Hydra({
        name = 'Buffer',
        heads = vim.tbl_extend('force', utils.transform_to_hydra(common_keymappings), {
            { 'p',     function() vim.cmd('BufferLinePick') end, { desc = 'Pick' } },

            { '<Esc>', nil,                                      { exit = true } }
        }),
    })

    --- Activate only when there're multiple buffers.
    local function activate_buffer_hydra()
        if #vim.fn.getbufinfo({ buflisted = true }) > 1 then
            buffer_hydra:activate()
        end
    end
    common_keymappings = vim.tbl_extend('error', common_keymappings, {
        name = 'Buffer',
        [require('ds_omega.config.keymappings._common.constants').transitive_catalizator] = {
            activate_buffer_hydra,
            'Activate buffer mode'
        },
    })
end

return {
    buffer_keymappings = common_keymappings,
    buffer_change_keymappings = {
        ['<Leader>1'] = { cmd 'BufferLineGoToBuffer 1', 'Choose buffer #1' },
        ['<Leader>2'] = { cmd 'BufferLineGoToBuffer 2', 'Choose buffer #2' },
        ['<Leader>3'] = { cmd 'BufferLineGoToBuffer 3', 'Choose buffer #3' },
        ['<Leader>4'] = { cmd 'BufferLineGoToBuffer 4', 'Choose buffer #4' },
        ['<Leader>5'] = { cmd 'BufferLineGoToBuffer 5', 'Choose buffer #5' },
        ['<Leader>6'] = { cmd 'BufferLineGoToBuffer 6', 'Choose buffer #6' },
        --   Everything beyond 6 is quite hard to estimate fast, you have to
        -- count buffers. Just use one of the methods to pick buffer.
        -- Used for tabpages instead.
        ['<Leader>$'] = { cmd 'BufferLineGoToBuffer -1', 'Choose last buffer' },
    },
}
