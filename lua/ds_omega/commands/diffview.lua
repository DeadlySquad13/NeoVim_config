-- TODO: Transform into module that is loaded only when these commands are
-- loaded. It should also load diffview when called.

local git = require("ds_omega.utils").git

local create_user_command = require('ds_omega.utils.commands').create_user_command

-- STYLE: Add description to our custom args while preserving original.
-- TODO: Add support of another `fargs` and ideally commits.
-- For example, it would be nice to use:
-- DiffviewOpenDsOmega origin/Feature~2
-- See `:h DiffviewOpen` for more examples of what's possible.
create_user_command('DiffviewOpenDsOmega', function(args)
  P('custom')
  if vim.tbl_isempty(args.fargs) then
    return vim.cmd.DiffviewOpen()
  end

  local custom_arg = string.lower(args.fargs[1])

  -- Non-origin version is just `DiffviewOpen`.
  if custom_arg == "origin/current" then
    -- Not equivalent to simply `DiffviewOpen origin/HEAD..HEAD`. See note for
    -- 'default'.
    return vim.cmd.DiffviewOpen('origin/' .. git.get_current_branch_name() .. '..HEAD')
  end

  -- Actually equivalent to just HEAD but decided to leave it like this for
  -- uniformity.
  -- NOTE: origin/HEAD is different from origin of the local HEAD. Locally HEAD is a pointer to
  -- current commit (just branch name if not detached/HEAD).
  -- Remotely, it's a HEAD that is set on remote named 'origin' - in most cases default branch of the
  -- repository when you close it (main/master or other branch configured in VCS).
  if custom_arg == "default" then
    -- Not equivalent to simply `DiffviewOpen` or `DiffviewOpen HEAD`.
    return vim.cmd.DiffviewOpen(git.get_default_branch_name())
  end
  if custom_arg == "origin/default" then
    return vim.cmd.DiffviewOpen('origin/HEAD..HEAD')
  end

  if custom_arg == "feature" then
    return vim.cmd.DiffviewOpen(git.flow.get_feature_branch_name())
  end
  if custom_arg == "origin/feature" then
    return vim.cmd.DiffviewOpen('origin/' .. git.flow.get_feature_branch_name() .. '..HEAD')
  end

  if custom_arg == "epic" then
    return vim.cmd.DiffviewOpen(git.flow.get_epic_branch_name())
  end
  if custom_arg == "origin/epic" then
    return vim.cmd.DiffviewOpen('origin/' .. git.flow.get_epic_branch_name() .. '..HEAD')
  end

  return vim.cmd.DiffviewOpen(string.len(args.args) > 0 and args.args or nil)
end, {
  nargs = '*',
  desc = 'DiffviewOpen with custom workflows around GitFlow',
})
