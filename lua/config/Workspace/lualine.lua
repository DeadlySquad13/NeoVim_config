local prequire = require('utils').prequire

local recorder_is_available, recorder = prequire('recorder')

local format_buf_name = require('config.utils').format_buf_name;

-- Returns window number.
--   Really useful for jumping between windows with `<win_number> c-w w`.
local function get_window_number()
  return vim.api.nvim_win_get_number(0);
end

-- Returns current working directory.
local function get_current_working_directory()
  return format_buf_name({ buf_name = vim.fn.getcwd() });
end
local globalstatus = vim.o.laststatus == 3

return {
    options = {
        icons_enabled = true,
        theme = 'gruvbox',
        -- It's a combination of gruvbox_light and gruvbox_dark. It loads either of
        --   them based you your background option.
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = globalstatus,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { {
            get_current_working_directory,
        } },

        lualine_x = {
            'progress', 'diagnostics'
        },
        lualine_y = { 'diff' },

        lualine_z = { recorder_is_available and recorder.displaySlots or nil }
    },
    inactive_sections = not globalstatus and {
        lualine_a = { get_window_number },
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    } or nil,
    tabline = {},
    extensions = {}
}
