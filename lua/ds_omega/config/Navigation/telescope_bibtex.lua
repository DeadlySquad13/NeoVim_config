return {
    "nvim-telescope/telescope-bibtex.nvim",

    dependencies = {
        'nvim-telescope/telescope.nvim',
    },

    opts = {
        depth = 1,
        -- custom_formats = {
        --     {
        --         id = "zettel", cite_marker = "#%s"
        --     }
        -- },
        -- format = 'zettel',
        -- global_files = vim.tbl_map(function(collection_file_name)
        --     return require('ds_omega.constants.env').REFERENCES .. "/" .. collection_file_name
        -- end, {
        --     "Zotero.bib",
        --     "2024.bib",
        -- }),
        global_files = {
            -- require('ds_omega.constants.env').REFERENCES .. "/Personal.bib"
            require('ds_omega.constants.env').REFERENCES .. "/Zotero.bib"
        },
        citation_max_auth = 2,
        context = false,
        context_fallback = true,
        wrap = false,
    },

    config = function(_, opts)
        local prequire = require("ds_omega.utils").prequire

        local telescope_is_available, telescope = prequire("telescope")

        if not telescope_is_available then
            return
        end

        telescope.load_extension("bibtex")
    end,
}
