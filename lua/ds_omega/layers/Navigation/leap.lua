local prequire = require('utils').prequire

local leap_is_available, leap = prequire('leap')

if not leap_is_available then
  return 
end

print('leap mappings')
leap.add_default_mappings()

local settings_are_avalable, settings = prequire('config.Navigation.leap')

if settings_are_avalable then
  for key, setting in pairs(settings) do
    leap.opts[key] = setting
  end
end
