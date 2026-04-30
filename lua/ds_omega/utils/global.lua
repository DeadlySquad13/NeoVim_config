--------------------------------------------------------------------
-- The most often used utility functions. Reside in global scope. --
--------------------------------------------------------------------

_G.P = require('ds_omega.utils.logging').P

_G.notify = require('ds_omega.utils.logging').notify

_G.notify_once = require('ds_omega.utils.logging').notify_once

_G.notify_throttled = require('ds_omega.utils.logging').P

---@param module_name (string)
local function get_module_loading_error_handler(module_name)
  local function module_loading_error_handler(error)
    require('ds_omega.utils.logging').notify(
      'Error in loading module ' .. module_name .. '! ' .. error,
      vim.log.levels.ERROR
    )
  end

  return module_loading_error_handler
end

--- Protected require of the module.
---@generic Module
---@param module_name (string)
---@return (boolean), (Module|nil)
local function prequire(module_name)
  local module_loading_error_handler = get_module_loading_error_handler(module_name)

  local status_ok, module = xpcall(
    require,
    module_loading_error_handler,
    module_name
  )

  if not status_ok then
    return status_ok, nil
  end

  return status_ok, module
end

--- Test for protected require of the module.
---@generic Module
---@param module_name (string)
---@return (boolean) status_ok is successful
local function test_prequire(module_name)
  local module_loading_error_handler = get_module_loading_error_handler(module_name)

  local status_ok, _ = xpcall(
    require,
    module_loading_error_handler,
    module_name
  )

  return status_ok
end

_G.prequire = prequire
_G.test_prequire = test_prequire


_G.log = require('ds_omega.utils.logging').log
_G.get_logger = require('ds_omega.utils.logging').get_logger

-- REFACTOR: Not sure we should do these assigns here. Maybe we should move global out of
-- ds_omega.utils to unravel cyclic connection between ds_omega.utils and ds_omega.ds_omega_utils.
_G.to_lazy_keys = require('ds_omega.ds_omega_utils.to_lazy_keys')
_G.prequire_plugin = require('ds_omega.ds_omega_utils.prequire_plugin')
