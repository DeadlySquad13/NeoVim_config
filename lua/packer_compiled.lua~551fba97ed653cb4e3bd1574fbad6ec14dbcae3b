-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/aspakalo/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/aspakalo/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/aspakalo/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/aspakalo/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/aspakalo/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n@\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0%ds_omega.layers.Editing.comments\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["JABS.nvim"] = {
    commands = { "JABSOpen" },
    config = { "\27LJ\2\n>\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0#ds_omega.layers.Workspace.jabs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/JABS.nvim",
    url = "https://github.com/matbme/JABS.nvim"
  },
  LuaSnip = {
    config = { " require('config.luasnip') " },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["LuaSnip-snippets.nvim"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/LuaSnip-snippets.nvim",
    url = "https://github.com/molleweide/LuaSnip-snippets.nvim"
  },
  ["TrueZen.nvim"] = {
    config = { "\27LJ\2\nB\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0'ds_omega.layers.Workspace.true_zen\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/TrueZen.nvim",
    url = "https://github.com/Pocco81/TrueZen.nvim"
  },
  ["YankAssassin.vim"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/YankAssassin.vim",
    url = "https://github.com/svban/YankAssassin.vim"
  },
  ["auto-session"] = {
    config = { "\27LJ\2\nN\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0003ds_omega.layers.ProjectManagement.auto_session\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["bufdelete.nvim"] = {
    config = { "\27LJ\2\nJ\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0/ds_omega.layers.WindowManagement.bufdelete\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/bufdelete.nvim",
    url = "https://github.com/famiu/bufdelete.nvim"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\nD\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0)ds_omega.layers.Workspace.bufferline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmd-parser.nvim"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/cmd-parser.nvim",
    url = "https://github.com/winston0410/cmd-parser.nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-calc"] = {
    after_files = { "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/cmp-calc/after/plugin/cmp_calc.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/cmp-calc",
    url = "https://github.com/hrsh7th/cmp-calc"
  },
  ["cmp-cmdline"] = {
    after_files = { "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-copilot"] = {
    after_files = { "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/cmp-copilot/after/plugin/cmp_copilot.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/cmp-copilot",
    url = "https://github.com/hrsh7th/cmp-copilot"
  },
  ["cmp-nvim-lsp"] = {
    after = { "nvim-lspconfig" },
    after_files = { "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-omni"] = {
    after_files = { "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/cmp-omni/after/plugin/cmp_omni.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/cmp-omni",
    url = "https://github.com/hrsh7th/cmp-omni"
  },
  ["cmp-path"] = {
    after_files = { "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-spell"] = {
    after_files = { "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/cmp-spell/after/plugin/cmp-spell.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/cmp-spell",
    url = "https://github.com/f3fora/cmp-spell"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["dashboard-nvim"] = {
    cond = { "\27LJ\2\n5\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\24started_by_firenvim\6g\bvim\0" },
    config = { " require('config.dashboard') " },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/dashboard-nvim",
    url = "https://github.com/glepnir/dashboard-nvim"
  },
  ["deadly-gruv.nvim"] = {
    config = { " require('config.theme') " },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/deadly-gruv.nvim",
    url = "https://github.com/DeadlySquad13/deadly-gruv.nvim"
  },
  ["dial.nvim"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16config.dial\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/dial.nvim",
    url = "https://github.com/monaqa/dial.nvim"
  },
  ["dressing.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 ds_omega.layers.Ui.dressing\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["emmet-vim"] = {
    config = { " require('config.emmet-vim') " },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/emmet-vim",
    url = "https://github.com/mattn/emmet-vim"
  },
  ["fidget.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30ds_omega.layers.Ui.fidget\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  firenvim = {
    config = { " require('config.firenvim') " },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/firenvim",
    url = "https://github.com/glacambre/firenvim"
  },
  ["focus.nvim"] = {
    config = { "\27LJ\2\nF\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0+ds_omega.layers.WindowManagement.focus\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/focus.nvim",
    url = "https://github.com/beauwilliams/focus.nvim"
  },
  fzf = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["gruvbox-material"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/gruvbox-material",
    url = "https://github.com/sainnhe/gruvbox-material"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["incline.nvim"] = {
    config = { "\27LJ\2\nA\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0&ds_omega.layers.Workspace.incline\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/incline.nvim",
    url = "https://github.com/b0o/incline.nvim"
  },
  ["jupyter_ascending.vim"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/jupyter_ascending.vim",
    url = "https://github.com/untitled-ai/jupyter_ascending.vim"
  },
  ["lightspeed.nvim"] = {
    config = { "\27LJ\2\nE\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0*ds_omega.layers.Navigation.lightspeed\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/lightspeed.nvim",
    url = "https://github.com/ggandor/lightspeed.nvim"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 ds_omega.layers.Lsp.lspsaga\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/lush.nvim",
    url = "https://github.com/rktjmp/lush.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["marks.nvim"] = {
    config = { "\27LJ\2\n@\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0%ds_omega.layers.Navigation.marks\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/marks.nvim",
    url = "https://github.com/chentoast/marks.nvim"
  },
  ["mini.nvim"] = {
    config = { "\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19config.mini.ai\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/mini.nvim",
    url = "https://github.com/echasnovski/mini.nvim"
  },
  mkdx = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/mkdx",
    url = "https://github.com/SidOfc/mkdx"
  },
  ["neo-tree.nvim"] = {
    config = { "\27LJ\2\nC\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0(ds_omega.layers.Navigation.neo_tree\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  neogen = {
    config = { " require('config.neogen') " },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/neogen",
    url = "https://github.com/danymat/neogen"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\2\nC\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0(ds_omega.layers.Workspace.neoscroll\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\nB\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0'ds_omega.layers.Assistance.null_ls\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nA\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0&ds_omega.layers.Editing.autopairs\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-cmp"] = {
    after = { "cmp-buffer", "cmp-calc", "cmp-nvim-lsp", "cmp-cmdline", "cmp-copilot", "cmp-path", "cmp-omni", "cmp-spell" },
    config = { " require('config.lsp.completion') " },
    loaded = true,
    only_config = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { " require('config.colorizer') " },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/nvim-lsp-ts-utils",
    url = "https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28ds_omega.layers.Lsp.lsp\frequire\0" },
    load_after = {
      ["which-key.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30ds_omega.layers.Ui.notify\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n@\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0%ds_omega.layers.Editing.surround\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-treesitter"] = {
    after = { "tabout.nvim", "twilight.nvim" },
    config = { " require('config.treesitter') " },
    loaded = true,
    only_config = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/DeadlySquad13/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["nvim-window.git"] = {
    config = { "\27LJ\2\nG\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0,ds_omega.layers.WindowManagement.window\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/nvim-window.git",
    url = "https://gitlab.com/yorickpeterse/nvim-window"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["persisted.nvim"] = {
    config = { " require('config.persisted') " },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/persisted.nvim",
    url = "https://github.com/olimorris/persisted.nvim"
  },
  playground = {
    commands = { "TSHighlightCapturesUnderCursor", "TSPlaygroundToggle" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["range-highlight.nvim"] = {
    config = { " require('config.range_highlight') " },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/range-highlight.nvim",
    url = "https://github.com/winston0410/range-highlight.nvim"
  },
  ["rel.vim"] = {
    config = { "\27LJ\2\n>\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0#ds_omega.layers.Navigation.rel\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/rel.vim",
    url = "https://github.com/aklt/rel.vim"
  },
  rnvimr = {
    config = { "\27LJ\2\nA\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0&ds_omega.layers.Navigation.rnvimr\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/rnvimr",
    url = "https://github.com/kevinhwang91/rnvimr"
  },
  ["splitjoin.vim"] = {
    config = { "\27LJ\2\nA\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0&ds_omega.layers.Editing.splitjoin\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/splitjoin.vim",
    url = "https://github.com/AndrewRadev/splitjoin.vim"
  },
  ["suda.vim"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/suda.vim",
    url = "https://github.com/lambdalisue/suda.vim"
  },
  ["tabout.nvim"] = {
    config = { "\27LJ\2\n>\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0#ds_omega.layers.Editing.tabout\frequire\0" },
    load_after = {
      ["which-key.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/tabout.nvim",
    url = "https://github.com/abecodes/tabout.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nD\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0)ds_omega.layers.Navigation.telescope\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["textobj-word-column.vim"] = {
    load_after = {},
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/textobj-word-column.vim",
    url = "https://github.com/coderifous/textobj-word-column.vim"
  },
  tinykeymap_vim = {
    after = { "tabout.nvim" },
    config = { " require('config.tinykeymap') " },
    loaded = true,
    only_config = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/tinykeymap_vim",
    url = "https://github.com/tomtom/tinykeymap_vim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\nG\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0,ds_omega.layers.Integrations.toggleterm\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["twilight.nvim"] = {
    config = { "\27LJ\2\nB\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0'ds_omega.layers.Workspace.twilight\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/twilight.nvim",
    url = "https://github.com/benstockil/twilight.nvim"
  },
  ["vim-abolish"] = {
    config = { "\27LJ\2\n?\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0$ds_omega.layers.Editing.abolish\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-airline-themes"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/vim-airline-themes",
    url = "https://github.com/vim-airline/vim-airline-themes"
  },
  ["vim-autopep8"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/vim-autopep8",
    url = "https://github.com/tell-k/vim-autopep8"
  },
  ["vim-colorscheme-icons"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/vim-colorscheme-icons",
    url = "https://github.com/bryanmylee/vim-colorscheme-icons"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-easy-align"] = {
    config = { "\27LJ\2\nB\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0'ds_omega.layers.Editing.easy_align\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-repeat"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["vim-textobj-hydrogen"] = {
    load_after = {},
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/vim-textobj-hydrogen",
    url = "https://github.com/GCBallesteros/vim-textobj-hydrogen"
  },
  ["vim-textobj-indent"] = {
    load_after = {},
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/vim-textobj-indent",
    url = "https://github.com/kana/vim-textobj-indent"
  },
  ["vim-textobj-indented-paragraph"] = {
    load_after = {},
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/vim-textobj-indented-paragraph",
    url = "https://github.com/pianohacker/vim-textobj-indented-paragraph"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/vim-textobj-user",
    url = "https://github.com/kana/vim-textobj-user"
  },
  ["vim-visual-multi"] = {
    config = { "\27LJ\2\nE\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0*ds_omega.layers.Editing.multi_cursors\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["vim-wordmotion"] = {
    load_after = {},
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/vim-wordmotion",
    url = "https://github.com/chaoren/vim-wordmotion"
  },
  ["vim-xkbswitch"] = {
    config = { " require('config.xkbswitch') " },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/vim-xkbswitch",
    url = "https://github.com/lyokha/vim-xkbswitch"
  },
  ["which-key.nvim"] = {
    after = { "tabout.nvim", "nvim-lspconfig" },
    config = { "\27LJ\2\n<\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!ds_omega.layers.Ui.which_key\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/opt/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["winshift.nvim"] = {
    config = { "\27LJ\2\nI\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0.ds_omega.layers.WindowManagement.winshift\frequire\0" },
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/winshift.nvim",
    url = "https://github.com/sindrets/winshift.nvim"
  },
  ["xonsh-vim"] = {
    loaded = true,
    path = "/Users/aspakalo/.local/share/nvim/site/pack/packer/start/xonsh-vim",
    url = "https://github.com/abhishekmukherg/xonsh-vim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: lightspeed.nvim
time([[Setup for lightspeed.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28autocommands.lightspeed\frequire\0", "setup", "lightspeed.nvim")
time([[Setup for lightspeed.nvim]], false)
time([[packadd for lightspeed.nvim]], true)
vim.cmd [[packadd lightspeed.nvim]]
time([[packadd for lightspeed.nvim]], false)
-- Setup for: emmet-vim
time([[Setup for emmet-vim]], true)
 require('config.emmet-vim_setup') 
time([[Setup for emmet-vim]], false)
-- Config for: deadly-gruv.nvim
time([[Config for deadly-gruv.nvim]], true)
 require('config.theme') 
time([[Config for deadly-gruv.nvim]], false)
-- Config for: TrueZen.nvim
time([[Config for TrueZen.nvim]], true)
try_loadstring("\27LJ\2\nB\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0'ds_omega.layers.Workspace.true_zen\frequire\0", "config", "TrueZen.nvim")
time([[Config for TrueZen.nvim]], false)
-- Config for: dial.nvim
time([[Config for dial.nvim]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16config.dial\frequire\0", "config", "dial.nvim")
time([[Config for dial.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
 require('config.treesitter') 
time([[Config for nvim-treesitter]], false)
-- Config for: neo-tree.nvim
time([[Config for neo-tree.nvim]], true)
try_loadstring("\27LJ\2\nC\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0(ds_omega.layers.Navigation.neo_tree\frequire\0", "config", "neo-tree.nvim")
time([[Config for neo-tree.nvim]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
try_loadstring("\27LJ\2\nN\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0003ds_omega.layers.ProjectManagement.auto_session\frequire\0", "config", "auto-session")
time([[Config for auto-session]], false)
-- Config for: neogen
time([[Config for neogen]], true)
 require('config.neogen') 
time([[Config for neogen]], false)
-- Config for: bufdelete.nvim
time([[Config for bufdelete.nvim]], true)
try_loadstring("\27LJ\2\nJ\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0/ds_omega.layers.WindowManagement.bufdelete\frequire\0", "config", "bufdelete.nvim")
time([[Config for bufdelete.nvim]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30ds_omega.layers.Ui.fidget\frequire\0", "config", "fidget.nvim")
time([[Config for fidget.nvim]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30ds_omega.layers.Ui.notify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
 require('config.luasnip') 
time([[Config for LuaSnip]], false)
-- Config for: firenvim
time([[Config for firenvim]], true)
 require('config.firenvim') 
time([[Config for firenvim]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0%ds_omega.layers.Editing.surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\nG\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0,ds_omega.layers.Integrations.toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: vim-xkbswitch
time([[Config for vim-xkbswitch]], true)
 require('config.xkbswitch') 
time([[Config for vim-xkbswitch]], false)
-- Config for: vim-abolish
time([[Config for vim-abolish]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0$ds_omega.layers.Editing.abolish\frequire\0", "config", "vim-abolish")
time([[Config for vim-abolish]], false)
-- Config for: winshift.nvim
time([[Config for winshift.nvim]], true)
try_loadstring("\27LJ\2\nI\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0.ds_omega.layers.WindowManagement.winshift\frequire\0", "config", "winshift.nvim")
time([[Config for winshift.nvim]], false)
-- Config for: incline.nvim
time([[Config for incline.nvim]], true)
try_loadstring("\27LJ\2\nA\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0&ds_omega.layers.Workspace.incline\frequire\0", "config", "incline.nvim")
time([[Config for incline.nvim]], false)
-- Config for: nvim-window.git
time([[Config for nvim-window.git]], true)
try_loadstring("\27LJ\2\nG\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0,ds_omega.layers.WindowManagement.window\frequire\0", "config", "nvim-window.git")
time([[Config for nvim-window.git]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
 require('config.lsp.completion') 
time([[Config for nvim-cmp]], false)
-- Config for: rnvimr
time([[Config for rnvimr]], true)
try_loadstring("\27LJ\2\nA\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0&ds_omega.layers.Navigation.rnvimr\frequire\0", "config", "rnvimr")
time([[Config for rnvimr]], false)
-- Config for: lightspeed.nvim
time([[Config for lightspeed.nvim]], true)
try_loadstring("\27LJ\2\nE\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0*ds_omega.layers.Navigation.lightspeed\frequire\0", "config", "lightspeed.nvim")
time([[Config for lightspeed.nvim]], false)
-- Config for: vim-easy-align
time([[Config for vim-easy-align]], true)
try_loadstring("\27LJ\2\nB\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0'ds_omega.layers.Editing.easy_align\frequire\0", "config", "vim-easy-align")
time([[Config for vim-easy-align]], false)
-- Config for: focus.nvim
time([[Config for focus.nvim]], true)
try_loadstring("\27LJ\2\nF\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0+ds_omega.layers.WindowManagement.focus\frequire\0", "config", "focus.nvim")
time([[Config for focus.nvim]], false)
-- Config for: vim-visual-multi
time([[Config for vim-visual-multi]], true)
try_loadstring("\27LJ\2\nE\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0*ds_omega.layers.Editing.multi_cursors\frequire\0", "config", "vim-visual-multi")
time([[Config for vim-visual-multi]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nD\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0)ds_omega.layers.Navigation.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: tinykeymap_vim
time([[Config for tinykeymap_vim]], true)
 require('config.tinykeymap') 
time([[Config for tinykeymap_vim]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 ds_omega.layers.Lsp.lspsaga\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: range-highlight.nvim
time([[Config for range-highlight.nvim]], true)
 require('config.range_highlight') 
time([[Config for range-highlight.nvim]], false)
-- Config for: rel.vim
time([[Config for rel.vim]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0#ds_omega.layers.Navigation.rel\frequire\0", "config", "rel.vim")
time([[Config for rel.vim]], false)
-- Config for: dressing.nvim
time([[Config for dressing.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 ds_omega.layers.Ui.dressing\frequire\0", "config", "dressing.nvim")
time([[Config for dressing.nvim]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\nB\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0'ds_omega.layers.Assistance.null_ls\frequire\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: persisted.nvim
time([[Config for persisted.nvim]], true)
 require('config.persisted') 
time([[Config for persisted.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
 require('config.colorizer') 
time([[Config for nvim-colorizer.lua]], false)
-- Config for: mini.nvim
time([[Config for mini.nvim]], true)
try_loadstring("\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19config.mini.ai\frequire\0", "config", "mini.nvim")
time([[Config for mini.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\nA\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0&ds_omega.layers.Editing.autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: neoscroll.nvim
time([[Config for neoscroll.nvim]], true)
try_loadstring("\27LJ\2\nC\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0(ds_omega.layers.Workspace.neoscroll\frequire\0", "config", "neoscroll.nvim")
time([[Config for neoscroll.nvim]], false)
-- Config for: marks.nvim
time([[Config for marks.nvim]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0%ds_omega.layers.Navigation.marks\frequire\0", "config", "marks.nvim")
time([[Config for marks.nvim]], false)
-- Config for: splitjoin.vim
time([[Config for splitjoin.vim]], true)
try_loadstring("\27LJ\2\nA\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0&ds_omega.layers.Editing.splitjoin\frequire\0", "config", "splitjoin.vim")
time([[Config for splitjoin.vim]], false)
-- Conditional loads
time([[Conditional loading of dashboard-nvim]], true)
  require("packer.load")({"dashboard-nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of dashboard-nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd vim-textobj-user ]]
vim.cmd [[ packadd cmp-omni ]]
vim.cmd [[ packadd cmp-copilot ]]
vim.cmd [[ packadd cmp-calc ]]
vim.cmd [[ packadd cmp-nvim-lsp ]]
vim.cmd [[ packadd cmp-buffer ]]
vim.cmd [[ packadd cmp-spell ]]
vim.cmd [[ packadd cmp-path ]]
vim.cmd [[ packadd cmp-cmdline ]]
vim.cmd [[ packadd twilight.nvim ]]

-- Config for: twilight.nvim
try_loadstring("\27LJ\2\nB\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0'ds_omega.layers.Workspace.twilight\frequire\0", "config", "twilight.nvim")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSHighlightCapturesUnderCursor lua require("packer.load")({'playground'}, { cmd = "TSHighlightCapturesUnderCursor", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file JABSOpen lua require("packer.load")({'JABS.nvim'}, { cmd = "JABSOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSPlaygroundToggle lua require("packer.load")({'playground'}, { cmd = "TSPlaygroundToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType python ++once lua require("packer.load")({'vim-autopep8'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'emmet-vim'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'emmet-vim'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascriptreact ++once lua require("packer.load")({'emmet-vim'}, { ft = "javascriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescriptreact ++once lua require("packer.load")({'emmet-vim'}, { ft = "typescriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'mkdx'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'Comment.nvim', 'vim-textobj-indented-paragraph', 'bufferline.nvim', 'textobj-word-column.vim', 'vim-textobj-indent', 'vim-wordmotion', 'vim-repeat', 'vim-textobj-hydrogen', 'nvim-ts-context-commentstring'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufWinEnter * ++once lua require("packer.load")({'which-key.nvim'}, { event = "BufWinEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
