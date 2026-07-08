local logging = require('ds_omega.modules.opencode_launcher.logging')

local M = {}

M.strategies = {}

---
---@param config (OpencodeOpenStrategyConfig)
---@return (OpencodeOpenStrategy) strategy
M.register_strategy = function(config)
    local strategy = require('ds_omega.modules.opencode_launcher.strategies.base').create_custom_strategy(config)

    table.insert(M.strategies, strategy)

    return strategy
end

M.OsStrategy = M.register_strategy({
    name = "os",
    path_map = require('ds_omega.modules.opencode_launcher.strategies.base').DEFAULT_PATH_MAP,
    spawn_command = function(self, port, url)
        logging.notify("Starting opencode locally")
        return os.execute(string.format("opencode serve --port %d --hostname '%s' &", port, url))
    end,
    kill_command = function()
        logging.notify("Stopping local opencode")
        return os.execute("pkill_command -f 'opencode serve' 2>/dev/null")
    end
})

M.DockerStrategy = M.register_strategy({
    name = "docker",
    path_map = function(self, host_path)
        local cwd = vim.fn.getcwd()
        return string.gsub(host_path, vim.pesc(cwd), '/app')
    end,
    spawn_command = function(self, port, url)
        local dir_name = string.lower(vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
        local cwd = vim.fn.getcwd()
        local container_name = string.format('opencode-%s', dir_name)

        logging.log(string.format("Checking if container '%s' already exists", container_name))
        local check_cmd = string.format('docker ps --filter "name=%s" --format "{{.Names}}"', container_name)
        local handle = io.popen(check_cmd)
        local result = handle:read("*a")
        handle:close()

        if result and result:match(container_name) then
            logging.notify(string.format("Container %s is already running, skipping start", container_name))
            return true
        end

        vim.notify(string.format("Restarting container %s ...", container_name))
        logging.log(string.format("Stopping previous container: %s", container_name))
        os.execute(string.format("docker stop %s 2>/dev/null || true", container_name))

        logging.log(string.format("Starting container: %s on port %d", container_name, port))
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

        logging.notify("Starting opencode")
        logging.notify(string.format("Starting OpenCode container: %s on port %d", container_name, port))

        return os.execute(cmd)
    end,
    kill_command = function(self)
        local dir_name = string.lower(vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
        local container_name = string.format('opencode-%s', dir_name)
        logging.notify(string.format("Stopping OpenCode container: %s", container_name))
        return os.execute(string.format('docker stop %s 2>/dev/null', container_name))
    end
})

return M
