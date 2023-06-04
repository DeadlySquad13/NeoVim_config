return {
    'Wansmer/langmapper.nvim',
    lazy = false,
    priority = 1, -- High priority is needed if you will use `autoremap()`.
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
          hack_keymap = false,
          ---@type string Standart English layout (on Mac, It may be different in your case.)
          default_layout = layouts.en .. layouts.en_shift,
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
                  -- layout = [[wfmpv/.q"'z(rsntg,aeihj)xcldb-uoykWFMPV*:Q[]Z{RSNTG;AEIHJ}XCLDB+UOYK]],
                  -- default_layout = [[qwertyuiop[]asdfghjkl;'\zxcvbnm,./QWERTYUIOP{}ASDFGHJKL:"|ZXCVBNM<>?]],
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
    config = function(_, opts)
      require('langmapper').setup(opts)

      local map = require('langmapper').map

      map('n', '<Leader>nb', '<Cmd>Telescope buffers<Cr>')
    end,
}
