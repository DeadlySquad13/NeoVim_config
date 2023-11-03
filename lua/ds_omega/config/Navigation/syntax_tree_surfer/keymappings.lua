-- Syntax Tree Surfer V2 Mappings
-- Targeted Jump with virtual_text
local prequire = require('ds_omega.utils').prequire

local syntax_tree_surfer_is_available, sts = prequire('syntax-tree-surfer')

if not syntax_tree_surfer_is_available or not sts then
  return
end

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

      -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable.
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

    -- Targeted jump.
    ['<leader>'..'i'] = {
      name = 'Jump',

      -- Good roll from i to h
      h = {
        function()
          sts.targeted_jump({
            'function',
            'if_statement',
            'else_clause',
            'else_statement',
            'elseif_statement',
            'for_statement',
            'while_statement',
            'switch_statement',
          })
        end,
        'To one of nodes',
      },

      v = {
        function()
          sts.targeted_jump({ 'variable_declaration' })
        end,
        'To one of variable declarations',
      },

      -- Similar to vim's ]m jumps and it resolves conflicts with for
      --   statements.
      m = {
        function()
          sts.targeted_jump({ 'function', 'arrow_function', 'function_definition' })
        end,
        'To one of functions',
      },

      ['d'] = {
        function()
          sts.targeted_jump({ 'if_statement' })
        end,
        'To one of if statements',
      },

      f = {
        function()
          sts.targeted_jump({ 'for_statement' })
        end,
        'To one of for statements',
      },
    }
  },

  x = {
    -- Select Nodes in Visual Mode.
    ['<C-j>'] = { '<Cmd>STSSelectNextSiblingNode<Cr>', 'Select next sibling node' },
    ['<C-k>'] = { '<Cmd>STSSelectPrevSiblingNode<Cr>', 'Select previous sibling node' },
    ['<C-h>'] = { '<Cmd>STSSelectParentNode<Cr>', 'Select parent node' },
    ['<C-l>'] = { '<Cmd>STSSelectChildNode<Cr>', 'select child node' },

    -- Swapping Nodes in Visual Mode.
    ['<A-j>'] = { '<Cmd>STSSwapNextVisual<Cr>', 'Swap with next node' },
    ['<A-k>'] = { '<Cmd>STSSwapPrevVisual<Cr>', 'Swap with previous node' },
  }
}
