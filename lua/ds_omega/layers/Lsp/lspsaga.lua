local prequire = require('utils').prequire

local lspsaga_is_available, lspsaga = prequire('lspsaga')

if not lspsaga_is_available then
  return 
end

local config_path = 'config.Lsp.lspsaga'
local config_is_available, config = prequire(config_path)
if not config_is_available then
  config = {}
  notify(
    'Config for plugin `lspsaga` on path `' .. config_path .. '` does not exist!\nReverting to default configuration.',
    vim.log.levels.WARN,
    {
      title = 'Core',
    }
  )
end

-- use custom config
lspsaga.init_lsp_saga(config)

