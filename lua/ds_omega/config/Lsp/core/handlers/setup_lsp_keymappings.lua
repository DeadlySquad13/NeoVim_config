local which_key_utils = require('ds_omega.config.Ui.which_key.utils')
local keymappings_utils = require('ds_omega.config.keymappings._common.utils')
local cmd, merge = keymappings_utils.cmd, keymappings_utils.merge

local function filterReactDTS(value)
    return string.match(value.filename, 'react/index.d.ts') == nil
end

local fp = require('ds_omega.utils').fp

---@alias OnListFactoryConfig { open_if_multiple_items_received?: boolean, jump_to_qf_nr?: number }

--- Default is { open_if_multiple_items_received = true, jump_to_qf_nr = nil }
---@module 'vim.lsp.buf'
---@type fun(config?: OnListFactoryConfig): fun(t: vim.lsp.LocationOpts.OnList)
local on_list_factory = fp(
    { { "open_if_multiple_items_received", true }, { "jump_to_qf_nr" } },
    function(open_if_multiple_items_received, jump_to_qf_nr)
        local function on_list(options)
            local items = options.items

            -- Implementation from "vim.lsp.buf" module `get_locations`
            -- function.
            if #items == 1 then
                local item = items[1]
                local b = item.bufnr or vim.fn.bufadd(item.filename)
                local bufnr = vim.api.nvim_get_current_buf()

                local win = vim.api.nvim_get_current_win()
                local from = vim.fn.getpos('.')
                from[1] = bufnr
                local tagname = vim.fn.expand('<cword>')

                -- Save position in jumplist
                vim.cmd("normal! m'")
                -- Push a new item into tagstack
                local tagstack = { { tagname = tagname, from = from } }
                vim.fn.settagstack(vim.fn.win_getid(win), { items = tagstack }, 't')

                vim.bo[b].buflisted = true
                local w = options.reuse_win and vim.fn.win_findbuf(b)[1] or win
                vim.api.nvim_win_set_buf(w, b)
                vim.api.nvim_win_set_cursor(w, { item.lnum, item.col - 1 })
                vim._with({ win = w }, function()
                    -- open_if_multiple_items_received folds under the cursor
                    vim.cmd('normal! zv')
                end)
                return
            end

            -- [https://github.com/typescript-language-server/typescript-language-server/issues/216](https://github.com/typescript-language-server/typescript-language-server/issues/216)
            items = vim.tbl_filter(filterReactDTS, items)
            local list_params = {
                title = options.title,
                items = items,
                context = options.context,
            }

            -- TODO: In some cases we would prefer qf items to be stacked on
            -- top of each other instead of creating a new qf. For example,
            -- when investigating declarations, referneces and definition of
            -- a variable:
            -- "To add a new quickfix list at the end of the stack,
            -- set "nr" in {what} to "$"."
            if options.loclist then
                vim.fn.setloclist(0, {}, ' ', list_params)

                if jump_to_qf_nr then
                    vim.cmd('lrewind ' .. jump_to_qf_nr)
                end
                if open_if_multiple_items_received then
                    vim.cmd.lopen()
                end

                return
            end

            vim.fn.setqflist({}, ' ', list_params)

            if jump_to_qf_nr then
                vim.cmd('crewind ' .. jump_to_qf_nr)
            end
            if open_if_multiple_items_received then
                vim.cmd.copen()
            end
        end

        return on_list
    end
)

--- Apply all lsp related keymappings.
---@param bufnr (integer)
---@param additional_keymappings (table | nil) # Keymappings provided by
--additional lsp handlers.
local setup_lsp_keymappings = function(bufnr, additional_keymappings)
    additional_keymappings = additional_keymappings or {}
    local lsp_buf = vim.lsp.buf
    local prequire = require('ds_omega.utils').prequire

    local CONSTANTS = require('ds_omega.config.keymappings._common.constants')
    local K = CONSTANTS.keymappings

    local lsp_diagnostic = vim.diagnostic

    local lspsaga_diagnostic_is_available, lspsaga_diagnostic =
        prequire('lspsaga.diagnostic')

    if lspsaga_diagnostic_is_available then
        lsp_diagnostic = lspsaga_diagnostic
    end

    local keymappings = {}

    -- * General.
    --nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>

    -- * Investigation.
    -- - Implementation.
    --nnoremap <silent> <leader>gii <cmd>lua vim.lsp.buf.implementation()<CR>

    -- - Declaration.
    --nnoremap <silent> <leader>giD <cmd>lua vim.lsp.buf.declaration()<CR>

    -- - Type definition.
    --nnoremap <silent> <leader>git <cmd>lua vim.lsp.buf.type_definition()<CR>

    -- * Searching.
    --nnoremap <silent> <leader>g0 <cmd>lua vim.lsp.buf.document_symbol()<CR>
    --nnoremap <silent> <leader>gW <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

    local glance_is_available = prequire('glance')
    local actions_preview_is_available, actions_preview = prequire('actions-preview')
    local code_action = actions_preview_is_available and actions_preview.code_actions or lsp_buf.code_action

    local investigate_references = function()
        -- TODO: Conisder usage of locationlist.
        lsp_buf.references(nil, {
            on_list = on_list_factory()
        })
    end

    -- Jump to next reference.
    -- QUESTION: Immediately activate QuickfixList hydra? On one hand, we sometimes want to go
    -- through each reference and edit them one by one. On the other hand,
    -- it's easy to jump and refactor items in qf directly. Are we developing
    -- a bad usage pattern by using this function? Or it's just like
    -- multi-cursors: can be easily replaced by other advanced methods but
    -- useful when brain is not working?
    local iterate_references = function()
        -- TODO: Conisder usage of locationlist.
        lsp_buf.references(nil, {
            on_list = on_list_factory({
                -- At least in vtsls first reference is always
                -- a variable itself.
                jump_to_qf_nr = 2,
                open_if_multiple_items_received = false,
            })
        })
    end

    keymappings.n = {
        name = 'LSP',

        -- General.
        ['<Leader>wa'] = { lsp_buf.add_workspace_folder, 'Add workspace folder' },
        ['<Leader>wr'] = {
            lsp_buf.remove_workspace_folder,
            'Remove workspace folder',
        },
        ['<Leader>wl'] = {
            function()
                vim.print(lsp_buf.list_workspace_folders())
            end,
            'List workspace folders',
        },

        -- Investigation.
        ['gd'] = { function()
            lsp_buf.definition({ on_list = on_list_factory() })
        end, 'Jump to definition' },
        ['<c-k>'] = { lsp_buf.signature_help, 'Signature help' },
        ['<Leader>i'] = merge(
            {
                i = { lsp_buf.hover, 'Hover' },
                d = {
                    cmd 'Lspsaga show_line_diagnostics',
                    'Investigate line diagnostics',
                },
                r = {
                    investigate_references,
                    'List References'
                },
            }, not glance_is_available and {} or {
                D = {
                    cmd 'Glance definitions',
                    'Glance at definitions'
                },
                R = {
                    cmd 'Glance references',
                    'Glance at references'
                },
            }
        ),
        [K.leader_left .. 'i'] = {
            r = { iterate_references, 'Iterate references' },
        },
        -- Editing.
        ['<Leader>rs'] = { lsp_buf.rename, 'Rename Symbol' },
        ['<Leader>aa'] = { code_action, 'Code Action' },
        ['<Leader>qd'] = {
            function()
                vim.diagnostic.setqflist({ open = true })
            end,
            'Send diagnostic to quickfix list',
        },
        ['<Leader>fn'] = { lsp_buf.format, 'Format' },

        -- Navigation.
        [K.previous_global .. 'd'] = {
            function()
                lsp_diagnostic:goto_prev()
            end, 'Go to previous diagnostic'
        },
        [K.next_global .. 'd'] = {
            function()
                lsp_diagnostic:goto_next()
            end,
            'Go to next diagnostic'
        },

        [K.previous_global .. 'e'] = {
            function()
                lsp_diagnostic:goto_prev({ severity = vim.diagnostic.severity.ERROR, popup_opts = { border = "single" } })
            end,
            'Go to previous error',
        },
        [K.next_global .. 'e'] = {
            function()
                lsp_diagnostic:goto_next({ severity = vim.diagnostic.severity.ERROR, popup_opts = { border = "single" } })
            end,
            'Go to next error',
        },

        [K.previous_global .. 'w'] = {
            function()
                lsp_diagnostic:goto_prev({ severity = vim.diagnostic.severity.WARN })
            end,
            'Go to previous warning',
        },
        [K.next_global .. 'w'] = {
            function()
                lsp_diagnostic:goto_next({ severity = vim.diagnostic.severity.WARN })
            end,
            'Go to next warning',
        },

        [K.previous_global .. 'i'] = {
            function()
                lsp_diagnostic:goto_prev({ severity = vim.diagnostic.severity.INFO })
            end,
            'Go to previous info diagnostic',
        },
        [K.next_global .. 'i'] = {
            function()
                lsp_diagnostic:goto_next({ severity = vim.diagnostic.severity.INFO })
            end,
            'Go to next info diagnostic',
        },

        [K.previous_global .. 'h'] = {
            function()
                lsp_diagnostic:goto_prev({ severity = vim.diagnostic.severity.HINT })
            end,
            'Go to previous hint',
        },
        [K.next_global .. 'h'] = {
            function()
                lsp_diagnostic:goto_next({ severity = vim.diagnostic.severity.HINT })
            end,
            'Go to next hint',
        },
    }

    keymappings.x = {
        ['<Leader>fn'] = { lsp_buf.format, 'Format' },
    }

    local options = {
        buffer = bufnr,
    }

    -- REFACTOR: We might already have util for this for loop.
    local merged_keymappings = keymappings
    -- TODO: get all modes from `apply_keymappings`.
    for _, mode in ipairs(which_key_utils.MODES) do
        local additional_keymappings_for_mode = vim.tbl_map(
            function(k) return k[mode] end,
            additional_keymappings
        )

        if not vim.tbl_isempty(additional_keymappings_for_mode) then
            merged_keymappings[mode] = vim.tbl_extend('error',
                keymappings[mode] or {},
                unpack(additional_keymappings_for_mode)
            )
        end

        if merged_keymappings[mode] then
            which_key_utils.apply_keymappings(mode, merged_keymappings[mode], options)
        end
    end
end

return setup_lsp_keymappings
