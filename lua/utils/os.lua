local os = {}

---@see [Uname_wikiArticle](https://en.wikipedia.org/wiki/Uname#:~:text=uname%20(short%20for%20unix%20name,AT%26T%20Bell%20Laboratories%2C%20David%20MacKenzie.)
--for a list of possible names.
---@alias SystemName - System name (that I use neovim in).
---| '"Darwin"' # MacOs.
---| '"Linux"'
---| '"Windows_NT"' # Windows.

--- Outputs current system name.
---@return (SystemName) system_name System name.
function os.system_name()
  return vim.loop.os_uname().sysname
end

--- Checks if the current system has the same name as provided `sysname`.
---@param system_name (SystemName)
---@return (boolean)
function os.is(system_name)
  return os.system_name() == system_name
end

return os
