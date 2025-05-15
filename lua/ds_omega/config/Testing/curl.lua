return {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen" },
    -- Curl plugin defines custom filetype. We want to get it before
    -- highlighting.
    event = { "BufReadPre *.curl" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = true,
}
