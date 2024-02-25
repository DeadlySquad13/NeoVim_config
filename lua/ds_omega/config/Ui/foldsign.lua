return {
    "yaocccc/nvim-foldsign",
    -- FIX: Seems that it doesn't work with ufo because the latter overrides
    -- columns. Or maybe just something is wrong.
    enabled = not require("ds_omega.utils").is_loaded("ufo"),

    event = "CursorHold",
}
