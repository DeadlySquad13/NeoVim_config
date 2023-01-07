local prequire = require('utils').prequire

local illuminate_is_available, illuminate = prequire('illuminate')

if not illuminate_is_available then
  return 
end

local config_path = 'config.Lsp.illuminate'
local config_is_available, config = prequire(config_path)
if not config_is_available then
  config = {}
  notify(
    'Config for plugin `illuminate` on path `' .. config_path .. '` does not exist!\nReverting to default configuration.',
    vim.log.levels.WARN,
    {
      title = 'Core',
    }
  )
end

illuminate.configure(config)

