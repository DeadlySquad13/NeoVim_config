--local api = vim.api;
--local utils = require("winshift.utils")
---@class WindowPickerFilterRules
---@field cur_win boolean
---@field floats boolean
---@field filetype string[]
---@field buftype string[]
---@field bufname string[]

---@class WindowPickerSpec
---@field picker_chars string
---@field filter_rules WindowPickerFilterRules
---@field filter_func fun(winids: integer[]): integer[]

---Get user to pick a window. Selectable windows are all windows in the current
---tabpage.
---@param opt? WindowPickerSpec
---@return integer|nil -- If a valid window was picked, return its id. If an
---       invalid window was picked / user canceled, return nil. If there are
---       no selectable windows, return -1.function M.pick_window(opt)
--local function pick_window(opt)
  --opt = opt or {}
  --local tabpage = api.nvim_get_current_tabpage()
  --local win_ids = api.nvim_tabpage_list_wins(tabpage)
  --local curwin = api.nvim_get_current_win()
  --local filter_rules = opt.filter_rules or {}

  --local selectable = vim.tbl_filter(function (id)
    --if filter_rules.cur_win and curwin == id then
      --return false
    --elseif filter_rules.floats and api.nvim_win_get_config(id).relative ~= "" then
      --return false
    --end

    --local bufid = api.nvim_win_get_buf(id)
    --local bufname = api.nvim_buf_get_name(bufid)

    --for _, option in ipairs({ "filetype", "buftype" }) do
      --if vim.tbl_contains(filter_rules[option] or {}, vim.bo[bufid][option]) then
        --return false
      --end
    --end

    --for _, pattern in ipairs(filter_rules.bufname or {}) do
      --local regex = vim.regex(pattern)
      --if regex:match_str(bufname) ~= nil then
        --return false
      --end
    --end

    --return true
  --end, win_ids)

  --if opt.filter_func then
    --selectable = opt.filter_func(selectable)
  --end

  ---- If there are no selectable windows: return. If there's only 1, return it without picking.
  --if #selectable == 0 then return -1 end
  --if #selectable == 1 then return selectable[1] end

  --local chars = (opt.picker_chars or "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"):upper()
  --local i = 1
  --local win_opts = {}
  --local win_map = {}
  --local laststatus = vim.o.laststatus
  --vim.o.laststatus = 2

  ---- Setup UI
  ---- use to make float https://gitlab.com/yorickpeterse/nvim-window/-/blob/main/lua/nvim-window.lua
  --for _, id in ipairs(selectable) do
    --local char = chars:sub(i, i)
    --local ok_status, statusline = pcall(api.nvim_win_get_option, id, "statusline")
    --local ok_hl, winhl = pcall(api.nvim_win_get_option, id, "winhl")

    --win_opts[id] = {
      --statusline = ok_status and statusline or "",
      --winhl = ok_hl and winhl or ""
    --}
    --win_map[char] = id

    --utils.set_local(
      --id,
      --{
        --statusline = "%=" .. char .. "%=",
        --winhl = {
          --"StatusLine:WinShiftWindowPicker,StatusLineNC:WinShiftWindowPicker",
          --opt = { method = "append" },
        --},
      --}
    --)

    --i = i + 1
    --if i > #chars then break end
  --end

  --vim.cmd("redraw")
  --local ok, resp = pcall(utils.input_char, "Pick window: ", { prompt_hl = "ModeMsg" })
  --if not ok then
    --utils.clear_prompt()
  --end
  --resp = (resp or ""):upper()

  ---- Restore window options
  --for _, id in ipairs(selectable) do
    --for option, value in pairs(win_opts[id]) do
      --api.nvim_win_set_option(id, option, value)
    --end
  --end

  --vim.o.laststatus = laststatus

  --return win_map[resp]
--end

return {
  highlight_moving_win = true,  -- Highlight the window being moved
  focused_hl_group = "Visual",  -- The highlight group used for the moving window
  moving_win_options = {
    -- These are local options applied to the moving window while it's
    -- being moved. They are unset when you leave Win-Move mode.
    wrap = false,
    cursorline = false,
    cursorcolumn = false,
    colorcolumn = "",
  },

  --- A function that should prompt the user to select a window.
  --
  -- The window picker is used to select a window while swapping windows with
  -- `:WinShift swap`.
  -- @return integer? winid # Either the selected window ID, or `nil` to
  --    Indicate that the user cancelled / gave an invalid selection.
  window_picker = function()
    return require('winshift.lib').pick_window({
      -- A string of chars used as identifiers by the window picker.
      picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
      filter_rules = {
        -- This table allows you to indicate to the window picker that a window
        -- should be ignored if its buffer matches any of the following criteria.
        cur_win = true, -- Filter out the current window
        floats = true,  -- Filter out floating windows
        filetype = {  -- List of ignored file types
          "NvimTree",
        },
        buftype = {   -- List of ignored buftypes
          "terminal",
          "quickfix",
        },
        bufname = {   -- List of regex patterns matching ignored buffer names
          [[.*foo/bar/baz\.qux]]
        },
      },
      ---A function used to filter the list of selectable windows.
      ---@param winids integer[] # The list of selectable window IDs.
      ---@return integer[] filtered # The filtered list of window IDs.
      filter_func = nil,
    })
  end,
}

