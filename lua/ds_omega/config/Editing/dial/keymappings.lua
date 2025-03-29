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
        ["<C-a>"] = { function() return dial_map().inc_normal() end, 'Increment', expr = true },
        ["<C-x>"] = { function() return dial_map().dec_normal() end, 'Decrement', expr = true },
    },
    v = {
        ["<C-a>"] = { function() return dial_map().inc_visual() end, 'Increment', expr = true },
        ["<C-x>"] = { function() return dial_map().dec_visual() end, 'Decrement', expr = true },
        ["g<C-a>"] = { function() return dial_map().inc_gvisual() end, 'Increment dynamically', expr = true },
        ["g<C-x>"] = { function() return dial_map().dec_gvisual() end, 'Decrement dynamically', expr = true },
    },
}
