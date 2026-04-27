return function()
  local config_file = "/tmp/opencode_launch_mode"
  local DEFAULT_LAUNCH_MODE = "docker"

  local M = {}
  M.log = log("Opencode")

  ---@param message (string) Message to display.
  ---@param level? (vim.log.levels)
  M.notify = function(msg, level)
    notify(msg, level or vim.log.levels.DEBUG, { title = "Opencode" })
  end
  ---@param message (string) Message to display.
  ---@param level? (vim.log.levels)
  M.notify_once = function(msg, level)
    notify_once(msg, level or vim.log.levels.DEBUG, { title = "Opencode" })
  end

  M.read_launch_config = function()
    local f = io.open(config_file, "r")
    if not f then
      return DEFAULT_LAUNCH_MODE
    end
    local mode = f:read("*a"):gsub("%s+", ""):gsub("\n", "")
    f:close()
    if mode == "" then
      return DEFAULT_LAUNCH_MODE
    end
    return mode
  end

  local DEFAULT_PATH_MAP = function(self, host_path)
    return host_path
  end
  local DEFAULT_SPAWN_COMMAND = function(self, port, url)
    return true
  end
  local DEFAULT_KILL_COMMAND = function(self, env_name)
    return true
  end

  ---@class OpencodeOpenStrategyConfig
  ---@field name string
  ---@field path_map function
  ---@field spawn_command function
  ---@field kill_command function

  ---@class OpencodeOpenStrategy
  ---@field name string
  ---@field path_map function
  ---@field spawn_command function
  ---@field kill_command function

  ---
  ---@param config (OpencodeOpenStrategyConfig)
  ---@return boolean Has validation passed
  local function validate_config(config)
    if not config then
      M.notify("No strategy config provided", vim.log.levels.ERROR)
      return false
    end

    if type(config) ~= "table" then
      M.notify("Strategy config must be a table", vim.log.levels.ERROR)
      return false
    end

    if config.spawn_command and type(config.spawn_command) ~= "function" then
      M.notify("spawn_command must be a function", vim.log.levels.ERROR)
      config.spawn_command = DEFAULT_SPAWN_COMMAND
    end

    if config.path_map and type(config.path_map) ~= "function" then
      M.notify("path_map must be a function", vim.log.levels.ERROR)
      config.path_map = DEFAULT_PATH_MAP
    end

    if config.kill_command and type(config.kill_command) ~= "function" then
      M.notify("kill_command must be a function", vim.log.levels.ERROR)
      config.kill_command = DEFAULT_KILL_COMMAND
    end

    if config.name then
      M.notify(string.format("Custom strategy using environment: %s", config.name))
    else
      M.notify("Custom strategy without specific environment name")
    end

    return true
  end

  ---
  ---@param config (OpencodeOpenStrategyConfig)
  ---@return OpencodeOpenStrategy
  M.create_custom_strategy = function(config)
    validate_config(config)
    local name = config.name or "custom"
    M.log(string.format("Creating custom strategy: %s", name))

    return setmetatable({
      name = name,
      spawn_command = config.spawn_command or DEFAULT_SPAWN_COMMAND,
      path_map = config.path_map or DEFAULT_PATH_MAP,
      kill_command = config.kill_command or DEFAULT_KILL_COMMAND
    }, {
      __index = function(t, k)
        if k == "path_map" then
          return t.path_map
        elseif k == "spawn_command" then
          M.notify(string.format("Starting OpenCode strategy: %s", name))
          return t.spawn_command
        elseif k == "kill_command" then
          local name = name
          M.notify(string.format("Stopping OpenCode strategy: %s", name))
          return t.kill_command(name)
        end
      end
    })
  end

  M.OsStrategy = M.create_custom_strategy({
    name = "os",
    path_map = DEFAULT_PATH_MAP,
    spawn_command = function(self, port, url)
      M.notify("Starting opencode locally")
      return os.execute(string.format("opencode serve --port %d --hostname '%s' &", port, url))
    end,
    kill_command = function()
      M.notify("Stopping local opencode")
      return os.execute("pkill_command -f 'opencode serve' 2>/dev/null")
    end
  })

  M.DockerStrategy = M.create_custom_strategy({
    name = "docker",
    path_map = function(self, host_path)
      local cwd = vim.fn.getcwd()
      return host_path:gsub(vim.pesc(cwd), '/app')
    end,
    spawn_command = function(self, port, url)
      M.notify("DOCKER")
      local dir_name = string.lower(vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
      local cwd = vim.fn.getcwd()
      local container_name = string.format('opencode-%s', dir_name)

      M.notify(string.format("cwd %s", cwd))

      local check_cmd = string.format('docker ps --filter "name=%s" --format "{{.Names}}"', container_name)
      local handle = io.popen(check_cmd)
      local result = handle:read("*a")
      handle:close()

      M.notify(string.format("docker ps result %s", result))
      if result and result:match(container_name) then
        M.notify(string.format("Container %s is already running, skipping start", container_name))
        return true
      end

      vim.notify(string.format("Restarting container %s ...", container_name))
      M.log(string.format("Stopping previous container: %s", container_name))
      os.execute(string.format("docker stop %s 2>/dev/null || true", container_name))

      M.log(string.format("Starting container: %s on port %d", container_name, port))
      local cmd = string.format([[
docker run -d --rm \
--name %s \
-p %d:4096 \
-v ~/.local/state/opencode:/home/node/.local/state/opencode \
-v ~/.local/share/opencode:/home/node/.local/share/opencode \
-v ~/.config/opencode:/home/node/.config/opencode \
-v "%s":/app:rw \
ghcr.io/pilinux/opencode:latest opencode serve --port 4096 --hostname '0.0.0.0']],
        container_name,
        port,
        cwd
      )

      M.notify("Starting opencode")
      M.notify(string.format("Starting OpenCode container: %s on port %d", container_name, port))
      return os.execute(cmd)
    end,
    kill_command = function(self)
      local dir_name = string.lower(vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
      local container_name = string.format('opencode-%s', dir_name)
      M.notify(string.format("Stopping OpenCode container: %s", container_name))
      return os.execute(string.format('docker stop %s 2>/dev/null', container_name))
    end
  })

  ---
  ---@param mode string
  ---@return OpencodeOpenStrategy
  M.create_strategy = function(mode)
    if mode == "os" then
      return M.OsStrategy
    elseif mode == "docker" then
      return M.DockerStrategy
    end

    return M.create_custom_strategy {
      name = DEFAULT_LAUNCH_MODE,
      spawn_command = DEFAULT_SPAWN_COMMAND,
      path_map = DEFAULT_PATH_MAP,
      kill_command = DEFAULT_KILL_COMMAND
    }
  end

  M.get_strategy = function()
    local mode = M.read_launch_config()
    M.notify_once(string.format("Using strategy corresponding to selected mode: %s", mode), vim.log.levels.INFO)

    return M.create_strategy(mode)
  end

  M.get_available_strategies = function()
    local strategies = {
      M.OsStrategy,
      M.DockerStrategy,
    }

    return vim.tbl_map(function (strategy)
      return { name = strategy.name }
    end, strategies)
  end

  return {
    server = {
      url = 'localhost',
      port = 'auto',
      path_map = function(host_path)
        local strategy = M.get_strategy()
        return strategy:path_map(host_path)
      end,
      spawn_command = function(port, url)
        local strategy = M.get_strategy()
        M.notify("port")
        P(port)
        return strategy:spawn_command(port, url)
      end,
      kill_command = function(port, url)
        local strategy = M.get_strategy()
        return strategy:kill_command(port, url)
      end,
      auto_kill = true,
    },
  }
end
