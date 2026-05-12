---@type LazySpec
return {
    "MeanderingProgrammer/render-markdown.nvim",

    opts = {
        anti_conceal = {
            enabled = true,
        },
        heading = {
            enabled = true,
            position = "overlay",
            border = false,
            border_prefix = false,
            -- Only with this mode heading icons work
            atx = true,
            setext = false,
            sign = true,
            -- Disable highlight.
            backgrounds = {},
            -- foregrounds = {},
            icons = {
                '✪ ',
                '✰ ',
                '✮ ',
                '✫ ',
                '✬ ',
                '✭ ',
            },
        },
        file_types = require("ds_omega.constants.filetypes").markdown_dialects,
        paragraph = {
            indent = 2,
        },
        bullet = {
            enabled = true,
            icons = { '● ', '○ ', '◆ ', '◇ ' },
        },
        -- Already handled by mkdnflow, m_taskwarrior_d or some other plugin.
        checkbox = {
            enabled = false,
        },
        code = {
            enabled = true,
        },
        link = {
            custom = {
                zotero = { pattern = '^zotero://select', icon = 'Ⓩ  ' },
                web = { pattern = '^http', icon = '󰖟 ' },
                apple = { pattern = 'apple%.com', icon = ' ' },
                discord = { pattern = 'discord%.com', icon = '󰙯 ' },
                github = { pattern = 'github%.com', icon = '󰊤 ' },
                gitlab = { pattern = 'gitlab%.com', icon = '󰮠 ' },
                google = { pattern = 'google%.com', icon = '󰊭 ' },
                hackernews = { pattern = 'ycombinator%.com', icon = ' ' },
                linkedin = { pattern = 'linkedin%.com', icon = '󰌻 ' },
                microsoft = { pattern = 'microsoft%.com', icon = ' ' },
                neovim = { pattern = 'neovim%.io', icon = ' ' },
                reddit = { pattern = 'reddit%.com', icon = '󰑍 ' },
                slack = { pattern = 'slack%.com', icon = '󰒱 ' },
                stackoverflow = { pattern = 'stackoverflow%.com', icon = '󰓌 ' },
                steam = { pattern = 'steampowered%.com', icon = ' ' },
                twitter = { pattern = 'twitter%.com', icon = ' ' },
                wikipedia = { pattern = 'wikipedia%.org', icon = '󰖬 ' },
                x = { pattern = 'x%.com', icon = ' ' },
                youtube = { pattern = 'youtube[^.]*%.com', icon = '󰗃 ' },
                youtube_short = { pattern = 'youtu%.be', icon = '󰗃 ' },
            },
        },
    },
    ft = require("ds_omega.constants.filetypes").markdown_dialects,
}
