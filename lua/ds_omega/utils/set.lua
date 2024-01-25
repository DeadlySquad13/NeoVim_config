local Set = {}

--- Convert list to the table that you can use for fast find.
---@param list (table) list of items { 'a', 'b', 'c' }.
---@return (table) table #table of items { 'a' = true, 'b' = true, 'c' = true }.
---@ref see [luadoc arithmetic metamethods](https://www.lua.org/pil/13.1.html)
--for further set implementation.
Set.Set = function(list)
  local set = {}
  for _, item in ipairs(list) do
    set[item] = true
  end
  return set
end

Set.SetIntersection = function(a, b)
  local res = {}
  if not a then
    return nil
  end
  if not b then
    return a
  end

  for k in pairs(a) do
    res[k] = b[k]
  end
  return res
end

return Set
