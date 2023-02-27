local ENV = require('constants.env')
local fn = vim.fn
vim.g.package_home = fn.stdpath('data') .. '/site/pack/packer'
local packer_install_path = vim.g.package_home .. '/opt/packer.nvim'

local plug_url_format = ''
if vim.g.is_linux then
  plug_url_format = 'https://hub.fastgit.xyz/%s'
else
  plug_url_format = 'https://github.com/%s'
end

local packer_repo = string.format(plug_url_format, 'wbthomason/packer.nvim')
local install_cmd = string.format(
        'git clone --depth=1 %s %s',
        packer_repo,
        packer_install_path
    )
-- Auto-install packer in case it hasn't been installed.
if fn.glob(packer_install_path) == '' then
  vim.api.nvim_echo({ { 'Installing packer.nvim', 'Type' } }, true, {})
  -- TODO: Remove this line. It seems only fn.system call works on Windows.
  vim.cmd(install_cmd)
  local packer_was_just_bootstrapped = fn.system({ 'git', 'clone', '--depth', '1', packer_repo, packer_install_path })
end

-- Load packer.nvim
vim.cmd('packadd packer.nvim')

local util = require('packer.util')

local startup = require('utils.core').startup

startup({
    function(use, use_plugin, use_rocks)
      -- - It is recommened to put impatient.nvim before any other plugins.
      use({ 'lewis6991/impatient.nvim' })
      -- Make a pull request to it to allow depth.
      --use({
      --  'mrjones2014/load-all.nvim',

      --  requires = 'nvim-lua/plenary.nvim',
      --})
      -- - Packer itself can be managed.
      use({ 'wbthomason/packer.nvim', opt = true })

      -- General.
      use({ 'nvim-lua/plenary.nvim' })
      -- use_rocks({ 'functional' })

      -- - Xonsh syntax file.
      use({ 'abhishekmukherg/xonsh-vim' })
      -- - Yank without moving cursor.
      use({ 'svban/YankAssassin.vim', event = 'VimEnter' })

      -- * Integration.
      -- - With system.
      -- use({ 'majkinetor/vim-omnipresence' })

      -- - With browser.
      use({
          'glacambre/firenvim',
          run = function()
            vim.fn['firenvim#install'](0)
          end,
          config = [[ require('config.firenvim') ]],
      })
      -- - With Jupyter.
      use({ 'untitled-ai/jupyter_ascending.vim' })
      use({
          'luk400/vim-jukit',
          config = function()
            require('config.jukit')
          end,
      })
      use({
          'kiyoon/jupynium.nvim',
          run = 'pip3 install --user .',
      })

      -- - Open and write files with sudo.
      use({ 'lambdalisue/suda.vim' })

      use({ 'tpope/vim-repeat', event = 'VimEnter' })
      -- use({
      --   'tomtom/tinykeymap_vim',
      --   config = [[ require('config.tinykeymap') ]],
      -- })

      -- * Project management.
      -- - Session management.
      use({
          'olimorris/persisted.nvim',
          --module = "persisted", -- For lazy loading
          config = [[ require('config.persisted') ]],
      })

      -- * Russian layout.
      --use({ 'powerman/vim-plugin-ruscmd' })
      use({
          'lyokha/vim-xkbswitch',
          config = [[ require('config.xkbswitch') ]],
      })

      -- # Snippets.
      --use({
      --'SirVer/ultisnips',

      --setup = [[ require('autocommands.ultisnips') ]],
      --config = [[ require('config.ultisnips') ]],
      --});
      use({
          'L3MON4D3/LuaSnip',
          -- Breaks as cmp is loaded earlier. Make as a dep for cmp?
          --event = 'BufReadPre',

          config = [[ require('config.luasnip') ]],
          requires = {
              'molleweide/LuaSnip-snippets.nvim',
          },
      })

      -- * Collections of snippets.
      -- - General and specific for popular filetypes.
      use({ 'honza/vim-snippets' })
      -- - Emmet for html.
      use({
          'mattn/emmet-vim',
          -- Specifies code to run before this plugin is loaded.
          --  Have to disable it globally before it's loaded. Otherwise plugin will
          --  polute all filetypes with it's keybindings after it has been loaded
          --  in some file.
          setup = [[ require('config.emmet-vim_setup') ]],
          ft = { 'css', 'html', 'javascriptreact', 'typescriptreact' },
          config = [[ require('config.emmet-vim') ]],
      })

      -- - Python formatter.
      use({ 'tell-k/vim-autopep8', ft = { 'python' } })

      -- Editing.
      use({
          'echasnovski/mini.nvim',
          config = function()
            require('config.mini.ai')
          end,
          -- branch = 'stable'
      })

      -- ! Doesn't support lazy loading! Normal vim groups are not mapped to TS
      --   groups.
      use({
          'nvim-treesitter/nvim-treesitter',
          -- - We recommend updating the parsers on update.
          run = ':TSUpdate',
          config = [[ require('config.treesitter') ]],
      })

      use({
          'nvim-treesitter/playground',
          cmd = { 'TSHighlightCapturesUnderCursor', 'TSPlaygroundToggle' },
          requires = 'nvim-treesitter/nvim-treesitter',
      })
      use({
          'stsewd/sphinx.nvim',
          run = ':UpdateRemotePlugins',
      })

      -- * Quickfix list.
      use({
          'kevinhwang91/nvim-bqf',
          event = 'FileType qf',
          requires = {
              {
                  'junegunn/fzf.vim',
                  requires = {
                      'junegunn/fzf',
                      opt = false,
                      run = function() -- Make sure that you have the latest binary.
                        vim.fn['fzf#install']()
                      end,
                  },
              },
              {
                  'nvim-treesitter/nvim-treesitter',
                  opt = true, -- Highly recommended.
              },
          },
      })

      -- * Theme.
      -- - Helpers for creating a theme.
      use({ 'rktjmp/lush.nvim' })
      -- - Themes.
      --use({ 'morhetz/gruvbox' });
      use({ 'sainnhe/gruvbox-material' })
      use({ 'savq/melange-nvim' })

      use({
          -- 'DeadlySquad13/deadly-gruv.nvim',
          --   '~/nvim/CustomThemes/deadly-gruv.nvim',
          [[C:\Users\ds13\.bookmarks\Projects\--personal\NeoVim__DeadyGruv_theme]],
          config = [[ require('config.theme') ]],
      });

      -- * Highlighting.
      --   Nerd patched fonts required.
      -- use({
      --     'bryanmylee/vim-colorscheme-icons',
      -- })

      -- - Documentation generation.
      use({
          'danymat/neogen',
          config = [[ require('config.neogen') ]],
          --config = function()
          --require('neogen').setup();
          --end,
          requires = 'nvim-treesitter/nvim-treesitter',
          -- Uncomment next line if you want to follow only stable versions.
          -- tag = "*",
      })

      -- # Runners
      -- - Sniprun. Works only on Unix systems.
      -- use({
      --   'michaelb/sniprun',
      --   run = 'bash ./install.sh',
      -- })

      use({
          'Olical/conjure',
          config = function()
            vim.g['conjure#mapping#doc_word'] = '<Leader>ii'
          end,
      })

      -- Python-related text object
      --use({ 'jeetsukumaran/vim-pythonsense', ft = { 'python' } })

      --use({'machakann/vim-swap', event = 'VimEnter'})

      -- Clear highlight search automatically for you
      -- use({'romainl/vim-cool', event = 'VimEnter'})

      -- Stay after pressing * and search selected text
      --use({'haya14busa/vim-asterisk', event = 'VimEnter'})

      -- A grepping tool
      -- use {'mhinz/vim-grepper', cmd = {'Grepper', '<plug>(GrepperOperator)'}}

      -- Show git change (change, delete, add) signs in vim sign column
      -- use 'airblade/vim-gitgutter'

      -- Highlight URLs inside vim
      --use({'itchyny/vim-highlighturl', event = 'VimEnter'})

      --open URL in browser
      --use({'tyru/open-browser.vim', event = 'VimEnter'})

      -- Only install these plugins if ctags are installed on the system
      --if utils.executable('ctags') then
      ---- show file tags in vim window
      --use({'liuchengxu/vista.vim', cmd = 'Vista'})
      --end

      -- Autosave files on certain events
      --use({
      --'Pocco81/AutoSave.nvim',
      --event = 'VimEnter',
      --config = function()
      --vim.defer_fn(function() require('config.autosave') end, 1500)
      --end
      --})

      -- Handy unix command inside Vim (Rename, Move etc.)
      --use({'tpope/vim-eunuch', cmd = {'Rename', 'Delete'}})

      --if vim.g.is_mac then
      --use({ 'lyokha/vim-xkbswitch', event = { 'InsertEnter' } })
      --elseif vim.g.is_win then
      --use({ 'Neur1n/neuims', event = { 'InsertEnter' } })
      --end

      -- Syntax check and make
      -- use 'neomake/neomake'

      -- Better git log display
      -- Other alternatives are listed in FAQ
      --use({ 'rbong/vim-flog', requires = 'tpope/vim-fugitive', cmd = { 'Flog' } })

      -- Better git commit experience
      --use({'rhysd/committia.vim', opt = true, setup = [[vim.cmd('packadd committia.vim')]]})

      -- Faster footnote generation
      --use({ 'vim-pandoc/vim-markdownfootnotes', ft = { 'markdown' } })

      -- Vim tabular plugin for manipulate tabular, required by markdown plugins
      --use({ 'godlygeek/tabular', cmd = { 'Tabularize' } })

      -- Markdown JSON header highlight plugin
      --use({ 'elzr/vim-json', ft = { 'json', 'markdown' } })

      --use {'matze/vim-tex-fold', ft = {'tex', }}
      --use 'Konfekt/FastFold'

      -- Modern matchit implementation
      -- Better alternative to vim default `%`.
      --use({'andymass/vim-matchup', event = 'VimEnter'})

      -- Debugger plugin
      --if vim.g.is_win or vim.g.is_linux then
      --use({ 'sakhnik/nvim-gdb', run = { 'bash install.sh' }, opt = true, setup = [[vim.cmd('packadd nvim-gdb')]] })
      --end
    end,
    config = {
        max_jobs = 16,

        -- snapshot = util.join_paths(ENV.NVIM_CONFIG, "packer-lock.json"),
        snapshot_path = ENV.NVIM_CONFIG,

        compile_path = util.join_paths(ENV.NVIM_LUA, 'packer_compiled.lua'),
        git = {
            default_url_format = plug_url_format,
        },

        display = {
            open_fn = require('packer.util').float,
        },
    },
    layers = require('layers_specification'),
})

local status, _ = pcall(require, 'packer_compiled')
if not status then
  notify('Error requiring packer_compiled.lua: run PackerSync to fix!')
end
