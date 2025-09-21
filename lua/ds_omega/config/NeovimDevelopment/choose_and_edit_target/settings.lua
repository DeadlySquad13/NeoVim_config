---@module 'ds_omega.modules.choose_and_edit_configs'
---@type ChooseAndEditSetupOpts
local target_groups = {
    {
        name = 'NeoVimConfigs',
        desc = 'Choose and Edit NeoVim configs',
        items =
            function()
                local env = require('ds_omega.constants.env')

                local gui_settings_paths = {
                    general = env.GUI_SETTINGS,
                    goneovim = env.GONEOVIM_SETTINGS,
                    -- fvim = env.GONEOVIM_SETTINGS,
                }

                local gui_settings_targets = {}

                for gui_settings_target, _ in pairs(gui_settings_paths) do
                    table.insert(gui_settings_targets, gui_settings_target)
                end

                -- TODO: Generalize choose_and_edit_targets and use it instead of this
                -- function.
                local choose_and_edit_gui_settings = function()
                    vim.ui.select(gui_settings_targets, {
                        prompt = 'Choose gui settings to edit',
                        telescope = require('telescope.themes').get_dropdown(),
                    }, function(selected)
                        if not selected then
                            return
                        end
                        require('ds_omega.utils.file').edit_file(gui_settings_paths[selected])
                    end)
                end

                return {
                    -- TODO: Add 'create' action that will trigger create file via template for selected item.
                    { name = 'config',                 env.NVIM_LUA_CONFIG },
                    { name = 'keymappings',            env.NVIM_LUA,                 opts = { default_text = 'keymappings' } },
                    -- { name = 'plugins', env.NVIM_PLUGINS },
                    { name = 'utils',                  env.NVIM_LUA,                 opts = { default_text = 'ds_omegautils' } },
                    { name = 'layers_specification',   env.NVIM_LAYERS_SPECIFICATION },
                    -- { name = 'vimrc', '$MYVIMRC' },
                    { name = 'commands',               env.NVIM_LUA,                 opts = { default_text = 'commands' } },
                    { name = 'modules',                env.NVIM_MODULES },
                    { name = 'general_settings',       env.NVIM_GENERAL_SETTINGS },
                    { name = 'layers',                 env.NVIM_LAYERS },
                    { name = 'autocommands',           env.NVIM_AUTOCOMMANDS },
                    { name = 'constants',              env.NVIM_CONSTANTS },
                    { name = 'server_configuaritions', env.NVIM_LUA_CONFIG,          opts = { default_text = 'server_configurations' } },
                    { name = 'after',                  env.NVIM_AFTER },
                    { name = 'gui',                    choose_and_edit_gui_settings },
                }
            end,
    },
    {
        name = 'UnixDotfiles',
        desc = 'Choose and Edit Unix Dotfiles',
        items = function()
            local env = require('ds_omega.constants.env')

            local unix_dotfiles = env.BOOKMARKS .. '/Unix_dotfiles'

            --- Hosts with their
            ---@type table<string, table>
            local hosts = {
                ["@creamsoda"] = {},
                ["@salt"] = {},
                ["@pepper"] = {},
            }

            ---
            ---@param host string
            local function get_find_hosts_target(host)
                return {
                    unix_dotfiles,
                    opts = {
                        default_text = host,
                        -- Match full word.
                        -- FIX: It doesn't work on salt, for example...
                        word_match = '-w',
                    },
                }
            end

            local host_items = {}
            for host, opts in pairs(hosts) do
                local default_host_opts = get_find_hosts_target(host)

                table.insert(
                    host_items,
                    vim.tbl_deep_extend('error',
                        { name = host, },
                        vim.tbl_deep_extend('force', default_host_opts, opts)
                    )
                )
            end

            -- TODO: Add 'create' action that will trigger create file via template for selected item.
            ---@type Targets
            return vim.list_extend(
                host_items,
                {
                    { name = 'root',     unix_dotfiles },
                    { name = 'homes',    unix_dotfiles .. '/homes' },
                    { name = 'lib',      unix_dotfiles .. '/lib' },
                    { name = 'modules',  unix_dotfiles .. '/modules' },
                    { name = 'overlays', unix_dotfiles .. '/overlays' },
                    { name = 'packages', unix_dotfiles .. '/packages' },
                    -- TODO: Add `make edit-vault $entry` to picker.
                    { name = 'secrets',  unix_dotfiles .. '/secrets' },
                    { name = 'systems',  unix_dotfiles .. '/systems' },
                })
        end,
    },
    {
        name = 'Scripts',
        desc = 'Choose and Edit Scripts',
        items = function()
            local env = require('ds_omega.constants.env')

            local scripts_root_path = env.BOOKMARKS .. '/Scripts'

            -- TODO: Add 'create' action that will trigger create file via template for selected item.
            ---@type Targets
            return {
                { name = 'root',        scripts_root_path },
                { name = 'keymappings', scripts_root_path .. '/Keymappings__' },
            }
        end,
    },
    {
        name = "BookmarkedLocations",
        desc = 'Choose and Edit Bookmarked Locations',
        items = function()
            local env = require('ds_omega.constants.env')

            local bookmarked_locations_root_path = env.BOOKMARKS

            -- TODO: Add 'create' action that will throw us into Ansible / UnixDotfiles.
            return {
                -- TODO: Filter bookmarks that are useless when inside NeoVim
                -- such as Music playlists, videos…
                {
                    name = 'root',
                    bookmarked_locations_root_path,
                    search_tabs_opts = {
                        tab_name = 'File browser',
                        -- tele_opts =
                    },
                },
            }
        end,
    },
}

---@type ChooseAndEditSetupOpts
return vim.list_extend(target_groups, {
    {
        name = 'All',
        desc = 'Choose and Edit Target Groups (all)',
        items = function()
            -- TODO: Generalize choose_and_edit_targets and use it instead of this
            -- function.
            local choose_and_edit_all = function()
                vim.ui.select(vim.tbl_keys(target_groups), {
                    prompt = 'Choose group of targets',
                    telescope = require('telescope.themes').get_dropdown(),
                    format_item = function(item)
                        return target_groups[item].name
                    end,
                }, function(selected)
                    if not selected then
                        return
                    end

                    local choose_and_edit_configs_is_available = prequire('ds_omega.modules.choose_and_edit_configs')

                    if not choose_and_edit_configs_is_available then
                        return
                    end
                    local choose_and_edit_configs = require('ds_omega.modules.choose_and_edit_configs')

                    vim.cmd(choose_and_edit_configs.generate_command_name(target_groups[selected]))
                end)
            end

            return {
                { name = 'all', choose_and_edit_all },
            }
        end,
    }
})
