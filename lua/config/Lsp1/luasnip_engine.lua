local prequire = require('utils').prequire;

local luasnip_is_available, luasnip = prequire('luasnip');

if not luasnip_is_available then
  return;
end

local Direction = {
  Forward = 1,
  Backwards = -1,
}

---@see `:h luasnip-api-reference`.
local luasnip_engine = {
  can_jump = function()
    return luasnip.jumpable(Direction.Forward)
  end,

  jump = function()
    return luasnip.jump(Direction.Forward);
  end,

  can_jump_backwards = function()
    return luasnip.jumpable(Direction.Backwards);
  end,

  jump_backward = function()
    return luasnip.jump(Direction.Backwards);
  end,

  can_expand = function()
    return luasnip.expandable();
  end,

  expand = function(args)
    return luasnip.lsp_expand(args.body);
  end,
}

return luasnip_engine;
