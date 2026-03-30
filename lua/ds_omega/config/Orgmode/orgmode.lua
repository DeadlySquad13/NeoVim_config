---@type LazySpec
return {
  'nvim-orgmode/orgmode',
  ft = { 'org' },

  opts = function()
    local CONSTANTS = require('ds_omega.config.keymappings._common.constants')
    local K = CONSTANTS.keymappings

    return {
      org_agenda_files = {
        '~/.bookmarks/kbn/-incoming/**/*',
        '~/.bookmarks/kbn/archive-/**/*',
        '~/.bookmarks/kbn/Clippings/**/*',
        '~/.bookmarks/kbn/logseq-/**/*',
        '~/.bookmarks/kbn/orgzly-/**/*',
        '~/.bookmarks/kbn/per Personal_system/**/*',
        '~/.bookmarks/kbn/rut Rutube_system/**/*',
        '~/.bookmarks/kbn/tasknotes-/**/*',
        '~/.bookmarks/kbn/z zettelkasten-/**/*',
      },
      org_default_notes_file = '~/orgfiles/refile.org',
      org_hide_leading_stars = true,
      org_hide_emphasis_markers = true,

      org_startup_folded = 'inherit',
      org_todo_keywords = { 'TODO', 'DOING', '|', 'DONE' },

      -- Reference to:
      -- https://github.com/nvim-orgmode/orgmode/blob/03777caca5c2df4c5b2067734b7829e9df07a423/lua/orgmode/config/mappings/init.lua
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

          org_next_visible_heading = K.next_global .. K.next_global,
          org_previous_visible_heading = K.previous_global .. K.previous_global,
        },

        agenda = {
          org_agenda_goto_today = 'ha',
          org_agenda_goto_date = 'gh',
        }
        -- agenda = {
        --   org_agenda_later = 'f',
        --   org_agenda_earlier = 'b',
        --   org_agenda_goto_today = '.',
        --   org_agenda_day_view = 'vd',
        --   org_agenda_week_view = 'vw',
        --   org_agenda_month_view = 'vm',
        --   org_agenda_year_view = 'vy',
        --   org_agenda_quit = 'q',
        --   org_agenda_switch_to = '<CR>',
        --   org_agenda_goto = '<TAB>',
        --   org_agenda_goto_date = 'J',
        --   org_agenda_redo = 'r',
        --   org_agenda_todo = 't',
        --   org_agenda_open_at_point = '<prefix>o',
        --   org_agenda_clock_goto = '<prefix>xj',
        --   org_agenda_set_effort = '<prefix>xe',
        --   org_agenda_clock_in = 'I',
        --   org_agenda_clock_out = 'O',
        --   org_agenda_clock_cancel = 'X',
        --   org_agenda_clockreport_mode = 'R',
        --   org_agenda_priority = '<prefix>,',
        --   org_agenda_priority_up = '+',
        --   org_agenda_priority_down = '-',
        --   org_agenda_archive = '<prefix>$',
        --   org_agenda_toggle_archive_tag = '<prefix>A',
        --   org_agenda_set_tags = '<prefix>t',
        --   org_agenda_deadline = '<prefix>id',
        --   org_agenda_schedule = '<prefix>is',
        --   org_agenda_filter = '/',
        --   org_agenda_refile = '<prefix>r',
        --   org_agenda_add_note = '<prefix>na',
        --   org_agenda_preview = 'K',
        --   org_agenda_show_help = 'g?',
        -- },
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
