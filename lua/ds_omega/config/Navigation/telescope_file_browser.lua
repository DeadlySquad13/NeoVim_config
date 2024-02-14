return {
  'nvim-telescope/telescope-file-browser.nvim',

  dependencies = { 'nvim-telescope/telescope.nvim', "nvim-lua/plenary.nvim" },

  opts = function()
      local fb_utils = require("telescope._extensions.file_browser.utils")
      local action_state = require("telescope.actions.state")
      local Path = require('plenary.path')

      return {
          -- TODO: Check mappings.
          mappings = {
            i = {
              ["<M-g>"] = function(prompt_bufnr)
                local selections = fb_utils.get_selected_files(prompt_bufnr, false)
                local search_dirs = vim.tbl_map(function(path) return path:absolute() end, selections)
                if vim.tbl_isempty(search_dirs) then
                  local current_finder = action_state.get_current_picker(prompt_bufnr).finder
                  search_dirs = { current_finder.path }
                end
                actions.close(prompt_bufnr)
                require("telescope.builtin").live_grep({ search_dirs = search_dirs })
              end,
              -- TODO: Change it from cycle to simple change of cwd.
              ["<C-e>"] = function(prompt_bufnr)
                local current_picker = action_state.get_current_picker(prompt_bufnr)
                local finder = current_picker.finder
                local bufr_path = Path:new(vim.fn.expand("#:p"))
                local bufr_parent_path = bufr_path:parent():absolute()

                if finder.path ~= bufr_parent_path then
                  finder.path = bufr_parent_path
                  fb_utils.selection_callback(current_picker, bufr_path:absolute())
                else
                  finder.path = vim.loop.cwd()
                end
                fb_utils.redraw_border_title(current_picker)
                current_picker:refresh(finder, {
                  new_prefix = fb_utils.relative_path_prefix(finder),
                  reset_prompt = true,
                  multi = current_picker._multi,
                })
              end,
            },
            -- n = {
            --   ['kk'] = { '<Cmd>echo "Hello, Wordl!"<Cr>', type = "command" },
            -- },
          }
      }
  end,

  config = function()
      local prequire = require('ds_omega.utils').prequire

      local telescope_is_available, telescope = prequire('telescope')

      if not telescope_is_available then
        return 
      end

      telescope.load_extension('file_browser')
  end,
}
