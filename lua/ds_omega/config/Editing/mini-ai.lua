---@type LazySpec
return {
  'echasnovski/mini.ai',
  dependencies = 'nvim-treesitter/nvim-treesitter-textobjects', -- For queries.
  version = false,
  opts = function()
    local CONSTANTS = require('ds_omega.config.keymappings._common.constants')
    local K = CONSTANTS.keymappings

    local spec = require('mini.ai').gen_spec
    local spec_treesitter = spec.treesitter

    return {
      -- Table with textobject id as fields, textobject specification as values.
      -- Also use this to disable builtin textobjects. See |MiniAi.config|.
      custom_textobjects = {
        m = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
        M = spec_treesitter({ a = '@class.outer', i = '@class.inner' }),

        c = spec.function_call(),

        o = spec_treesitter({ a = '@loop.outer', i = '@loop.inner' }),

        ['/'] = spec_treesitter({ a = '@comment.outer', i = '@comment.inner' }),

        p = spec_treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
        P = spec_treesitter({ a = '@type.outer', i = '@type.inner' }),

        f = spec_treesitter({
          -- - Custom for ecma (typescript and friends).
          a = '@expression_statement.outer',
          -- - Inner version is similar to @assignment.lhs so I decided to just
          -- combine expression and assignment keymappings into one group.
          i = '@assignment.outer',
        }),

        -- Didn't like it, too random in my opinion and in most cases too wide
        -- (in typescript at least). It's also mostly covered by class and
        -- method textobjects.
        -- b = spec_treesitter({ a = '@block.outer', i = '@block.inner' }),
        b = spec.pair('<', '>'),

        d = spec_treesitter({ a = '@conditional.outer', i = '@conditional.inner' }),

        k = spec_treesitter({
          -- - Custom for ecma (typescript and friends).
          -- Triggers bigger area but looks not only for assignments but also
          -- for this.something = new Cool()
          --     ^ lhs            ^ rhs
          a = '@expression_statement.lhs',
          i = '@assignment.lhs',
        }),
        v = spec_treesitter({
          -- - Custom for ecma (typescript and friends).
          a = '@expression_statement.rhs',
          i = '@assignment.rhs',
        }),

        ['<'] = spec_treesitter({
          a = '@property.lhs',
          -- TODO: Add something useful here.
          i = '@property.lhs',
        }),
        ['>'] = spec_treesitter({
          a = '@property.rhs',
          -- TODO: Add something useful here.
          i = '@property.rhs',
        }),
        [':'] = spec_treesitter({
          a = {
            -- - Custom for ecma (typescript and friends).
            '@property.outer',
            '@attribute.outer',
          },
          i = {
            -- - Custom for ecma (typescript and friends).
            '@property.inner',
            '@attribute.inner',
          },
        })
      },

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Main textobject prefixes
        around = K.around,
        inside = K.inside,

        -- Next/last variants
        around_next = K.around .. 'n',
        around_last = K.around .. 'l',
        inside_next = K.inside .. 'n',
        inside_last = K.inside .. 'l',

        -- Better works in nvim-treesitter-textobjects.
        -- Move cursor to corresponding edge of `a` textobject.
        goto_left = nil,
        goto_right = nil,
      },

      -- Number of lines within which textobject is searched
      n_lines = 50,

      -- How to search for object (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
      search_method = 'cover_or_next',
    }
  end,
}
