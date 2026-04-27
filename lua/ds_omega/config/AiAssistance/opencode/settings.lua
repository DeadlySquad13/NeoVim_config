return {
    -- server = {
    --     url = 'localhost',
    --     port = '4096', -- Random port for project isolation.
    -- },
    -- ui = {
    --     enable_treesitter_markdown = false,
    -- },
}
-- return {
--     server = {
--         url = 'localhost',
--         port = 'auto', -- Random port for project isolation.
--         -- Path mapping: translate host paths to container paths.
--         path_map = function(host_path)
--             local cwd = vim.fn.getcwd()
--             -- Replace host project directory with container mount point.
--             return host_path:gsub(vim.pesc(cwd), '/app')
--         end,
--         -- Spawn command: start Docker container with opencode server
--         spawn_command = function(port, url)
--             local dir_name = string.lower(vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
--             local cwd = vim.fn.getcwd()
--             local container_name = string.format('opencode-%s', dir_name)

--             -- Check if container is already running
--             local check_cmd = string.format('docker ps --filter "name=%s" --format "{{.Names}}"', container_name)
--             print(check_cmd)
--             local handle = io.popen(check_cmd)
--             local result = handle:read("*a")
--             handle:close()

--             if result and result:match(container_name) then
--                 notify(string.format("[opencode.nvim] Container %s is already running, skipping start", container_name))
--                 return true
--             end

--             -- First, try to stop any existing container with the same name
--             os.execute(string.format('docker stop %s 2>/dev/null || true', container_name))

-- -- ghcr.io/anomalyco/opencode:latest serve --port 4096 --hostname '0.0.0.0'
--             local cmd = string.format([[
-- docker run -d --rm \
-- --name %s \
-- -p %d:4096 \
-- -v ~/.local/state/opencode:/home/node/.local/state/opencode \
-- -v ~/.local/share/opencode:/home/node/.local/share/opencode \
-- -v ~/.config/opencode:/home/node/.config/opencode \
-- -v "%s":/app:rw \
-- ghcr.io/pilinux/opencode:latest opencode serve --port 4096 --hostname '0.0.0.0']],
--                 container_name,
--                 port,
--                 cwd
--             )

--             notify(string.format("[opencode.nvim] Starting OpenCode container: %s on port %d", container_name, port))
--             return os.execute(cmd)
--         end,
--         -- Kill command: stop Docker container when auto_kill is triggered
--         kill_command = function(port, url)
--             local dir_name = string.lower(vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
--             local container_name = string.format('opencode-%s', dir_name)

--             notify(string.format("[opencode.nvim] Stopping OpenCode container: %s", container_name))
--             return os.execute(string.format('docker stop %s 2>/dev/null', container_name))
--         end,
--         auto_kill = true, -- Enable automatic cleanup when last nvim exits
--     },
-- }
