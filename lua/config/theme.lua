local COLORSCHEME_NAME = 'deadly-gruv'
--require('colorbuddy').colorscheme(COLORSCHEME_NAME)

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. COLORSCHEME_NAME);

if not status_ok then
  vim.notify('colorscheme ' .. COLORSCHEME_NAME .. ' not found!');
  return
end

