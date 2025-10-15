local Hydra = require('hydra')
local cmd = require('hydra.keymap-util').cmd

local syntax_tree_surfer_hydra = Hydra({
    name = 'SyntraxTreeSurfer',
    mode = 'x',
    heads = {
        { '<Down>', cmd 'STSSelectNextSiblingNode',      { desc = 'Select next sibling node' } },
        { '<Up>', cmd 'STSSelectPrevSiblingNode',      { desc = 'Select previous sibling node' } },
        { '<Right>', cmd 'STSSelectParentNode',           { desc = 'Select parent node' } },
        { '<Left>', cmd 'STSSelectChildNode',            { desc = 'select child node' } },

        -- Swapping Nodes in Visual Mode.
        { 'd', cmd 'STSSwapNextVisual',             { desc = 'Swap with next node' } },
        { 'u', cmd 'STSSwapPrevVisual',             { desc = 'Swap with previous node' } },
        { '<Esc>', nil,                                      { exit = true } }
    }
})

return syntax_tree_surfer_hydra
