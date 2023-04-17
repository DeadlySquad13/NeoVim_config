local prequire_plugin = require('ds_omega.utils').prequire_plugin

local notify_is_available, notify = prequire_plugin('notify')
if not notify_is_available then
  return
end

-- Other plugins can use the notification windows by setting it as your default
--   notify function.
vim.notify = notify;

if require('ds_omega.utils').exists('telescope.nvim') then
  local telescope_is_available, telescope = prequire("telescope")
  telescope.load_extension("notify")
end
