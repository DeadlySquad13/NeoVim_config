local prequire = require('utils').prequire;
status_ok, notify = prequire('notify');

if not status_ok then
  return;
end

-- Other plugins can use the notification windows by setting it as your default
--   notify function.
vim.notify = notify;
