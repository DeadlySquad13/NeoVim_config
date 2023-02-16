-- abcd|                    |bcde
-- ████e  ←  Mab    mde  →  █████    (this might also be the desired behavior for Visual `s` - see below)
-- ab██e  ←  Zab    zde  →  ███de
local keymappings = {
    -- Inclusive (move to).
    m = { '<Plug>(leap-forward-to)', 'Leap forward to' },
    M = { '<Plug>(leap-backward-to)', 'Leap backward to' },
    gm = { '<Plug>(leap-from-window)', 'Leap from window' },
    -- Exclusive.
    z = { '<Plug>(leap-forward-till)', 'Leap forward till' },
    Z = { '<Plug>(leap-backward-till)', 'Leap backward till' },
}

return {
    n = keymappings,
    o = keymappings,
    x = keymappings,
}
