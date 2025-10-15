local choose_and_edit_target = require('ds_omega.modules.choose_and_edit_configs.choose_and_edit_target')

local M = {}

M.choose_and_edit_configs = function(opts)
    return function()
        choose_and_edit_target(opts.items)
    end
end

---@alias ChooseAndEditFactoryOpts { items: Targets, name: string, desc: string, }


M.generate_command_name = function(opts)
    return 'ChooseAndEdit' .. opts.name
end

--- Create command to choose and edit custom targets.
---@param opts (ChooseAndEditFactoryOpts) Options to initialize new command.
M.choose_and_edit_configs_factory = function(opts)
    local create_user_command = require('ds_omega.utils.commands').create_user_command

    -- See `:h user-commands` and `:h nvim_create_user_command()`.
    create_user_command(
        M.generate_command_name(opts),
        M.choose_and_edit_configs(opts),
        { nargs = 0, desc = opts.desc }
    )
end

---@alias ChooseAndEditSetupOpts table<ChooseAndEditFactoryOpts|(fun(): ChooseAndEditFactoryOpts)>

--- Initialize choose_and_edit_configs for all entries.
---@param opts (ChooseAndEditSetupOpts)
M.setup = function(opts)
    for _, group_opts in ipairs(opts) do
        if type(group_opts.items) == 'function' then
            group_opts.items = group_opts.items()
        end

        M.choose_and_edit_configs_factory(group_opts)
    end
end

return M
