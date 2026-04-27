return function()
    local M = require('ds_omega.modules.opencode_launch_config')

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