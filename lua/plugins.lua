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
  vim.cmd(install_cmd)
  packer_was_just_bootstrapped = fn.system({ 'git', 'clone', '--depth', '1', packer_repo, packer_install_path })
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

    -- - Open and write files with sudo.
    use({ 'lambdalisue/suda.vim' })

    use({ 'tpope/vim-repeat', event = 'VimEnter' })
    use({
      'tomtom/tinykeymap_vim',
      config = [[ require('config.tinykeymap') ]],
    })

    -- * Starting page.
    use({
      'glepnir/dashboard-nvim',
      cond = function()
        return not vim.g.started_by_firenvim
      end,
      config = [[ require('config.dashboard') ]],
    })

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

    -- * Autocomplete
    use({
      'hrsh7th/nvim-cmp',
      -- event = "InsertEnter", -- for lazyload
      requires = {
        { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
        { 'f3fora/cmp-spell', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-omni', after = 'nvim-cmp' },

        -- * Ai assitance
        { 'hrsh7th/cmp-copilot', after = 'nvim-cmp' },

        -- for ultisnips users.
        --{ 'quangnguyen30192/cmp-nvim-ultisnips', after = { 'nvim-cmp', 'ultisnips' } },
        { 'saadparwaiz1/cmp_luasnip' },

        -- Cool icons.
        { 'onsails/lspkind.nvim' },
      },
      config = [[ require('config.lsp.completion') ]],
    })
    --use {'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp'}

    -- - Python formatter.
    use({ 'tell-k/vim-autopep8', ft = { 'python' } })

    -- Editing.
    use({
      'luk400/vim-jukit',

      config = function()
        require('config.jukit')
      end,
    })

    use({
      'monaqa/dial.nvim',

      config = function()
        require('config.dial')
      end,
    })
    -- * See current registers.
    -- use({ 'gennaro-tedesco/nvim-peekup' })

    -- * Batching.
    -- use({ 'terryma/vim-expand-region' })

    -- # Targets.
    -- use({
    --   'wellle/targets.vim',
    --   event = 'VimEnter',
    -- })
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

    -- Markdown.
    -- use({ 'plasticboy/vim-markdown' })
    use({
      'SidOfc/mkdx',
      ft = { 'markdown' },
    })
    -- * Preview.
    --use ({ 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview' });
    use({
      'iamcco/markdown-preview.nvim',
      run = function()
        vim.fn['mkdp#util#install']()
      end,
    })
    -- use({
    --   'iamcco/markdown-preview.nvim',
    --   run = 'cd app && npm install',
    --   setup = function()
    --     vim.g.mkdp_filetypes = { 'markdown' }
    --   end,
    --   ft = { 'markdown' },
    -- })
    -- Visuals.
    -- Show match number and index for searching
    --use ({
    --'kevinhwang91/nvim-hlslens',
    --branch = 'main',
    --keys = {{'n', '*'}, {'n', '#'}, {'n', 'n'}, {'n', 'N'}}
    --})
    -- * Highlight range of an exmode command.
    use({ 'winston0410/cmd-parser.nvim' })
    use({
      'winston0410/range-highlight.nvim',
      config = [[ require('config.range_highlight') ]],
    })

    -- * Theme.
    -- - Helpers for creating a theme.
    use({ 'rktjmp/lush.nvim' })
    -- - Themes.
    --use({ 'morhetz/gruvbox' });
    use({ 'sainnhe/gruvbox-material' })
    use({ 'vim-airline/vim-airline-themes' })

    -- use({
    --   '~/nvim/CustomThemes/deadly-gruv.nvim',
    -- })
    use({
      'DeadlySquad13/deadly-gruv.nvim',
      config = [[ require('config.theme') ]],
    });

    -- * Highlighting.
    -- - Colors.
    use({
      'norcalli/nvim-colorizer.lua',
      config = [[ require('config.colorizer') ]],
    })
    -- - Hide cursorline during moving, highlight words under cursor.
    -- use({ 'yamatsum/nvim-cursorline' })
    -- - Brackets.
    use({
      -- '~/Projects/nvim-ts-rainbow',
      'DeadlySquad13/nvim-ts-rainbow',
    })

    -- - Indents.
    -- use({
    --   'lukas-reineke/indent-blankline.nvim',
    --   event = 'VimEnter',
    --   -- Uses treesitter to calculate indentation when possible.
    --   after = 'nvim-treesitter',
    --   config = [[ require('config.indent_blankline') ]],
    -- })
    -- * Icons. (!) Should be loaded last (after nerd-tree, airline, etc...).
    --   Nerd patched fonts required.
    use({ 'ryanoasis/vim-devicons' })
    use({
      'bryanmylee/vim-colorscheme-icons',
    })

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
    })

    -- Python indent (follows the PEP8 style)
    --use({ 'Vimjas/vim-python-pep8-indent', ft = { 'python' } })

    -- Python-related text object
    --use({ 'jeetsukumaran/vim-pythonsense', ft = { 'python' } })

    --use({'machakann/vim-swap', event = 'VimEnter'})

    -- Clear highlight search automatically for you
    -- use({'romainl/vim-cool', event = 'VimEnter'})

    -- Stay after pressing * and search selected text
    --use({'haya14busa/vim-asterisk', event = 'VimEnter'})

    -- File search, tag search and more
    --if vim.g.is_win then
    --use({'Yggdroot/LeaderF', cmd = 'Leaderf'})
    --else
    --use({ 'Yggdroot/LeaderF', cmd = 'Leaderf', run = ':LeaderfInstallCExtension' })
    --end

    -- search emoji and other symbols
    --use {'nvim-telescope/telescope-symbols.nvim', after = 'telescope.nvim'}

    -- Another similar plugin is command-t
    -- use 'wincent/command-t'

    -- Another grep tool (similar to Sublime Text Ctrl+Shift+F)
    -- use 'dyng/ctrlsf.vim'

    -- A grepping tool
    -- use {'mhinz/vim-grepper', cmd = {'Grepper', '<plug>(GrepperOperator)'}}

    -- Show git change (change, delete, add) signs in vim sign column
    --use({'mhinz/vim-signify', event = 'BufEnter'})
    -- Another similar plugin
    -- use 'airblade/vim-gitgutter'

    -- Highlight URLs inside vim
    --use({'itchyny/vim-highlighturl', event = 'VimEnter'})

    -- For Windows and Mac, we can open an URL in the browser. For Linux, it may
    -- not be possible since we maybe in a server which disables GUI.
    --if vim.g.is_win or vim.g.is_mac then
    ---- open URL in browser
    --use({'tyru/open-browser.vim', event = 'VimEnter'})
    --end

    -- Only install these plugins if ctags are installed on the system
    --if utils.executable('ctags') then
    ---- show file tags in vim window
    --use({'liuchengxu/vista.vim', cmd = 'Vista'})
    --end

    -- Automatic insertion and deletion of a pair of characters
    --use({'Raimondi/delimitMate', event = 'InsertEnter'})

    -- Autosave files on certain events
    --use({
    --'Pocco81/AutoSave.nvim',
    --event = 'VimEnter',
    --config = function()
    --vim.defer_fn(function() require('config.autosave') end, 1500)
    --end
    --})

    -- Show undo history visually
    --use({'simnalamburt/vim-mundo', cmd = {'MundoToggle', 'MundoShow'}})

    -- Manage your yank history
    --if vim.g.is_win or vim.g.is_mac then
    --use({'svermeulen/vim-yoink', event = 'VimEnter'})
    --end

    -- Handy unix command inside Vim (Rename, Move etc.)
    --use({'tpope/vim-eunuch', cmd = {'Rename', 'Delete'}})

    -- Show the content of register in preview window
    -- use({ 'junegunn/vim-peekaboo' })
    --use({ 'jdhao/better-escape.vim', event = { 'InsertEnter' } })

    --if vim.g.is_mac then
    --use({ 'lyokha/vim-xkbswitch', event = { 'InsertEnter' } })
    --elseif vim.g.is_win then
    --use({ 'Neur1n/neuims', event = { 'InsertEnter' } })
    --end

    -- Syntax check and make
    -- use 'neomake/neomake'

    -- Auto format tools
    --use({ 'sbdchd/neoformat', cmd = { 'Neoformat' } })
    -- use 'Chiel92/vim-autoformat'

    -- Git command inside vim
    --use({ 'tpope/vim-fugitive', event = 'User InGitRepo' })

    -- Better git log display
    --use({ 'rbong/vim-flog', requires = 'tpope/vim-fugitive', cmd = { 'Flog' } })

    --use({ 'kevinhwang91/nvim-bqf', event = 'FileType qf', config = [[require('config.bqf')]] })

    -- Better git commit experience
    --use({'rhysd/committia.vim', opt = true, setup = [[vim.cmd('packadd committia.vim')]]})

    -- Faster footnote generation
    --use({ 'vim-pandoc/vim-markdownfootnotes', ft = { 'markdown' } })

    -- Vim tabular plugin for manipulate tabular, required by markdown plugins
    --use({ 'godlygeek/tabular', cmd = { 'Tabularize' } })

    -- Markdown JSON header highlight plugin
    --use({ 'elzr/vim-json', ft = { 'json', 'markdown' } })

    -- Only use these plugin on Windows and Mac and when LaTeX is installed
    --if vim.g.is_win or vim.g.is_mac and utils.executable('latex') then
    --use({ 'lervag/vimtex', ft = { 'tex' } })

    ---- use {'matze/vim-tex-fold', ft = {'tex', }}
    ---- use 'Konfekt/FastFold'
    --end

    -- Modern matchit implementation
    -- Better alternative to vim default `%`.
    --use({'andymass/vim-matchup', event = 'VimEnter'})

    -- Edit text area in browser using nvim
    -- Debugger plugin
    --if vim.g.is_win or vim.g.is_linux then
    --use({ 'sakhnik/nvim-gdb', run = { 'bash install.sh' }, opt = true, setup = [[vim.cmd('packadd nvim-gdb')]] })
    --end

    --if vim.g.is_linux then
    --use({'ojroques/vim-oscyank', cmd = {'OSCYank', 'OSCYankReg'}})
    --end

    -- show and trim trailing whitespaces
    --use {'jdhao/whitespace.nvim', event = 'VimEnter'}
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


