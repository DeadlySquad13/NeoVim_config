---@type LazySpec
return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp',      cond = true },
      { 'f3fora/cmp-spell',          cond = true },
      { 'hrsh7th/cmp-path',          cond = true },
      { 'hrsh7th/cmp-buffer',        cond = true },
      { 'hrsh7th/cmp-calc',          cond = true },
      { 'hrsh7th/cmp-cmdline',       cond = true },
      { 'hrsh7th/cmp-omni',          cond = true },
      { 'hrsh7th/cmp-copilot',       cond = true },
      { 'saadparwaiz1/cmp_luasnip',  cond = true },

      { 'onsails/lspkind.nvim',      cond = true },
    },
    cond = true,
  },
  -- Implicit dependencies of nvim-cmp.
  {
    'danymat/neogen',
    cond = true,
  },
  {
    'windwp/nvim-autopairs',
    cond = true,
  },
  {
    'L3MON4D3/LuaSnip',
    cond = true,
  },
  -- vim.tbl_extend(require('ds_omega.config.Editing.surround'), { cond = true })
-- { import = 'ds_omega.config.Editing.surround', cond = true },
{ import = 'Editing' },
-- { import = 'Editing.surround', cond = true },

}
