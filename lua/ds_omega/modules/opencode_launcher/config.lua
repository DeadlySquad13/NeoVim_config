local M = {}

M.CONFIG_FILE = vim.fn.stdpath("data") .. "/opencode_launch_mode"

M.DEFAULT_LAUNCH_MODE = "docker"

return M

