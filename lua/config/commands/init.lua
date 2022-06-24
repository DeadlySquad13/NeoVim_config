local choose_and_edit_target = require('config.commands.choose_and_edit_target');

vim.api.nvim_create_user_command(
    'ChooseAndEditConfigs',
    choose_and_edit_target,
    { nargs = 0 }
);
