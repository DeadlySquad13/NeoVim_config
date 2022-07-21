local exists = require('utils').exists
local utils = require('utils')
local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd

if not exists('quick-scope') then
  return
end

-- NOTE: clear option - clears previously created autocommands in augroup.

-- ? Move this file to layers?
local Lightspeed = create_augroup('LightspeedQuickscope', { clear = true })

local function disable_quick_scope()
  if vim.g.qs_enable == 1 then
    return vim.cmd('QuickScopeToggle')
  end
end

create_autocmd({ 'User' }, {
  group = Lightspeed,
  pattern = 'LightspeedSxEnter',
  desc = 'Disable quickscope during lightspeed jumps',
  callback = disable_quick_scope
})


local function enable_quick_scope()
  if vim.g.qs_enable == 0 then
    return vim.cmd('QuickScopeToggle')
  end
end

create_autocmd({ 'User' }, {
  group = Lightspeed,
  pattern = 'LightspeedSxLeave',
  desc = 'Enable quickscope back after lightspeed jumps',
  callback = enable_quick_scope
})
