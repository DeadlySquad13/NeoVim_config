local prequire_plugin = require('ds_omega.utils').prequire_plugin

local notify_is_available, notify = prequire_plugin('notify')
if not notify_is_available then
  return
end

-- Other plugins can use the notification windows by setting it as your default
--   notify function.
vim.notify = notify;
