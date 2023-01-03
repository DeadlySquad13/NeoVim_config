local simple_plugin_setup = require('ds_omega.utils').simple_plugin_setup

local conceal_is_available, conceal = simple_plugin_setup('conceal', 'conceal')

if not conceal_is_available then
  return
end

---  Generate the scm queries.
-- Only need to be run when the Configuration changes.
--conceal.generate_conceals()

-- Bind a <leader>tc to toggle the concealing level
vim.keymap.set("n", "<leader>tc", function()
  conceal.toggle_conceal()
end, { silent = true })
