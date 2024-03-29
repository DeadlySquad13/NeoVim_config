-- abcd|                    |bcde
-- ████e  ←  Mab    mde  →  █████    (this might also be the desired behavior for Visual `s` - see below)
-- ab██e  ←  Zab    zde  →  ███de
local leap_to_keymappings = {
    i = { '<Plug>(leap-forward-to)', 'Leap forward to' },
    I = { '<Plug>(leap-backward-to)', 'Leap backward to' },
}

local keymappings = vim.tbl_extend('error', leap_to_keymappings, {
        -- Inclusive (move to).
        gi = { '<Plug>(leap-from-window)', 'Leap from window' },
        -- Exclusive.
        z = { '<Plug>(leap-forward-till)', 'Leap forward till' },
        Z = { '<Plug>(leap-backward-till)', 'Leap backward till' },
    })

return {
    n = leap_to_keymappings,
    o = leap_to_keymappings,
    x = keymappings,
}
