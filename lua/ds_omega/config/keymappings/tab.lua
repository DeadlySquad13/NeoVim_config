local prequire = require('ds_omega.utils').prequire

local hydra_is_available, Hydra = prequire('hydra')

local utils = require("ds_omega.config.keymappings._common.utils")
local keymappings = require("ds_omega.config.keymappings._common.constants").keymappings

---@param command (string)
local function tab(command)
    return utils.cmd('tab' .. command)
end

local Tab = {}

Tab.mappings = {
    [keymappings.next_global] = {
        t = { tab 'next', 'Next Tab' },
    },
    [keymappings.previous_global] = {
        t = { tab 'previous', 'Previous Tab' },
    },
    [keymappings.create] = {
        t = { tab 'new', 'Create new Tab' }
    },
    ['<Leader>7'] = { '1gt', 'Choose tabpage #1' },
    ['<Leader>8'] = { '2gt', 'Choose tabpage #2' },
    ['<Leader>9'] = { '3gt', 'Choose tabpage #3' },
}

if hydra_is_available and Hydra then
    Tab.hydra = Hydra({
        name = 'Tabs',
        config = {
            hint = {
                float_opts = {
                    style = 'rounded',
                },
                offset = -1
            }
        },
        mode = 'n',
        heads = {
            { keymappings.next,     tab 'next' },
            { keymappings.previous, tab 'previous' },
            { 'n',                  tab 'new' },
            { 'l',                  tab 'close' },
        }
    })
end

return Tab
