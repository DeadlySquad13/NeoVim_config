return {
    'Wansmer/langmapper.nvim',
    lazy = false,
    priority = 1, -- High priority is needed if you will use `autoremap()`.
    cond = true,
    opts = function()
      local im_select_get_current_layout_id = function()
        local cmd = 'im-select'
        if vim.fn.executable(cmd) then
          local output = vim.split(vim.trim(vim.fn.system(cmd)), '\n')
          return output[#output]
        end
      end
      local layouts = require('langmap').layouts

      return {
          ---@type boolean Wrap all keymap's functions (nvim_set_keymap etc)
          hack_keymap = true,
          ---@type string Standart layout which you use to make keymappings. In
          ---my case I've mapped everything as if it was hdn, not en layout.
          --- If you want to be sure other people understand your config, it's
          --- better to map as if you're in en layout, set here en layout and
          --- just translate it to another layout. It makes easier to
          --- change to another layout too.
          default_layout = layouts.hands_down_neu .. layouts.hands_down_neu_shift,
          ---@type string[] Names of layouts. If empty, will handle all configured layouts.
          use_layouts = { 'ru' },
          layouts = {
              ru = {
                id = '1049',
                layout = layouts.ru .. layouts.ru_shift,
                default_layout = nil,
              },
              hdn = {
                  id = '1033',
                  layout = layouts.hands_down_neu .. layouts.hands_down_neu_shift,
                  default_layout = nil,
              },
          },
          os = {
              -- Darwin - Mac OS, the result of `vim.loop.os_uname().sysname`
              Darwin = {
                  ---Function for getting current keyboard layout on your OS
                  ---Should return string with id of layout
                  ---@return string
                  get_current_layout_id = im_select_get_current_layout_id,
              },
              Windows_NT = {
                  ---Function for getting current keyboard layout on your OS
                  ---Should return string with id of layout
                  ---@return string
                  get_current_layout_id = im_select_get_current_layout_id,
              },
          },
      }
    end,
}
