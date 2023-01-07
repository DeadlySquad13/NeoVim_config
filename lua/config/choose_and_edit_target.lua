local env = require('constants.env')

local gui_settings_paths = {
  goneovim = env.GONEOVIM_SETTINGS,
  fvim = env.GONEOVIM_SETTINGS,
}

local gui_settings_targets = {}

for gui_settings_target, _ in pairs(gui_settings_paths) do
  table.insert(gui_settings_targets, gui_settings_target)
end

local choose_and_edit_gui_settings = function()
  vim.ui.select(gui_settings_targets, {
    prompt = 'Choose gui settings to edit',
    telescope = require('telescope.themes').get_dropdown(),
  }, function(selected)
    if not selected then
      return
    end
    edit_file(gui_settings_paths[selected])
  end)
end

---@type Items
return {
  keymappings = { env.NVIM_LUA, opts = { default_text = 'keymappings' } },
  plugins = { env.NVIM_PLUGINS },
  layers_specification = { env.NVIM_LAYERS_SPECIFICATION },
  vimrc = { '$MYVIMRC' },
  config = { env.NVIM_LUA_CONFIG },
  general_settings = { env.NVIM_GENERAL_SETTINGS },
  layers = { env.NVIM_LAYERS },
  autocommands = { env.NVIM_AUTOCOMMANDS },
  gui = choose_and_edit_gui_settings,
  after = { env.NVIM_AFTER },
  commands = { env.NVIM_LUA, opts = { default_text = 'commands' } }
}
