return {
  'kiyoon/jupynium.nvim',

  event = require("ds_omega.constants.events").jupyter_notebooks,

  -- Use pipx instead. Or even better always install jupynium in venv.
  -- build = 'pip3 install --user .',
}
