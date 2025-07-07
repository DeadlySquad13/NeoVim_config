local function dial_map()
    local prequire = require('ds_omega.utils').prequire

    local dial_map_is_available, dial_map = prequire('dial.map')

    if not dial_map_is_available then
        return
    end

    return dial_map
end

return {
    n = {
        ["<C-a>"] = { function() dial_map().manipulate('increment', 'normal') end, 'Increment', expr = false },
        ["<C-x>"] = { function() dial_map().manipulate('decrement', 'normal') end, 'Decrement', expr = false },
    },
    v = {
        ["<C-a>"] = { function() return dial_map().manipulate('increment', 'visual') end, 'Increment', expr = false },
        ["<C-x>"] = { function() return dial_map().manipulate('decrement', 'visual') end, 'Decrement', expr = false },
        ["g<C-a>"] = { function() return dial_map().manipulate('increment', 'gvisual') end, 'Increment dynamically', expr = false },
        ["g<C-x>"] = { function() return dial_map().manipulate('decrement', 'gvisual') end, 'Decrement dynamically', expr = false },
    },
}
