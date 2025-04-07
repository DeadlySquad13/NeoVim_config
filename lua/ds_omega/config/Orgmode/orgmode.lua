return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },

  opts = function()
    local CONSTANTS = require('ds_omega.config.keymappings._common.constants')
    local K = CONSTANTS.keymappings

    return {
      org_agenda_files = '~/orgfiles/**/*',
      org_default_notes_file = '~/orgfiles/refile.org',
      org_hide_leading_stars = true,
      org_hide_emphasis_markers = true,

      mappings = {
        text_objects = {
          inner_heading = K.inside .. 'h',
          around_heading = K.around .. 'h',

          inner_subtree = K.inside .. 'r',
          around_subtree = K.around .. 'r',
        },

        org = {
          -- org_todo = "<C-Cr>",
          org_todo = 'm' .. K.inside .. 't',
          org_todo_prev = 'm' .. K.inside .. 'T',

          -- Folding.
          org_cycle = 'z<Tab>',
          org_global_cycle = 'Z<Tab>',
        }
      },
    }
  end,

  -- Installs org treesitter parser automatically.
  config = function(_, opts)
    -- Setup orgmode
    require('orgmode').setup(opts)
    local prequire = require('ds_omega.utils').prequire

    local cmp_is_available, cmp = prequire('cmp')

    if not cmp_is_available then
      return
    end

    local config = cmp.get_config()
    table.insert(config.sources, { name = 'orgmode' })

    cmp.setup(config)
  end,
}
