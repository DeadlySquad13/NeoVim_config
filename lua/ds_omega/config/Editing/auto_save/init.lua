local M = {}

M.opts = require('ds_omega.config.Editing.auto_save.settings')

M.all_autosave_events = vim.iter(vim.tbl_values(M.opts.trigger_events)):flatten():totable()
M.keymappings = require('ds_omega.config.Editing.auto_save.keymappings')

M.logger = get_logger("AutoSave")
M.notifier = M.logger:get_notifier()

return {
    'okuuva/auto-save.nvim',

    opts = M.opts,

    event = M.all_autosave_events,
    keys = to_lazy_keys(M.keymappings),

    config = function(_, opts)
        local prequire = require('ds_omega.utils').prequire

        local auto_save_is_available, auto_save = prequire('auto-save')

        if not auto_save_is_available or not auto_save then
            return
        end

        auto_save.setup(opts)

        require('ds_omega.ds_omega_utils').apply_plugin_keymappings(M.keymappings)

        local utils = require('ds_omega.utils')
        local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd

        local AutoSave = create_augroup('auto-save', { clear = true })

        local format_buf_name = require('ds_omega.config.utils').format_buf_name;

        create_autocmd({ 'User' }, {
            pattern = 'AutoSaveWritePost',
            group = AutoSave,
            desc = 'Show info message after auto-saving',
            callback = function(opts)
                if opts.data.saved_buffer ~= nil then
                    local buf_name = vim.api.nvim_buf_get_name(opts.data.saved_buffer)
                    local msg = 'Saved ' ..
                        format_buf_name({ buf_name = buf_name }) -- .. ' at ' .. vim.fn.strftime('%H:%M:%S')

                    M.notifier:info({
                        msg = msg,
                        -- No need to log these messages.
                        skip_log = true,
                        -- Nvim-notify settings:
                        render = "compact",
                        stages = "fade",
                        -- - Hide this notification from the history.
                        hide_from_history = true,
                    })
                end
            end,
        })

        create_autocmd({ 'User' }, {
            pattern = 'AutoSaveEnable',
            group = AutoSave,
            desc = 'Show info message on enabling auto-save feature',
            callback = function()
                M.notifier:info('AutoSave enabled')
            end,
        })

        create_autocmd({ 'User' }, {
            pattern = 'AutoSaveDisable',
            group = AutoSave,
            desc = 'Show info message on disabling auto-save feature',
            callback = function()
                M.notifier:info('AutoSave disabled')
            end,
        })
    end,
}
