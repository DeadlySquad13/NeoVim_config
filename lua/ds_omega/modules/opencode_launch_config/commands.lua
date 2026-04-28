local M = {}

M.create_user_command = function()
    local create_user_command = require('ds_omega.utils.commands').create_user_command

    local strategies = require('ds_omega.modules.opencode_launch_config.strategies.base').get_available_strategies()

    -- Graph structure: each node contains its children
    -- vim-lua completion calls this function during typing to get suggestions
    local _COMPLETION_GRAPH = {
        ['open'] = {
            input = strategies,
            output = {},
        },
        ['open_input'] = strategies,
        ['open_input_new_session'] = strategies,
        ['open_output'] = {},
    }

    --- Get compeltion variants for current state. In final nodes we have a list
    -- of results, for transitionary nodes it will be a table with
    -- { key = next_node_completions }
    ---@param graph_node (table<string>|table<string, table>)
    ---@return table<string> variants
    local function get_completion_variants(graph_node)
        return vim.islist(graph_node) and graph_node or vim.tbl_keys(graph_node)
    end

    --- 
    ---@param current_input (string)
    ---@return fun(completion_results: table<string>): table<string> filter_function Filteres results matched for current input out of completion variants
    --TODO: Ideally should be fuzzy by trigrams.
    local function filter_completions(current_input)
        --- 
        ---@param completion_variants (table<string>)
        ---@return table<string> filtered results matched for current input
        return function(completion_variants)
            return vim.tbl_filter(
                function(res) return string.find(res, current_input) end,
                completion_variants)
        end
    end

    --- Get possible autocompletion variants from a list of command chains.
    ---@param args (table<string>)
    ---@return table<string>|table<string,table>
    -- REFACTOR: Make generic for any completion graph and any #arg. Currently
    -- we have to process each case of arg count manually in this function. Or
    -- we could potentially do vice-versa: just flatten a _COMPLETION_GRAPH and
    -- check strings.
    local function get_variants(args)
        -- Number of args already completed. arg_lead is the arg we're
        -- currently trying to complete.
        local full_arg_count = #args - 1

        if full_arg_count == 1 then
            -- No arguments yet, show first-level commands
            return _COMPLETION_GRAPH
        end

        -- Get the current command from first token
        local current_cmd = args[2]
        if full_arg_count == 2 and current_cmd and _COMPLETION_GRAPH[current_cmd] then
            return _COMPLETION_GRAPH[current_cmd]
        end

        local current_children = _COMPLETION_GRAPH[current_cmd]

        if full_arg_count >= 3 then
            local second_cmd = args[3]

            -- Check if second command matches a known child
            if current_children[second_cmd] then
                -- We have a valid second level, return its children
                return current_children[second_cmd]
            end

            -- Second command doesn't match any child, return empty
            return {}
        end

        -- Only one non-empty arg: return all children at this level
        return current_children
    end


    local function complete(arg_lead, cmdline, cursor_pos)
        local args = vim.split(cmdline, '%s+')

        return require('ds_omega.utils').compose(
            filter_completions(arg_lead),
            get_completion_variants,
            get_variants
        )(args)
    end

    create_user_command('OpencodeDsOmega', function(args)
        local function default_fallback()
            vim.cmd.Opencode(unpack(args.fargs))
        end

        if vim.tbl_isempty(args.fargs) then
            return default_fallback()
        end

        local first_arg = args.fargs[1]

        if first_arg == "open_input" or first_arg == "open_input_new_session" then
            local mode = args.fargs[2]
            if mode then
                require('ds_omega.modules.opencode_launch_config.persistence').write_launch_config(mode)
            end

            return default_fallback()
        end

        if first_arg ~= "open" then
            return default_fallback()
        end

        local mode = args.fargs[3]
        if mode then
            M.write_launch_config(mode)
        end
        return default_fallback()
    end, {
        nargs = '*',
        desc = 'Opencode wrapper with launch mode support',
        complete = complete,
    })
end

return M
