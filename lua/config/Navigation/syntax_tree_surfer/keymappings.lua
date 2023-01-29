return {
  n = {
    v = {
      -- Normal Mode Swapping.
      U = {
        function()
          vim.opt.opfunc = 'v:lua.STSSwapUpNormal_Dot'
          return 'g@l'
        end,
        'Swap up the master node relative to the cursor with its siblings',
        expr = true,
      },
      D = {
        function()
          vim.opt.opfunc = 'v:lua.STSSwapDownNormal_Dot'
          return 'g@l'
        end,
        'Swap down the master node relative to the cursor with its siblings',
        expr = true,
      },

      -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
      d = {
        function()
          vim.opt.opfunc = 'v:lua.STSSwapCurrentNodeNextNormal_Dot'
          return 'g@l'
        end,
        'Swap current node with next',
        expr = true,
      },
      u = {
        function()
          vim.opt.opfunc = 'v:lua.STSSwapCurrentNodePrevNormal_Dot'
          return 'g@l'
        end,
        'Swap current node with previous',
        expr = true,
      },


      -- Visual Selection from Normal Mode.
      x = { '<Cmd>STSSelectMasterNode<Cr>', 'Select master node' },
      n = { '<Cmd>STSSelectCurrentNode<Cr>', 'Select current node' },
    },
  },

  x = {
    -- Select Nodes in Visual Mode
    J = { '<Cmd>STSSelectNextSiblingNode<Cr>', 'Select next sibling node' },
    K = { '<Cmd>STSSelectPrevSiblingNode<Cr>', 'Select previous sibling node' },
    H = { '<Cmd>STSSelectParentNode<Cr>', 'Select parent node' },
    L = { '<Cmd>STSSelectChildNode<Cr>', 'select child node' },

    -- Swapping Nodes in Visual Mode
    ['<A-j>'] = { '<Cmd>STSSwapNextVisual<Cr>', 'Swap with next node' },
    ['<A-k>'] = { '<Cmd>STSSwapPrevVisual<Cr>', 'Swap with previous node' },
  }
}
