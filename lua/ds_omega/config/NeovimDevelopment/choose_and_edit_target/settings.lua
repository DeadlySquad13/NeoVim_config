return {
    neovim =
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
                ---@type Items
                items = {
                    keymappings = { env.NVIM_LUA, opts = { default_text = 'keymappings' } },
                    -- plugins = { env.NVIM_PLUGINS },
                    utils = { env.NVIM_LUA, opts = { default_text = 'ds_omegautils' } },
                    server_configuaritions = { env.NVIM_LUA_CONFIG, opts = { default_text = 'server_configurations' } },
                    layers_specification = { env.NVIM_LAYERS_SPECIFICATION },
                    -- vimrc = { '$MYVIMRC' },
                    config = { env.NVIM_LUA_CONFIG },
                    modules = { env.NVIM_MODULES },
                    general_settings = { env.NVIM_GENERAL_SETTINGS },
                    layers = { env.NVIM_LAYERS },
                    autocommands = { env.NVIM_AUTOCOMMANDS },
                    constants = { env.NVIM_CONSTANTS },
                    gui = choose_and_edit_gui_settings,
                    after = { env.NVIM_AFTER },
                    commands = { env.NVIM_LUA, opts = { default_text = 'commands' } }
                }
            }
        end,

    unix_dotfiles = function()
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

            host_items[host] = vim.tbl_deep_extend('force', default_host_opts, opts)
        end


        return {
            -- TODO: Add 'create' action that will trigger create file via template for selected item.
            ---@type Items
            items = vim.tbl_extend('error', host_items, {
                root = { unix_dotfiles },
                homes = { unix_dotfiles .. '/homes' },
                lib = { unix_dotfiles .. '/lib' },
                modules = { unix_dotfiles .. '/modules' },
                overlays = { unix_dotfiles .. '/overlays' },
                packages = { unix_dotfiles .. '/packages' },
                -- TODO: Add `make edit-vault $entry` to picker.
                secrets = { unix_dotfiles .. '/secrets' },
                systems = { unix_dotfiles .. '/systems' },
            })
        }
    end
}
