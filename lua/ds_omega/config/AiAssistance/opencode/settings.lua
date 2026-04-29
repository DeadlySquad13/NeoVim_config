return function()
    local opencode_launcher = require('ds_omega.modules.opencode_launcher.strategies')
    P(opencode_launcher)

    return {
        server = {
            url = 'localhost',
            port = 'auto',
            path_map = function(host_path)
                local strategy = opencode_launcher.get_strategy()
                return strategy:path_map(host_path)
            end,
            spawn_command = function(port, url)
                local strategy = opencode_launcher.get_strategy()
                return strategy:spawn_command(port, url)
            end,
            kill_command = function(port, url)
                local strategy = opencode_launcher.get_strategy()
                return strategy:kill_command(port, url)
            end,
            auto_kill = true,
        },
    }
end
