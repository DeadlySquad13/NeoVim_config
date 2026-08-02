local logging = require('ds_omega.modules.opencode_launcher.logging')
local M = {}

M.logger = get_logger('OpencodeLanuncher__Strategies')
M.strategies = {}

---
---@param container_name (string)
---@param opts? ({ sudo: boolean }|nil)
---@return
M.check_container_exists = function(container_name, opts)
    local check_cmd = string.format('docker ps --filter "name=^%s$" --format "{{.Names}}"', container_name)
    if opts and opts.sudo then
        check_cmd = string.format(
            'SUDO_ASKPASS="%s/sudo-askpass.sh" sudo -A %s',
            require('ds_omega.constants.env').SHARED_SCRIPTS,
            check_cmd
        )
    end

    local handle = io.popen(check_cmd)
    local result = handle:read("*a")
    handle:close()

    local container_exists = result and string.match(result, vim.pesc(container_name))

    return container_exists, result
end

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
    kill_command = function(self, port)
        logging.notify(string.format("Stopping local opencode on port %d", port))
        local serve_command = "opencode serve.*--port " .. port
        return os.execute(string.format("pkill --full '%s' 2>/dev/null", serve_command))
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
        local container_exists, _ = M.check_container_exists(container_name)

        if container_exists then
            logging.notify(string.format("Container %s is already running, skipping start", container_name))
            return true
        end

        vim.notify(string.format("Restarting container %s ...", container_name))
        logging.log(string.format("Stopping previous container: %s", container_name))
        os.execute(string.format("docker stop %s 2>/dev/null || true", container_name))

        logging.log(string.format("Starting container: %s on port %d", container_name, port))
        -- Reference: https://github.com/pilinux/opencode-docker/blob/main/Dockerfile
        -- - 'node' is a user with UID matching to current user of the system.
        -- It can leverage volumes properly. There's also 'opencode' user - but
        -- it's hard to use volumes with it - it's mostly for one-shot work
        -- that doesn't need persistent storage (so we usually use 'node's
        -- files).
        -- - `/app` is for agent work. Everything is writable.
        -- - `/home/node` is for 'node' user dotfiles. Everything is writable for node user.
        --   - we mount our configs to it's home. Because UIDs match
        --   - everything works nicely. The only thing we take care of is
        --   making `.config/opencode` readonly so that agent doesn't change
        --   it's own configuration and permissions.
        -- - `/home/opencode` is for 'opencode' user dotfiles. Everything is writable for opencode user.
        -- FIX: Note that state and history is still shared between agents!
        -- WARN: We use `--user root` because we have rootless docker and all
        -- volumes are mounted with 0:0 permissions. On a system that runs
        -- Docker via root, it may pose security problems.
        local cmd = string.format([[
docker run -d --rm \
--name %s \
-p %d:4096 \
-v ~/.local/state/opencode:/root/.local/state/opencode \
-v ~/.local/share/opencode:/root/.local/share/opencode \
-v ~/.config/opencode:/root/.config/opencode:ro \
-v "%s":/app \
--user root \
ghcr.io/pilinux/opencode:latest opencode serve --port 4096 --hostname '0.0.0.0']],
            container_name,
            port,
            cwd,
            container_name
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

M.DarkGreenTangerineDreamStrategy = M.register_strategy({
    name = "darkGreen-tangerineDream",
    path_map = function(self, host_path)
        -- Currently simply substituting our user to user in docker container
        -- because mostly we try to mirror filesystem structures.
        -- QUESTION: Add map of paths for our persistent volumes?
        return string.gsub(host_path, vim.pesc(require('ds_omega.constants.env').HOME), '/home/tangerineDream')
    end,
    spawn_command = function(self, port, url)
        -- local dir_name = string.lower(vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
        -- local cwd = vim.fn.getcwd()
        local container_name = "AiAssistance__darkGreen-tangerineDream"
        local notifier = M.logger:get_notifier({ title = self.name })

        notifier:info(string.format("Checking if container '%s' already exists", container_name))
        local container_exists, _ = M.check_container_exists(container_name, { sudo = true })

        if not container_exists then
            notifier:warning(string.format("Container '%s' doesn't exist", container_name))
            return false
        end

        notifier:info(string.format("Container %s is running, progressing...", container_name))

        logging.notify(string.format("Starting OpenCode in container: %s on port %d", container_name, port))

        return os.execute(string.format(
            "invoke llm.serve-conv-plat-prov-opencode --system-name='darkGreen-tangerineDream' --port %d >/dev/null &",
            port))
    end,
    kill_command = function(self, port)
        local container_name = "AiAssistance__darkGreen-tangerineDream"

        logging.notify(string.format("Stopping OpenCode server on port %d in container: %s", port, container_name))
        return os.execute(string.format("invoke llm.kill-conv-plat-prov-opencode --port '%d' > /dev/null", port))
    end
})

return M
