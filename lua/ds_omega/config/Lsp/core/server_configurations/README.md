# Table of Contents

- [Table of Contents](#table-of-contents)
- [Server configuration](#server-configuration)

# Server configuration
Configurations in this module are meant to be **merged** with default server
configuration. 

We've introduced this structure before NeoVim v0.11 and
`vim.lsp.config`. Now it's better to usebuiltin mechanisms as they allow easier
extending of lsps from separated places and plugins. We've left our module because it's
functioning completely fine, follows similar principles when defining configs in a centralized place.

Make configurations in corresponding files like you always do
with `lsp`:
```lua
return {
  -- These functions be applied on top of default on_attach one by one.
  --   Should take client and bufnr as params (both optional).
  on_attach = { custom_on_attaches },
  -- Will override default settings.
  settings = { },
  
  -- Not yet implemented:
  capabilities = capabilities -- Haven't found any need to override them.
}
```
