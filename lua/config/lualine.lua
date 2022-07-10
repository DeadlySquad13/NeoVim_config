local prequire = require('utils').prequire;
local format_buf_name = require('config.utils').format_buf_name;

local lualine_is_available, lualine = prequire('lualine');

if not lualine_is_available then
  return;
end

-- Returns window number.
--   Really useful for jumping between windows with `<win_number> c-w w`.
local function get_window_number()
  return vim.api.nvim_win_get_number(0);
end

-- Returns current working directory.
local function get_current_working_directory()
  return format_buf_name({ buf_name = vim.fn.getcwd() });
end

lualine.setup {
  options = {
    icons_enabled = true,
    -- It's a combination of gruvbox_light and gruvbox_dark. It loads either of
    --   them based you your background option.
    theme = 'gruvbox',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {{
      'mode',

      --separator = { left = ''},
    }},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    --lualine_c = {'filename'},
    lualine_c = {{
      get_current_working_directory,
    }},
    --lualine_c = {},
    lualine_x = {
      'encoding',
      'fileformat',
      'filetype',
    },
    lualine_y = {'progress'},

    lualine_z = {{
      'location',

      separator = { right = ''}
    }},
  },
  inactive_sections = {
    lualine_a = { get_window_number },
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

--vim.notify('active')
--lualine.setup {
  --options = {
    --icons_enabled = true,
    ---- It's a combination of gruvbox_light and gruvbox_dark. It loads either of
    ----   them based you your background option.
    --theme = 'gruvbox',
    --component_separators = { left = '', right = ''},
    --section_separators = { left = '', right = ''},
    --disabled_filetypes = {},
    --always_divide_middle = true,
    --globalstatus = false,
  --},
  --sections = {
    --lualine_a = {},
    --lualine_b = {{
      --'mode',
      --separator = '',
      --right_padding = 2,
    --}},
    ----lualine_c = {'branch', 'diff', 'diagnostics'},
    --lualine_c = {{
      --separator = { right = '' },
    --}},
    ----lualine_c = {'filename'},
    ----lualine_c = { 'getcwd' },
    ----lualine_c = {},
    ----lualine_x = {'encoding', 'fileformat', 'filetype'},
    --lualine_x = {{
      --'progress',
      --separator = { left = ''},
    --}},
    --lualine_y = {{
      --'location',
      --separator = '',
      --left_padding = 2,
    --}},
    --lualine_z = {},
  --},
  --inactive_sections = {
    --lualine_a = { window_number },
    --lualine_b = {},
    --lualine_c = {'filename'},
    --lualine_x = {'location'},
    --lualine_y = {},
    --lualine_z = {}
  --},
  --tabline = {},
  --extensions = {}
--}
