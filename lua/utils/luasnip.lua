local s = require('luasnip.nodes.snippet').S
local sn = require('luasnip.nodes.snippet').SN
local t = require('luasnip.nodes.textNode').T
local f = require('luasnip.nodes.functionNode').F
local i = require('luasnip.nodes.insertNode').I
local c = require('luasnip.nodes.choiceNode').C
local d = require('luasnip.nodes.dynamicNode').D
local r = require('luasnip.nodes.restoreNode').R
local l = require('luasnip.extras').lambda
local rep = require('luasnip.extras').rep
local p = require('luasnip.extras').partial
local m = require('luasnip.extras').match
local n = require('luasnip.extras').nonempty
local dl = require('luasnip.extras').dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local conds = require('luasnip.extras.expand_conditions')
local types = require('luasnip.util.types')
local events = require('luasnip.util.events')
local parse = require('luasnip.util.parser').parse_snippet
local ai = require('luasnip.nodes.absolute_indexer')

local function last_after_dot(index)
  return f(function(args)
    local arg = args[1][1]
    local parts = vim.split(arg, '.', true) -- true for literal (non-regex) match.

    -- Some modules such as 'null-ls' have '-' in name which is not a valid
    --   name.
    return parts[#parts]:gsub('-', '_') or ''
  end, { index })
end

--- Set delimiter string if the text is present in another node.
---@param index (number) of the node to look at.
---@param delimiter (string)
---@return (f) function_node node that returns '' or '<delimiter>'.
local function optional_delimiter(index, delimiter)
  return f(function(args)
    local arg = args[1][1]

    if arg == '' then
      return ''
    end

    return delimiter
  end, { index })
end

--local function dynamic_choice(position)
--return d(position, function()
---- the returned snippetNode doesn't need a position; it's inserted
---- "inside" the dynamicNode.
--return sn(nil, c(1, { t 'example', t 'test'}));
--end, {});
--end

--- If the text at node is empty, return '', otherwise insert '.' at the
--beginning to get object field.
---@param index (number) of the node.
---@return (sn) snippet_node node that at the end returns '' or '.field'.
local function optional_field(index)
  return d(index, function()
    -- the returned snippetNode doesn't need a position; it's inserted
    -- "inside" the dynamicNode.
    return sn(nil, { optional_delimiter(1, '.'), i(1) })
  end, {})
end

--- If the text at node is empty, return '', otherwise change it's '.'
--to '\_' to get '\_<postifxpart1_postfixpart2>'.
---@param index (number) of the node to look at.
---@return (f) function_node node that returns \'' or '\_<postifx>'.
local function optional_postifx(index)
  return f(function(args)
    local postfix = args[1][1]
    if postfix == '' then
      return ''
    end

    -- Change '.postifxpart1.postfixpart2' to '_postifxpart1_postfixpart2'.
    return postfix:gsub('%.', '_')
  end, { index })
end

local function selected_text()
  return f(function(_, snip)
    -- TM_SELECTED_TEXT is a table to account for multiline-selections.
    -- In this case only the first line is inserted.
    return snip.env.TM_SELECTED_TEXT[1] or {}
  end, {})
end

local function selected_text_or_i(index)
  return d(index, function(_, parent)
    -- We are inside nested snippet so we need parent's fields.
    local tm_selected_text = parent.snippet.env.TM_SELECTED_TEXT[1]

    local nodes

    if tm_selected_text then
      nodes = {
        t(tm_selected_text or ''),
      }
    else
      nodes = {
        i(1),
      }
    end

    return sn(nil, nodes)
  end, {})
end

local function selected_text_and_i(index)
  return d(index, function(_, parent)
    -- We are inside nested snippet so we need parent's fields.
    local tm_selected_text = parent.snippet.env.TM_SELECTED_TEXT[1]

    local nodes = {
      t(tm_selected_text or ''),
      i(1),
    }

    return sn(nil, nodes)
  end, {})
end


local function optional_sn(index)
  return d(index, function()
    return sn(nil, { t("config = [[ require('"), i(1), t("') ]],") })
  end)
end

---@see [node:get_text](https://github.com/L3MON4D3/LuaSnip/blob/a12441e0598e93e67235eba67c8e6fbffc896f06/lua/luasnip/nodes/node.lua#L107-L134).
-- I basically rewrote it to `set` with the same indices.
-- Actually deletes also one line above...
local function delete_unmodified_node(node)
  local from_pos, to_pos = node.mark:pos_begin_end_raw()

  -- end-exclusive indexing.
  local lines = vim.api.nvim_buf_get_lines(
    0,
    from_pos[1],
    to_pos[1] + 1,
    false
  )

  local node_text = lines[1]:sub(from_pos[2] + 1, to_pos[2])
  local _, left_text_last_pos = node_text:find([[require(']])
  --local _, left_text_last_pos = P(node_text:find([=[config = [[ require(']=]))
  --local _, left_text_last_pos = P(node_text:find("config = [[ require('"))
  local right_text_start_pos, _ = node_text:find("') ")

  local inserted_text_start_pos = left_text_last_pos + 1
  local inserted_node_text = P(node_text:sub(inserted_text_start_pos, right_text_start_pos - 1))
  if inserted_node_text == '' then
    -- Delete the line.
    vim.api.nvim_buf_set_lines(
      0,
      from_pos[1] - 1, -- Delete previous line too.
      to_pos[1] + 1,
      false,
      {}
    )
  end

  -- Get everything on left to the node (indent too).
  --local left_side = P(string.sub(lines[1], 0, from_pos[2]))

end

return {
  s = s,
  sn = sn,
  t = t,
  f = f,
  i = i,
  c = c,
  d = d,
  r = r,
  l = l,
  rep = rep,
  p = p,
  m = m,
  n = n,
  dl = dl,
  fmt = fmt,
  fmta = fmta,
  conds = conds,
  types = types,
  events = events,
  parse = parse,
  ai = ai,

  last_after_dot = last_after_dot,
  optional_delimiter = optional_delimiter,
  optional_field = optional_field,
  optional_postifx = optional_postifx,

  optional_sn = optional_sn,

  selected_text = selected_text,
  selected_text_or_i = selected_text_or_i,
  selected_text_and_i = selected_text_and_i,

  delete_unmodified_node = delete_unmodified_node
}
