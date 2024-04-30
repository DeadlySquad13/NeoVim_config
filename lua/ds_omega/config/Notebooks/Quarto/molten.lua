return {
  'benlubas/molten-nvim',
  enabled = false,
  build = ':UpdateRemotePlugins',
  init = function()
    vim.g.molten_image_provider = 'image.nvim'
    vim.g.molten_output_win_max_height = 20
    vim.g.molten_auto_open_output = false
  end,
  keys = {
    { '<leader>mi', ':MoltenInit<cr>',           desc = '[m]olten [i]nit' },
    {
      '<leader>mv',
      ':<C-u>MoltenEvaluateVisual<cr>',
      mode = 'v',
      desc = 'molten eval visual',
    },
    { '<leader>mr', ':MoltenReevaluateCell<cr>', desc = 'molten re-eval cell' },
  },
}
