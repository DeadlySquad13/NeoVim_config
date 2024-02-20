return {
    'L3MON4D3/LuaSnip',
    -- Breaks as cmp is loaded earlier. Make as a dep for cmp?
    --event = 'BufReadPre',

    dependencies = {
        'molleweide/LuaSnip-snippets.nvim',
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets"
    },

    opts = function()
        -- map filename (:t) to custom filetypes.
        local file_extends = {
            ['plugins.lua'] = { 'packer' },
        }

        local function extended_filetype_load_function(bufnr)
            return file_extends[vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':t')]
                or {} -- if we haven't found anything, return {}.
        end

        -- local regex_file_extends = {
        --   ['*.sync.py'] = { 'jupyter_ascending' },
        -- }

        local default_filetype_load_function =
            require('luasnip.extras.filetype_functions').from_filetype_load

        -- local function extended_regex_filetype_load_function(bufnr)
        --   local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':t')

        --   for file_pattern in ipairs(regex_file_extends) do
        --     print(file_pattern)
        --   end

        --   --[
        --   --filename
        --   --] or {}; -- if we haven't found anything, return {}.
        -- end

        local list_deep_extend = require('ds_omega.utils').list_deep_extend

        local function resolve_filetypes(bufnr)
            --local str = "Lab3.py"
            --vim.pretty_print(str:match("^.*%.py$"))
            return list_deep_extend(
                {},
                -- file_extends has higher priority than default.
                extended_filetype_load_function(bufnr),
                default_filetype_load_function(bufnr)
            )
        end

        return {
            -- If true, Snippets that were exited can still be jumped back into.
            history = true,
            -- Update more often, :h events for more info.
            update_events = 'TextChanged,TextChangedI',
            -- Autoexpand.
            enable_autosnippets = true,
            -- Use visual selections in snippets.
            store_selection_keys = '<c-i>',

            -- for regular expansion and nvim-cmp.
            ft_func = function()
                return resolve_filetypes(vim.api.nvim_get_current_buf())
            end,
            -- also override load_ft_func so `packer`-snippets are lazy_loaded.
            load_ft_func = resolve_filetypes,
        }
    end,

    config = function(_, opts)
        local prequire = require('ds_omega.utils').prequire

        local luasnip_is_available, luasnip = prequire('luasnip')

        if not luasnip_is_available then
            return
        end

        -- Reference: <https://github.com/L3MON4D3/LuaSnip#config> 'Config section in LuaSnip
        --docs'.
        luasnip.config.set_config(opts)

        -- For luasnip_snippets (unfortunately, not working D: - 0 documentation...)
        -- Be sure to load this first since it overwrites the snippets table.
        --luasnip.snippets = require("luasnip_snippets").load_snippets();

        -- For honza/vim-snippets.
        require('luasnip.loaders.from_snipmate').lazy_load()
        -- For rafamadriz/friendly-snippets.
        require("luasnip.loaders.from_vscode").lazy_load()

        -- One peculiarity of honza/vim-snippets is that the file containing global
        -- snippets is _.snippets, so we need to tell luasnip that the filetype "_"
        -- contains global snippets:
        luasnip.filetype_extend('all', { '_' })

        luasnip.filetype_extend('typescriptreact', { 'javascriptreact', 'typescript', 'javascript' })
        luasnip.filetype_extend('javascriptreact', { 'javascript' })
        luasnip.filetype_extend('typescript', { 'javascript' })

        -- Searches from rtp
        -- Reference <https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#loaders>
        -- 'Loaders section in LuaSnip docs'
        require('luasnip.loaders.from_lua').lazy_load()
    end,
}
