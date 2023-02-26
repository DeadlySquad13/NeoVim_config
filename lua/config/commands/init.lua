local create_user_command = require('config.commands.utils').create_user_command

-- See `:h user-commands` and `:h nvim_create_user_command()`.

create_user_command(
  'ChooseAndEditConfigs',
  require('config.commands.choose_and_edit_configs'),
  { nargs = 0 }
)

local command_modules = {
  'profile',
  'utility',
  'snippets',
}
for _, module in ipairs(command_modules) do
  prequire('config.commands.'..module)
end
