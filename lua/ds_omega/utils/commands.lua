local M = {}

-- QUESTION: Do we need to namespace every command? For example,
-- `DsOmegaCommandName` or `CommandNameDsOmega` (Unfortunately, DsOmega- isn't allowed. Maybe nest
-- commands as subcommands 'DsOmega CommandName'. Will it affect lazy-loading?)
-- Creating our own function in case we want globally change behavior.
---@see `:h user-commands` and `:h nvim_create_user_command()`.
M.create_user_command = function(name, command, opts)
  vim.api.nvim_create_user_command(
    name,
    command,
    opts
  );
end

return M
