-- May be obsolete once [workspace diagnostics](https://github.com/neovim/neovim/pull/34262)
-- are adapted into NeoVim. But even after that some server may still not
-- implement workspace diagnostics request.
-- See https://github.com/artemave/workspace-diagnostics.nvim/issues/20
local function populate_workspace_diagnostics(client, bufnr)
    local workspace_diagnostics_is_available = prequire('workspace-diagnostics')

    if not workspace_diagnostics_is_available then
      return
    end

    local workspace_diagnostics = require('workspace-diagnostics')

    workspace_diagnostics.populate_workspace_diagnostics(client, bufnr)
end

return populate_workspace_diagnostics
