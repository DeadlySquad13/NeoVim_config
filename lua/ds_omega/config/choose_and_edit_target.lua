local env = require('ds_omega.constants.env')

local gui_settings_paths = {
  goneovim = env.GONEOVIM_SETTINGS,
  fvim = env.GONEOVIM_SETTINGS,
}

local gui_settings_targets = {}

for gui_settings_target, _ in pairs(gui_settings_paths) do
  table.insert(gui_settings_targets, gui_settings_target)
end

-- TODO: Generalize choose_and_edit_targets and use it instead of this
-- function.
local choose_and_edit_gui_settings = function()
  vim.ui.select(gui_settings_targets, {
    prompt = 'Choose gui settings to edit',
    telescope = require('telescope.themes').get_dropdown(),
  }, function(selected)
    if not selected then
      return
    end
    require('ds_omega.utils.file').edit_file(gui_settings_paths[selected])
  end)
end

-- TODO: Add 'create' action that will trigger create file via template for selected item.
---@type Items
return {
  keymappings = { env.NVIM_LUA, opts = { default_text = 'keymappings' } },
  -- plugins = { env.NVIM_PLUGINS },
  utils = { env.NVIM_LUA, opts = { default_text = 'ds_omega.utils' } },
  layers_specification = { env.NVIM_LAYERS_SPECIFICATION },
  -- vimrc = { '$MYVIMRC' },
  config = { env.NVIM_LUA_CONFIG },
  general_settings = { env.NVIM_GENERAL_SETTINGS },
  layers = { env.NVIM_LAYERS },
  autocommands = { env.NVIM_AUTOCOMMANDS },
  constants = { env.NVIM_CONSTANTS },
  gui = choose_and_edit_gui_settings,
  after = { env.NVIM_AFTER },
  commands = { env.NVIM_LUA, opts = { default_text = 'commands' } }
}
