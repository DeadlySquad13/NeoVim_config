local M = {}

-- How to specify it programatically (start and end of the range)?
local special_symbols = {
  -- Mathematical Alphanumeric Symbols (Range: 1D400—1D7FF).
  A = '𝐀',
  B = '𝐁',
  C = '𝐂',
  D = '𝐃',
  E = '𝐄',
  F = '𝐅',
  G = '𝐆',
  H = '𝐇',
  I = '𝐈',
  J = '𝐉',
  K = '𝐊',
  L = '𝐋',
  M = '𝐌',
  N = '𝐍',
  O = '𝐎',
  P = '𝐏',
  Q = '𝐐',
  R = '𝐑',
  S = '𝐒',
  T = '𝐓',
  U = '𝐔',
  V = '𝐕',
  W = '𝐖',
  X = '𝐗',
  Y = '𝐘',
  Z = '𝐙',
}

-- pos - index of a char to replace,
-- str - string we want to modify,
-- r - replacement char (char to replace).
local function replace_char(pos, str, r)
  -- Checking for nil pos (kind of ternary operator).
  return not pos and str or str:sub(1, pos - 1) .. r .. str:sub(pos + 1)
end

-- TODO: use <https://github.com/delphinus/artify.nvim> 'artify.nvim'
-- Formats first found character according to dictionary of a special symbols.
-- str - string to format,
-- char - character to find.
local function format(str, char)
  -- - Checking for nil str and characters that will be interpreted wrong (as regex?).
  if not str or char == '.' then
    return str
  end

  -- - Case insensitive search because we have only capitals in dictionary.
  return replace_char(str:upper():find(char), str, special_symbols[char])
end

-- TOFIX: Prefer uppercase letters.
-- Iterates through mappings, applying `format` function.
local function format_mappings_names(mappings, group_mapping_key)
  local formatted_mappings = {}

  -- If we get key like: '<space>gd' we will get an error, so get only last
  --   char.
  local group_mapping_key_char = group_mapping_key:sub(-1):upper()

  for key, mapping in pairs(mappings) do
    if key == 'name' then
      -- Now have only capitals in dictionary so uppercasing.
      formatted_mappings[key] = format(mapping, group_mapping_key_char)
    else
      -- Analogous to group_mapping_key_char.
      local key_char = key:sub(-1):upper()

      -- Mapping group.
      if mapping.name then
        formatted_mappings[key] = format_mappings_names(mapping, key_char)
      else
        local mapping_name = mapping[2]

        -- Now have only capitals in dictionary so uppercasing.
        mapping[2] = format(mapping_name, key_char)
        formatted_mappings[key] = mapping
      end
    end
  end

  return formatted_mappings
end

---@class DefaultKeymapOptions
---@field buffer (number) Specify a buffer number for buffer local mappings.
---@see which_key documentation for all options.
local default_keymap_options = {
  prefix = '',
  silent = true, -- use `silent` when creating keymaps.
  -- Use `noremap` when creating keymaps (when command starts with <Plug>,
  -- noremap = false is set automatically).
  noremap = true,
  nowait = false, -- use `nowait` when creating keymaps
}

---  Merge passed options with default options ensuring that there's no mode in
-- passed table.
---@params options (DefaultKeymapOptions?) Options to pass into mappings.
local function options_with_defaults(options)
  options = options or {}

  ---@diagnostic disable-next-line: undefined-field
  if options.mode then
    return notify(
      'Mode options passed in `custom_options` table is overriden by `mode` argument!',
      { title = 'Keymapping' }
    )
  end

  local options = vim.tbl_extend(
    'force',
    default_keymap_options,
    options
  )

  return options
end

local prequire = require('utils').prequire

---@union Mode
M.MODES = { 'n', 'v', 'i', 's', 'o', 'c', 't' }

---@param mode (Mode)
---@param keymappings
---@param custom_options (DefaultKeymapOptions?) Options to pass into mappings.
M.apply_keymappings = function(mode, keymappings, custom_options)
  local which_key_is_available, which_key = prequire('which-key')

  if not which_key_is_available then
    return
  end

  local options = options_with_defaults(custom_options)
  options.mode = mode

  return which_key.register(format_mappings_names(keymappings, 'M'), options)
end

local keymappings_group = require('utils').create_augroup('Keymappings', { clear = true })

---@param mode (Mode)
---@param keymappings
---@param custom_options (DefaultKeymapOptions?) Options to pass into mappings.
M.apply_keymappings_once_ready = function(mode, keymappings, custom_options)
  require('utils').create_autocmd(
      { 'BufWinEnter' },
      {
        group = keymappings_group,
        desc = 'Apply keymappings once which_key is loaded.',

        callback = function()
          vim.schedule(function()
            M.apply_keymappings(mode, keymappings, custom_options)
          end)
        end,

        once = true,
      }
  );
end

---  Apply bufferlocal keymappings with sensible defaults:
-- add buffer = 0 to options and assign <localleader> prefix to keymappings.
---@param mode (Mode)
---@param keymappings
---@param custom_options (DefaultKeymapOptions?) Options to pass into mappings.
M.apply_bufferlocal_keymappings = function(mode, keymappings, custom_options)
  local options = vim.tbl_extend('error', -- If you don't want buffer = 0 then you should use another function.
    { buffer = 0 },
    custom_options or {}
  )

  local options = vim.tbl_extend('force',
    options,
    { prefix = '<localleader>' }
  )

  M.apply_keymappings_once_ready(mode, keymappings, options)
end

return M
