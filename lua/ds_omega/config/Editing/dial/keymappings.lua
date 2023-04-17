local prequire = require('ds_omega.utils').prequire

local dial_map_is_available, dial_map = prequire('dial.map')

if not dial_map_is_available then
  return
end

return {
    n = {
        ["<C-a>"] = { dial_map.inc_normal(), 'Increment' },
        ["<C-x>"] = { dial_map.dec_normal(), 'Decrement' },
    },
    v = {
        ["<C-a>"] = { dial_map.inc_visual(), 'Increment' },
        ["<C-x>"] = { dial_map.dec_visual(), 'Decrement' },
        ["g<C-a>"] = { dial_map.inc_gvisual(), 'Increment dynamically' },
        ["g<C-x>"] = { dial_map.dec_gvisual(), 'Decrement dynamically' },
    },
}
