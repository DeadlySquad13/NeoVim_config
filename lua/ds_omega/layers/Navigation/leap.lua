local prequire = require('utils').prequire

local leap_is_available, leap = prequire('leap')

if not leap_is_available then
  return 
end

print('leap mappings')
leap.add_default_mappings()

local config_is_avalable, config = prequire('config.Navigation.leap')

if config_is_avalable then
  if config.settings then
    --   Should be  done in `leap.opt.key = value` fashion. Just assigning
    -- a table doesn't work.
    for key, setting in pairs(config.settings) do
      leap.opts[key] = setting
    end
  end
end

