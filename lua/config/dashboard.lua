local prequire = require('utils').prequire;

local choose_and_edit_target = require('config.commands.choose_and_edit_target');

local db = require('dashboard')

-- Possible extensions for dashboard:
-- - more find file utils,
-- - bookmarks, history, recents,
-- - load last session,
-- - new file, new project, new layer, etc...
-- - update plugins, rollback plugins, etc...
-- - exit? kind of useless but will sum up everything like in a real app :D

-- aniquote for footer.
db.shortcut_icon = {
  last_session = ' ',
  find_history = ' ',
  find_file = ' ',
  new_file = ' ',
  change_colorscheme = ' ',
  find_word = ' ',
  book_marks = ' '
}

-- Don't understand how to get it from vim.
local leader = 'Space';
local localleader = '\\';

local desc_WIDTH = 36;
local function format_description(desc, desc_width)
  desc_width = desc_width or desc_WIDTH;

  local space_left = desc_width - #desc;
  if space_left < 0 then
    notify(
      '"'..desc..'" is too long!\nMake it smaller by '..-space_left..' characters or make desc_WIDTH value bigger.',
      vim.log.levels.WARN,
      { title = 'Dashboard' }
    )
  end

  -- If space_left <= 0 it won't do anything.
  return desc..string.rep(' ', space_left);
end


local dashboard_items = {
  edit_config = {
    icon = '',
    desc = format_description('Edit config'),
    shortcut = leader..' e  ',
    action = choose_and_edit_target,
  },
  --new_file = {
    --desc = {
      --icon = '',
      --action = format_description('New file'),
      --shortcut = leader..' o n'
    --},
    --action = '',
  --},
  --change_colorscheme = {
    --desc = {
      --icon = '',
      --action = 'Change colorscheme                  ',
      --shortcut = leader..' s t'
    --},
    --action = ''
  --},

  bookmarks = {
    icon = '',
    desc = format_description('Jump to bookmarks'),
    shortcut = leader..' g b',
    action = '',
  }
}

local telescope_builtin_is_available, telescope_builtin = prequire('telescope.builtin');

if not telescope_builtin_is_available then
  return ;
end

if telescope_builtin_is_available then
  dashboard_items.pick_recent_files = {
    icon = '',
    desc = format_description('Recently opened files'),
    shortcut = leader..' o r',
    action = telescope_builtin.oldfiles,
  }

  dashboard_items.find_files = {
    icon = '',
    desc = format_description('Find files'),
    shortcut = leader..' o f',
    action = telescope_builtin.find_files,
  }

  dashboard_items.find_files_by_grep = {
    icon = '',
    desc = format_description('Find files by grep'),
    shortcut = leader..' f w',
    action = telescope_builtin.live_grep,
  }
end


local telescope_is_available, telescope = pcall(require, 'telescope');

if telescope_is_available then
  local pick_session = telescope.extensions.persisted.persisted;

  if pick_session then
    dashboard_items.pick_session = {
      icon = '☆',
      desc = format_description('Pick session'),
      shortcut = leader..' o s',
      action = pick_session,
    }
  end
end

local dashboard_custom_section = {}
local i = 1
for _, item in pairs(dashboard_items) do
  i = i + 1
  dashboard_custom_section[i] = item 
end

-- db.center_pad = 2
db.custom_center = vim.tbl_map(function(item)
  item.icon = item.icon .. ' '
  return item
end, dashboard_custom_section);

-- - Custom header.
db.header_pad = 1
db.custom_header = {
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
  [[                                                           ]]
}

db.footer_pad = 4

-- local function prepare_output_table()
--   local scripts = vim.api.nvim_exec({"echo 'test'" }, true)
--   return vim.trim(vim.split(scripts, '\n'))
-- end

-- print(prepare_output_table())

-- db.custom_footer = {
--   'I did your vim operator exercises and my hand ended up stuck inside my ass.',
--   'What should I do?',
--   '',
--   '                                         - Vim more.'
-- }

db.custom_footer = {
  'Мой вим - мой лучший друг. Он — моя жизнь. Я должен научиться владеть им',
  'так же, как я владею своей жизнью. Без меня мой вим бесполезен. Без моего',
  'вима бесполезен я. Я должен кодить из моего вима метко. Я должен',
  'кодить точнее, чем вскодер, который пытается обосрать меня. Я должен перекодить',
  'его прежде, чем он переубедит меня перейти на вскод. Да будет так…',
}
