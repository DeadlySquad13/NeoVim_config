local env = require('global');

-- TODO: make function `open_lua_module` that will check if the directory has
--   only one file (init.lua). If it has - open it, otherwise call telescope
--   find_files in this directory.
local function traverse_keymappings_directory()
  require('telescope.builtin').find_files({ cwd = env.NVIM_KEYMAPPINGS })
end

local function open_plugins()
  vim.cmd(':e ' .. env.NVIM_PLUGINS)
end

local function open_vimrc()
  vim.cmd(':e $MYVIMRC')
end

local edit_actions = {
  keymappings = traverse_keymappings_directory,
  plugins = open_plugins,
  vimrc = open_vimrc,
}

local edit_targets = {}

local i = 0;

for edit_target,_ in pairs(edit_actions) do
  i = i + 1;
  edit_targets[i] = edit_target;
end

local choose_and_edit_target = function()
  vim.ui.select(edit_targets, {
    prompt = 'Choose target to edit',
    telescope = require("telescope.themes").get_dropdown(),
  }, function(selected)
      if not selected then
        return;
      end
      edit_actions[selected]();
    end
  )
end

return choose_and_edit_target;
