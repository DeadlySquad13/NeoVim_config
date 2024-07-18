return {
  -- Doesn't work on Windows and I don't want to run code on Windows anyway.
  enabled = not require("ds_omega.utils.os").is("Windows_NT"),
  "michaelb/sniprun",
  branch = "master",

  build = "sh install.sh",
  -- do 'sh install.sh 1' if you want to force compile locally
  -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

  --[[ config = function()
    require("sniprun").setup({
      -- your options
    })
  end, ]]
}
