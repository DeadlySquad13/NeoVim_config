---@type LazySpec
return {
  'rmagatti/auto-session',

  lazy = false,

  opts = {
    log_level = 'info',
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.fn.expand(require('ds_omega.constants.env').NVIM_DATA .. '/sessions/'),
    auto_session_enabled = true,
    auto_save_enabled = nil,
    auto_restore_enabled = nil,
    auto_session_suppress_dirs = nil,
    auto_session_use_git_branch = true,
    bypass_session_save_file_types = nil,


    -- Argument handling
    args_allow_single_directory = true, -- Follow normal session save/load logic if launched with a single directory as the only argument
    args_allow_files_auto_save = true, -- Allow saving a session even when launched with a file argument (or multiple files/dirs). It does not load any existing session first. Can be true or a function that returns true when saving is allowed. See documentation for more detail
  },
}
