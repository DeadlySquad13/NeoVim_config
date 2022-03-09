-- Environment variables.
local ENV = (function ()
  local env = {
    HOME = vim.fn.getenv 'HOME',
  }

  -- PATH environment variable defined specifically for vim.
  function env.PATH(self)
    return {
      npm_global_modules = self.HOME .. '/.npm-global/lib/node_modules',
      npm_global_bin = self.HOME .. '/.npm-global/bin',
    }
  end

  return env;
end)()

return ENV;
