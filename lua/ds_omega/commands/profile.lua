local create_user_command = require('ds_omega.utils.commands').create_user_command

create_user_command(
  'ProfileStart',
  function(params)
    vim.cmd.profile({ args = { 'start', params.args } })
    vim.cmd.profile({ args = { 'func', '*' } })
    vim.cmd.profile({ args = { 'file', '*' } })
  end,
  -- TODO: Make it optional with default value.
  -- Name of the log file.
  { nargs = 1 }
)

create_user_command(
  'ProfilePause',
  function(_params)
    vim.cmd.profile({ args = { 'pause' } })
    vim.cmd.profile({ args = { 'dump' } })
  end,
  { nargs = 0 }
)
