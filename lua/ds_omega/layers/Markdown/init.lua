---@class Module
local Markdown = {}

Markdown.plugins = {
    ['mkdx'] = {
        'SidOfc/mkdx',
        ft = { 'markdown' },
    },
    ['markdown_preview'] = {
        'iamcco/markdown-preview.nvim',
        -- run = 'cd app && yarn install',
        run = function()
          vim.fn['mkdp#util#install']()
        end,
        cmd = 'MarkdownPreview'
    }
}

-- Markdown.configs = {
--     ['colorizer'] = function()
--       require('ds_omega.layers.Markdown.colorizer')
--     end,
-- }

return Markdown
