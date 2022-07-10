local cmp = require('cmp')
local snippets_engine = require('config.lsp.luasnip_engine')
local ls = require('luasnip')
local ls_select_choice = require('luasnip.extras.select_choice')
local utils = require('config.lsp.utils')
local t = utils.t

local neogen = require('neogen')
return {
  ['<Tab>'] = cmp.mapping({
    c = function(fallback)
      if cmp.visible() then
        -- cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        -- `select = true` enables immediate autocomplete without selection
        --   <c-space><tab> gives the first result.
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
      else
        --cmp.complete();
        fallback()
      end
    end,

    i = function(fallback)
      if cmp.visible() then
        -- If you haven't started browsing snippets yet, choose next (first).
        -- if not cmp.get_active_entry() then
        --   return cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        -- end
        --if snippets_engine.can_expand() then
        --return snippets_engine.expand()
        --end

        return cmp.confirm({ select = true })
      else
        fallback()
      end
    end,
    -- s = function(fallback)
    --   if vim.fn['UltiSnips#CanJumpForwards']() == 1 then
    --     vim.api.nvim_feedkeys(t('<Plug>(ultisnips_jump_forward)'), 'm', true)
    --   else
    --     fallback()
    --   end
    -- end,
  }),

  -- Just defining function doesn't work.
  ['<c-j>'] = cmp.mapping(function(fallback)
    if snippets_engine.can_jump() then
      return snippets_engine.jump()
    end

    -- Not yet intergrated with ultisnips, have to separately define jumps
    --   in mappings.
    if neogen.jumpable() then
      return neogen.jump_next()
    end

    return fallback()
  end, { 'i', 'c', 's' }),

  -- Just defining function doesn't work.
  ['<c-k>'] = cmp.mapping(function(fallback)
    if snippets_engine.can_jump_backwards() then
      return snippets_engine.jump_backward()
    end

    local backwards = true
    -- Not yet intergrated with ultisnips, have to separately define jumps
    --   in mappings.
    if neogen.jumpable(backwards) then
      return neogen.jump_prev()
    end

    return fallback()
  end, { 'i', 'c', 's' }),

  ['<Down>'] = cmp.mapping(
    cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    { 'i' }
  ),
  ['<Up>'] = cmp.mapping(
    cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    { 'i' }
  ),

  ['<C-n>'] = cmp.mapping({
    c = function()
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
      else
        vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
      end
    end,

    i = function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
      else
        fallback()
      end
    end,
  }),

  ['<C-p>'] = cmp.mapping({
    c = function()
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Replace })
      else
        vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
      end
    end,

    i = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Replace })
      else
        fallback()
      end
    end,
  }),

  ['<C-s>'] = cmp.mapping(function(fallback)
    if ls.choice_active() then
      return ls_select_choice()
    end
    return fallback()
  end, { 'i', 'c' }),

  ['<C-l>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      -- Filter more precise matches:
      --   from de: { date, debug, defining } only { debug, defining } are
      --   left as they have complete common string.
      return cmp.complete_common_string()
    end

    if ls.choice_active() then
      return ls.change_choice(1)
    end

    return fallback()
  end, { 'i', 'c' }),

  ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),

  ['<C-x><C-o>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),

  ['<C-e>'] = cmp.mapping(function()
    if cmp.visible() then
      return cmp.close()
    end

    return cmp.complete()
  end, { 'i', 'c' }),
}
