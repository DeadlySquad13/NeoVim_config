local create_user_command = require('config.commands.utils').create_user_command

-- vim.diagnostic.severity has extra unnecessary keys and we need ALL and NONE key.
local SEVERITY = {
  NONE = 0,
  ERROR = 1,
  WARN = 2,
  INFO = 3,
  HINT = 4,
  ALL = 5
}

create_user_command(
  'SetMinDiagnosticsSeverity',
  function(ctx)
    local severity = SEVERITY[ctx.args]

    require('ds_omega.layers.Lsp.handlers.filter_diagnostics_by_severity.utils').set_minimum_diagnostics_severity(severity)
  end,
  {
    nargs = 1,
    complete = function(_, _, _)
      -- Seems it doesn't like unions.
      ---@diagnostic disable-next-line: param-type-mismatch
      return vim.tbl_keys(SEVERITY)
    end,
  }
)
