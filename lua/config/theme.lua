local COLORSCHEME_NAME = 'deadly-gruv'

local function load_coloscheme()
  local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. COLORSCHEME_NAME)

  if not status_ok then
    return notify('colorscheme ' .. COLORSCHEME_NAME .. ' not found!')
  end
end

load_coloscheme()
