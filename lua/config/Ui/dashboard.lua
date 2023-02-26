local prequire = require('utils').prequire;

local choose_and_edit_configs = require('config.commands.choose_and_edit_configs');

-- Possible extensions for dashboard:
-- - more find file utils,
-- - bookmarks, history, recents,
-- - load last session,
-- - new file, new project, new layer, etc...
-- - update plugins, rollback plugins, etc...

-- aniquote for footer.
-- db.key_icon = {
--     last_session = ' ',
--     find_history = ' ',
--     find_file = ' ',
--     new_file = ' ',
--     change_colorscheme = ' ',
--     find_word = ' ',
--     book_marks = ' '
-- }

local leader = vim.g.mapleader;
if leader == ' ' then
  leader = 'Space'
end

-- local localleader = '\\';

local desc_WIDTH = 36;
local function format_description(desc, desc_width)
  desc_width = desc_width or desc_WIDTH;

  local space_left = desc_width - #desc;
  if space_left < 0 then
    notify(
        '"' .. desc .. '" is too long!\nMake it smaller by ' ..
        -space_left .. ' characters or make desc_WIDTH value bigger.',
        vim.log.levels.WARN,
        { title = 'Dashboard' }
    )
  end

  -- If space_left <= 0 it won't do anything.
  return desc .. string.rep(' ', space_left);
end

local center_sections = {
    {
        icon = '',
        desc = format_description('Edit config'),
        key = leader .. ' e e',
        action = choose_and_edit_configs,
    },
    {
        icon = '',
        desc = format_description('Jump to bookmarks'),
        key = leader .. ' g b',
        action = '',
    },
}

local function add_sections(sections)
  vim.list_extend(center_sections, sections)
end

local telescope_builtin_is_available, telescope_builtin = prequire('telescope.builtin');

if not telescope_builtin_is_available then
  return;
end

if telescope_builtin_is_available then
  add_sections({
      {
          icon = '',
          desc = format_description('Recently opened files'),
          key = leader .. ' o r',
          action = telescope_builtin.oldfiles,
      },
      {
          icon = '',
          desc = format_description('Find files'),
          key = leader .. ' o f',
          action = telescope_builtin.find_files,
      },
      {
          icon = '',
          desc = format_description('Find files by grep'),
          key = leader .. ' f w',
          action = telescope_builtin.live_grep,
      },
  })
end


local telescope_is_available, telescope = pcall(require, 'telescope');

if telescope_is_available then
  local pick_session = telescope.extensions.persisted.persisted;

  if pick_session then
    add_sections({{
        icon = '☆',
        desc = format_description('Pick session'),
        key = leader .. ' o s',
        action = pick_session,
    }})
  end
end

add_sections({{
    icon = '☆',
    desc = format_description('Back to reality...'),
    key = 'Z Q',
    action = 'quit!'
}})

local center = vim.tbl_map(function(item)
      item.icon = item.icon .. ' '

      return vim.tbl_extend('error', item, {
              desc_hl = 'DashboardCenter',
              key_hl = 'DashboardShortcut',
          })
    end, center_sections)

-- - Custom header.
local header = {
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                    ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣷⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣤⣶⣶⣿⡟⠀                   ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣦⣄⠀⣀⣠⣤⣤⣶⣶⣶⣶⣶⣴⣾⣿⣿⣿⣿⣿⣿⡟⠁⠀                   ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡿⠯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⡟⠀⠀    ___  ___________]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⡀⢨⣿⣿⡃⠀⠀⠀⠀ / _ \\/ __<  /_  /]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀/ // /\\ \\ / //_ < ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢫⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀/____/___//_/____/ ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢃⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣇⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⢇⣿⣿⣿⣿⡈⣻⡝⢿⣿⣿⢿⣟⣹⣁⢀⠘⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢙⠇⣿⣿⣿⠻⣿⣿⠢⠁⠉⠛⠛⠻⣿⣿⠿⠋⠓⠹⢋⡽⢹⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡎⢾⡏⢠⠍⢡⣳⡟⠀⠀⠀⠀⠀⠀⠁⠉⠀⠠⢆⠐⠍⠒⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⡘⠐⠁⠀⢁⡋⠄⠀⠀⠀⠀⠀⠀⠀⠀⠁⠒⡀⠂⠀⠀⢹⣿⣿⣿⣿⡿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡀⣻⣄⣣⡀⠻⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠡⠀⠀⠀⠀⣸⣿⣿⣿⣿⠃⠡⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣄⠀⠀⠈⠳⣦⠉⠀⠀⠀⢀⠠⡰⠁⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⡀⠀⠓⠠⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⢸⣟⣀⡑⢄⠀⠀⢻⡇⣴⣶⣿⡆⡈⠀⠀⠀⠀⣰⣿⣿⣿⣿⡿⢀⡟⠁⠀⠀⠀⠐⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠁⠀⠀⠈⠙⣾⠀⣀⡼⢸⣿⣿⣿⣿⣿⡀⠀⠀⣸⣿⣿⣿⣿⡟⣠⡟⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡌⠀⠀⠀⠀⠀⠘⢸⠑⡁⢸⣿⣿⣿⣿⣿⠀⠉⠁⢸⣿⣿⣿⣿⣷⣿⠁⠀⠀⠀⠀⠀⠀⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠶⠁⠀⠀⠀⠈⠀⡇⠀⠀⠁⠸⣹⣿⡿⡿⣿⠀⠀⠀⢸⣿⣿⣿⣿⠏⣿⠀⠀⠀⠀⠀⠀⠀⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣇⠀⠇⠀⠀⠀⠀⢱⠀⠀⠀⠀⠆⢿⣣⡄⠀⣺⠀⠀⠀⠘⣿⣿⣿⡟⢰⡇⡇⠀⠀⠀⠀⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣆⢠⠀⠀⠀⣀⡜⠀⠀⠀⠀⢀⣆⣿⡶⠾⢻⠀⠀⠀⠀⢸⣿⣿⣧⣸⣧⡃⠀⢀⣀⣠⣤⣄⡀⡆⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⡷⣄⠀⠀⠇⠀⠀⠀⠀⢺⣿⡿⠀⠀⢀⠀⠀⠀⠀⠈⣿⣿⠛⣿⣯⠖⠊⠉⠀⠀⠀⣼⠙⠢⡀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⢠⣇⠈⠳⡼⠀⠀⠀⠀⠀⢸⣿⠃⡆⠀⢸⠀⠀⠀⠀⠀⢻⣿⣴⠟⠀⠀⠀⠀⠀⠀⣰⣿⠀⠀⡁⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⢿⠀⠀⠃⠀⠀⠀⠠⠄⢻⠇⢀⠁⠀⢸⠀⠀⠀⠀⠀⠘⣿⡇⠀⠀⠀⠀⠀⠀⠠⣸⢸⡤⠊⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠤⡈⠀⠀⠀⠀⠀⠀⢸⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢛⡟⠦⠤⠂⠀⠀⣠⠗⡏⠁⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠁⠀⠀⠀⠀⠀⠀⢸⡀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡌⠢⠀⠀⠀⣰⣿⣔⣀⣀⣸⠀⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡈⠀⠀⠀⠀⠀⠀⠀⢸⣷⣇⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⢘⠀⠀⠀⣰⣿⣏⢌⠀⠀⠀⠆             ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣦⣴⣿⡀⠀⠀⠀⠀⠀⠀⢸⡇⠀⣰⣿⣿⣷⣼⣀⡀⠜⠲⠀⠀⠀⠀⠀⠀⠀⠀     ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⡀⠀⠀⠀⠀⠀⠠⠛⠛⠋⠙⠿⣿⣷⡀⠀⠀⠀⠀⠀⠘⢀⣼⣿⣿⣿⣿⡝⠃⠀⠀⣼⠀⠀    ⠀⠀   ⠀ ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣤⣴⣶⣄⠀⠀⠀⣠⣷⣶⣶⣶⣶⣶⣶⣿⣷⡄⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋     ]],
    [[⠀⠀⠀⠀⠀⠀⢀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠁⠀      ]],
    [[⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠉          ]],
    [[                                                           ]],
    '',
}

local footer = {
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    'Мой вим - мой лучший друг. Он - моя жизнь. Я должен научиться владеть им',
    'так же, как я владею своей жизнью. Без меня мой вим бесполезен. Без моего',
    'вима бесполезен я. Я должен кодить из моего вима метко. Я должен',
    'кодить точнее, чем вскодер, который пытается обосрать меня. Я должен перекодить',
    'его прежде, чем он переубедит меня перейти на вскод. Да будет так…',
    '',
    '',
    '',
    '',
}

return {
    theme = 'doom',
    config = {
        header = header,
        center = center,
        footer = footer,
    }
}
