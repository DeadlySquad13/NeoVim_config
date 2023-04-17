local U = require('Comment.utils')
local Op = require('Comment.opfunc')
local A = vim.api

local IndexedSet = require('ds_omega.utils').IndexedSet

local semantic_comments_symbols = {
  '#',
  '*',
  '-',
}

local semantic_comments_symbols_set = IndexedSet(semantic_comments_symbols)

-- TODO: Check for cfg.region.
-- REFACTOR: Merge simillar parts of comment and uncomment into functions. Take
--   inspiration from Op module.

---
---@param range (CommentRange)
local function comment_semantically(range)
  -- s - start, e - end.
  local srow, erow = range.srow, range.erow

  local lines = A.nvim_buf_get_lines(0, srow - 1, erow, false)

  -- commentstring.
  local cstr = vim.bo.commentstring
  -- l - left, r - right; cs - commentstring.
  local lcs, rcs = U.unwrap_cstr(cstr)

  -- TODO: add padding param in the func call and pass here.
  local _, pp = U.get_padding(nil) -- pp - padding pattern.
  local lcs_escaped, rcs_escaped = U.escape(lcs), U.escape(rcs)
  local is_commented = U.is_commented(lcs_escaped, rcs_escaped, pp)

  -- Judge by first string.
  if not is_commented(lines[1]) then
    return Op.linewise({
      cfg = { padding = true },
      cmode = U.cmode.comment,
      lcs = lcs,
      rcs = rcs,
      range = {
        srow = srow,
        erow = erow,
      },
      lines = lines,
    })
  end

  local lines_modified = {}
  for i, line in ipairs(lines) do
    -- Match lcs with any number of spaces: '(--     )* Comment!'
    local lcs_with_margin_spos, lcs_with_margin_epos = line:find(
      lcs_escaped .. ' *'
    )

    -- Assuming all symbols are 1 char length.
    local lcs_with_margin = line:sub(lcs_with_margin_spos, lcs_with_margin_epos)
    local semantic_symbol = line:sub(
      lcs_with_margin_epos + 1,
      lcs_with_margin_epos + 1
    )

    local semantic_level = semantic_comments_symbols_set[semantic_symbol]

    local lcs_semantic
    local new_lcs_semantic

    if semantic_level then
      if semantic_level < #semantic_comments_symbols then
        local next_semantic_symbol =
        semantic_comments_symbols[semantic_level + 1]

        lcs_semantic = lcs_with_margin .. semantic_symbol
        new_lcs_semantic = lcs_with_margin .. next_semantic_symbol
      else
        -- Reached the highest level, don't change anything.
        lcs_semantic = lcs_with_margin .. semantic_symbol
        new_lcs_semantic = lcs_with_margin .. semantic_symbol
      end
    end

    lines_modified[i] = line:gsub(
      U.escape(lcs_semantic or lcs_with_margin),
      new_lcs_semantic or lcs_with_margin .. semantic_comments_symbols[1] .. ' ',
      1
    )
  end

  vim.api.nvim_buf_set_lines(0, srow - 1, erow, false, lines_modified)
end

---@example:
-- test           -- test
-- -- test        -- - test
-- -- # adsf: =>  -- * adsf:
-- --  * test     --  - test
-- -- - vzxc:     -- - vzxc:
-- --  # vzxc     --  * vzxc
-- TOFIX: remove error when first line is comment and some line in range is not.
function _G.___comment_semantically(vmode)
  local range = U.get_region(vmode)
  return comment_semantically(range)
end

function _G.___comment_semantically_current_line()
  local _, range = U.get_count_lines(1) -- Get current line.
  return comment_semantically(range)
end

---
---@param range (CommentRange)
local function uncomment_semantically(range)
  -- s - start, e - end.
  local srow, erow = range.srow, range.erow
  local lines = A.nvim_buf_get_lines(0, srow - 1, erow, false)

  -- commentstring.
  local cstr = vim.bo.commentstring
  -- l - left, r - right; cs - commentstring.
  local lcs, rcs = U.unwrap_cstr(cstr)

  -- TODO: add padding param in the func call and pass here.
  local _, pp = U.get_padding(nil) -- pp - padding pattern.
  local lcs_escaped, rcs_escaped = U.escape(lcs), U.escape(rcs)
  local is_commented = U.is_commented(lcs_escaped, rcs_escaped, pp)

  -- Judge by first string.
  if not is_commented(lines[1]) then
    return
  end

  local lines_modified = {}
  for i, line in ipairs(lines) do
    -- Match lcs with any number of spaces: '(--     )* Comment!'
    local lcs_with_margin_spos, lcs_with_margin_epos = line:find(
      lcs_escaped .. ' *'
    )

    -- Assuming all symbols are 1 char length.
    local lcs_with_margin = line:sub(lcs_with_margin_spos, lcs_with_margin_epos)
    local semantic_symbol = line:sub(
      lcs_with_margin_epos + 1,
      lcs_with_margin_epos + 1
    )

    local semantic_level = semantic_comments_symbols_set[semantic_symbol]

    local lcs_semantic
    local new_lcs_semantic

    if semantic_level then
      if semantic_level > 1 then
        local next_semantic_symbol =
        semantic_comments_symbols[semantic_level - 1]

        lcs_semantic = lcs_with_margin .. semantic_symbol
        new_lcs_semantic = lcs_with_margin .. next_semantic_symbol
      else
        -- Reached the lowest level, remove semantic symbol.
        lcs_semantic = lcs_with_margin .. semantic_symbol
        new_lcs_semantic = lcs
      end
    end

    lines_modified[i] = line:gsub(
      U.escape(lcs_semantic or lcs_with_margin),
      new_lcs_semantic or '', -- No semantic levels, just uncomment.
      1
    )
  end

  vim.api.nvim_buf_set_lines(0, srow - 1, erow, false, lines_modified)
end

---@example:
-- -- test        test
-- -- - test      -- test
-- -- * adsf: =>  -- # adsf: =>
-- --  - test     --  * test
-- -- - vzxc:     -- - vzxc:
-- --  * vzxc     --  # vzxc
-- TOFIX: remove error when first line is comment and some line in range is not.
function _G.___uncomment_semantically(vmode)
  local range = U.get_region(vmode)
  return uncomment_semantically(range)
end

function _G.___uncomment_semantically_current_line()
  local _, range = U.get_count_lines(1) -- Get current line.
  return uncomment_semantically(range)
end
