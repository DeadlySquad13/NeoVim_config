return {
  'echasnovski/mini.files',
  version = false,

  opts = {
    mappings = {
      close       = 'q',
      go_in       = '<Cr>',
      -- Go in and change main column to the new view.
      go_in_plus  = '<S-Cr>',
      go_out      = '<Esc>',
      -- Go out and change main column to the new view.
      go_out_plus = '<S-Esc>',
      reset       = '<BS>',
      reveal_cwd  = '@',
      show_help   = 'g?',
      synchronize = '=',
      trim_left   = '<',
      trim_right  = '>',
    },
  },

  config = function(_, opts)
    require('mini.files').setup(opts)

    local utils = require('ds_omega.utils')
    local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd

    local function mini_files_get_current_dir()
      -- Works only if cursor is on the valid file system entry
      local cur_entry_path = MiniFiles.get_fs_entry().path
      local cur_directory = vim.fs.dirname(cur_entry_path)

      return cur_directory
    end

    local mini_files_set_cwd = function()
      vim.fn.chdir(mini_files_get_current_dir())
    end

    create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      desc = 'Add change current directory to current directory inside MiniFiles',
      callback = function(args)
        vim.keymap.set('n', 'cd', mini_files_set_cwd, { buffer = args.data.buf_id })
      end,
    })

    local function mini_files_live_grep()
      local prequire = require('ds_omega.utils').prequire

      local builtin_is_available, builtin = prequire('telescope.builtin')

      if not builtin_is_available or not builtin then
        return
      end

      builtin.live_grep({
        prompt_title = 'Live Grep from MiniFiles',
        cwd = mini_files_get_current_dir(),
      })
    end

    create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      desc = 'Live grep from current directory inside MiniFiles',
      callback = function(args)
        vim.keymap.set('n', '<Leader>ng', mini_files_live_grep, { buffer = args.data.buf_id })
      end,
    })
  end,
}
