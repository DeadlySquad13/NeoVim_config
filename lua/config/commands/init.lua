local choose_and_edit_target = require('config.commands.choose_and_edit_target')
local is_loaded = require('utils').is_loaded
local create_user_command = require('config.commands.utils').create_user_command
local ENV = require('constants.env')

---@see `:h user-commands` and `:h nvim_create_user_command()`.

create_user_command(
  'ChooseAndEditConfigs',
  choose_and_edit_target,
  { nargs = 0 }
)

local luasnip_loaders_is_available, luasnip_loaders = pcall(
  require,
  'luasnip.loaders'
)

-- LuaSnip engine commands for editing snippets.
if luasnip_loaders_is_available then
  create_user_command('ChooseLuaSnipEdit', luasnip_loaders.edit_snippet_files, {
    nargs = 0,
  })
  -- TODO: check how to pick automatically appropriate file.
  create_user_command('LuaSnipEdit', luasnip_loaders.edit_snippet_files, {
    nargs = 0,
  })

  create_user_command('LuaSnipSource', function()
    local luasnip_config_path = ENV.NVIM_LUA_CONFIG .. '/luasnip.lua'
    local sourced_successfully = pcall(
      vim.cmd,
      'source ' .. luasnip_config_path
    )

    if not sourced_successfully then
      return notify(
        'Could not load config `' .. luasnip_config_path .. '`!',
        vim.log.levels.ERROR,
        {
          title = 'LuaSnip',
        }
      )
    end

    return notify('Sourced config', vim.log.levels.SUCCESS, {
      title = 'LuaSnip',
    })
  end, {
    nargs = 0,
    desc = 'Source LuaSnip file to reload snippets and settings',
  })
end

-- Deciding which snippet engine command to use for editing snippets.
if luasnip_loaders_is_available then
  create_user_command('ChooseSnippetsEdit', 'LuaSnipEdit', {
    nargs = 0,
  })
elseif is_loaded('ultisnips') then
  create_user_command('ChooseSnippetsEdit', 'UltiSnipsEdit!', {
    nargs = 0,
  })
  create_user_command('SnippetsEdit', 'UltiSnipsEdit', {
    nargs = 0,
  })
end

---@ref https://github.com/mrjones2014/load-all.nvim
local fileExtension = '.lua'

local function is_lua_file(filename)
  return filename:sub(- #fileExtension) == fileExtension
end

local function load_all(path, depth)
  local scan = require('plenary.scandir')
  for _, file in ipairs(scan.scan_dir(path, { depth = depth or 0 })) do
    if is_lua_file(file) then
      dofile(file)
    end
  end
end

create_user_command(
  'ProfileStart',
  function(params)
    vim.cmd.profile({ args = { 'start', params.args } })
    vim.cmd.profile({ args = { 'func', '*' } })
    vim.cmd.profile({ args = { 'file', '*' } })
  end,
  { nargs = 1 }
)

create_user_command(
  'ProfilePause',
  function(params)
    vim.cmd.profile({ args = { 'pause' } })
    vim.cmd.profile({ args = { 'dump' } })
  end,
  { nargs = 0 }
)

create_user_command(
  'Reload',
  function()
    -- Flush all loaded modules.
    -- Reload only modules starting with the first param string.
    ---
    ---@param module_name (string)
    local function reload_modules(module_name)
      require("plenary.reload").reload_module(module_name, true)
    end

    reload_modules("config")
    reload_modules("plugins")
    reload_modules("ds_omega")

    -- Load modules back.
    vim.cmd('source $MYVIMRC')

    load_all(require('constants.env').NVIM_LAYERS, 2)
  end,
  { nargs = 0 }
)
