return { -- preview equations
  'jbyuki/nabla.nvim',
  keys = {
    { '<leader>tn', ':lua require"nabla".toggle_virt()<cr>', desc = 'toggle Nabla math equations' },
  },
}
