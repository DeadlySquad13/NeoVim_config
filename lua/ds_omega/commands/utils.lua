-- Creating our own function in case we want globally change behavior.
---@see `:h user-commands` and `:h nvim_create_user_command()`.
local function create_user_command(name, command, opts)
  vim.api.nvim_create_user_command(
    name,
    command,
    opts
  );
end

return {
  create_user_command = create_user_command,
}
