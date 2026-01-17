---@type LazySpec
return {
    "chipsenkbeil/org-roam.nvim",
    ft = { 'org' },
    tag = "0.2.0",
    dependencies = {
        {
            "nvim-orgmode/orgmode",
            tag = "0.7.0",
        },
    },
    config = function()
        require("org-roam").setup({
            directory = '~/.bookmarks/kbn/logseq-',

            templates = {
                d = {
                    description = "default",
                    template = "%?",
                    -- target = "%<%Y%m%d%H%M%S>-%[slug].org",
                    target = "%<%Y.%m.%d>.org",
                },
            },
            extensions = {
                dailies = {
                    directory = "_journals",
                    templates = {
                        d = {
                            description = "default",
                            template = "%<%Y.%m.%d>.org",
                            target = "%<%Y.%m.%d>.org",
                        },
                    },
                },
            },
        })
    end
}
