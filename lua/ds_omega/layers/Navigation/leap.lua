local prequire = require('ds_omega.utils').prequire

local ds_omega_utils_is_available, ds_omega_utils = prequire('ds_omega.utils')

if not ds_omega_utils_is_available then
  return
end

local leap_is_available, leap = require('ds_omega.utils').prequire_plugin('leap')
if not leap_is_available then
  return
end

local settings, keymappings = ds_omega_utils.get_plugin_config('leap', 'Navigation')

--   Should be  done in `leap.opt.key = value` fashion. Just assigning
-- a table doesn't work.
for key, setting in pairs(settings) do
  leap.opts[key] = setting
end

-- Without first parameter = true it won't override existing keymappings.
leap.add_default_mappings()

if keymappings then
  ds_omega_utils.apply_plugin_keymappings(keymappings)
end
