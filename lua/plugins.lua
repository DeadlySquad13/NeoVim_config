--local utils = require('utils')
local fn = vim.fn

vim.g.package_home = fn.stdpath('data') .. '/site/pack/packer/'
local packer_install_dir = vim.g.package_home .. '/opt/packer.nvim'

local plug_url_format = ''
if vim.g.is_linux then
  plug_url_format = 'https://hub.fastgit.xyz/%s'
else
  plug_url_format = 'https://github.com/%s'
end

local packer_repo = string.format(plug_url_format, 'wbthomason/packer.nvim')
local install_cmd = string.format('10split |term git clone --depth=1 %s %s', packer_repo, packer_install_dir)

-- Auto-install packer in case it hasn't been installed.
if fn.glob(packer_install_dir) == '' then
  vim.api.nvim_echo({ { 'Installing packer.nvim', 'Type' } }, true, {})
  vim.cmd(install_cmd)
end

-- Load packer.nvim
vim.cmd('packadd packer.nvim')
local util = require('packer.util')

require('packer').startup({
  function(use)
    -- - It is recommened to put impatient.nvim before any other plugins.
    use({ 'lewis6991/impatient.nvim' })
    -- - Packer itself can be managed.
    use({ 'wbthomason/packer.nvim', opt = true })

    -- General.
    use ({
      'folke/which-key.nvim',
      event = 'VimEnter',
      -- config = function()
      --   vim.defer_fn(function()
      --     require('config.which_key')
      --   end, 2000)
      -- end,
      after = 'telescope.nvim',
      config = [[ require('config.which_key') ]],
    });

    -- - Xonsh syntax file.
    use({ 'abhishekmukherg/xonsh-vim' });
    -- - Yank without moving cursor.
    use({ 'svban/YankAssassin.vim' });

    -- * Integration.
    -- - With system.
    use({ 'majkinetor/vim-omnipresence' });
    -- - With browser.
    use({
      'glacambre/firenvim',
      run = function() vim.fn['firenvim#install'](0) end,
      config = [[ require('config.firenvim') ]],
    });
    -- - With Jupyter.
    use({ 'untitled-ai/jupyter_ascending.vim' });

    -- - Open and write files with sudo.
    use({ 'lambdalisue/suda.vim' });

    use({'tpope/vim-repeat', event = 'VimEnter'})
    use({
      'tomtom/tinykeymap_vim',
      config = [[ require('config.tinykeymap') ]]
    });

  -- * Starting page.
  --use({ 'mhinz/vim-startify' });
    use({
      'glepnir/dashboard-nvim',
      cond = function()
        return not vim.g.started_by_firenvim;
      end,
      config = [[ require('config.dashboard') ]],
    });

  -- * Sessions.
  --use({ 'rmagatti/auto-session' });

  -- * Session management.
  --use({ 'rmagatti/session-lens' });

  -- * Russian layout.
  use({ 'powerman/vim-plugin-ruscmd' });

  -- LSP.
  -- - Config for completion engine, needs completion engine.
    -- use({
    --   'williamboman/nvim-lsp-installer',
    -- },
    -- {
    --   'neovim/nvim-lspconfig',
    --   --after = 'cmp-nvim-lsp',
    --   config = [[ require('config.lsp') ]],
    -- });
  use {
    'williamboman/nvim-lsp-installer',
    {
        'neovim/nvim-lspconfig',
        config = [[ require('config.lsp') ]]
    }
  }
  -- * Snippets.
  use({ 'SirVer/ultisnips' });
  -- - Collections of snippets.
  use({ 'honza/vim-snippets' });
  use({ 'mattn/emmet-vim' });

  -- * Autocomplete
   use ({
      "hrsh7th/nvim-cmp",
      event = "InsertEnter", -- for lazyload
      requires = {
        { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
        { "f3fora/cmp-spell", after = "nvim-cmp" },
        { "hrsh7th/cmp-path", after = "nvim-cmp" },
        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
        { "hrsh7th/cmp-calc", after = "nvim-cmp" },
        { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
        -- for ultisnips users.
        { "quangnguyen30192/cmp-nvim-ultisnips", after = { "nvim-cmp", 'ultisnips' } },

        -- Not yet intergrated with ultisnips, have to separately define jumps
        --   in mappings.
        { 'danymat/neogen' },
      },
      config = [[ require('config.lsp.completion') ]],
    })
    --use {'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp'}

    -- - Python formatter.
    use({ 'tell-k/vim-autopep8', ft = { 'python' } });

  -- Coding.
  -- * Brackets.
  use({
    'windwp/nvim-autopairs',
    config = [[ require ('config.nvim_autopairs') ]]
  });

  -- * Comments.
  use({ 'preservim/nerdcommenter', event = 'VimEnter' });

  -- * Surround.
  use({ 'tpope/vim-surround' });

  -- * Find.
  use({ 'gennaro-tedesco/nvim-peekup' });

  -- * Batching.
  use({ 'terryma/vim-expand-region' });
  use({
    'mg979/vim-visual-multi',
    branch = 'master'
  });

  -- * Permutations.
  use({ 'tpope/vim-abolish' });

  -- * Formatting.
  -- - Align by symbol or regex pattern.
  use({ 'junegunn/vim-easy-align' });
  -- - Change object from inline to multi-line and vice versa.
  use({ 'AndrewRadev/splitjoin.vim' });

  -- * Motion.
  use({ 'tjdevries/train.nvim' });
    use({ 'ggandor/lightspeed.nvim' });

    -- # Targets.
    use({
      'wellle/targets.vim',
      event = 'VimEnter',
    });
    -- Textobj-user extensions.
    use({
      'kana/vim-textobj-user',
      event = 'VimEnter',
    });
    -- - Columns.
    use({
      'coderifous/textobj-word-column.vim',
      event = 'VimEnter',
      after = 'vim-textobj-user',
    });
    -- - Indented paragraph.
    use({
      'pianohacker/vim-textobj-indented-paragraph',
      event = 'VimEnter',
      after = 'vim-textobj-user',
    });
    -- - Indents.
    use({
      'kana/vim-textobj-indent',
      event = 'VimEnter',
      after = 'vim-textobj-user',
    });
    -- - Hydrogen (jupyter notebook cells).
    use({
      'GCBallesteros/vim-textobj-hydrogen',
      event = 'VimEnter',
      after = 'vim-textobj-user',
    })

    -- * Case delimited and _ delimited words.
    use({
      'chaoren/vim-wordmotion',
      event = 'VimEnter',
      after = 'vim-textobj-user',
    });


    -- # Navigation.
    -- * Inside  file.
    -- * Across files.
    use({ 'kevinhwang91/rnvimr' });
    use({ 'preservim/nerdtree' });

    -- * Telescope deps.
    use({ 'nvim-lua/plenary.nvim' });
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{ 'nvim-lua/plenary.nvim' }}
    }

    -- - We recommend updating the parsers on update
    use({
      'nvim-treesitter/nvim-treesitter',
      event = 'BufEnter',
      run = ':TSUpdate',
      config = [[ require('config.treesitter')]],
    });

  -- - Jumping to file under cursor.
  use({ 'aklt/rel.vim' });

  -- Markdown.
  -- use({ 'plasticboy/vim-markdown' })
    use({
      'SidOfc/mkdx',
      ft = { 'markdown' },
    });
  -- * Preview.
  --use ({ 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview' });
    use({
      'iamcco/markdown-preview.nvim',
      run = function() vim.fn['mkdp#util#install']() end,
    });
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
  use ({
    'kevinhwang91/nvim-hlslens',
    branch = 'main',
    keys = {{'n', '*'}, {'n', '#'}, {'n', 'n'}, {'n', 'N'}}
  })
  -- * Highlight range of an exmode command.
  use({ 'winston0410/cmd-parser.nvim' });
  use({
    'winston0410/range-highlight.nvim',
    config = [[ require('config.range_highlight') ]]
  });

  -- * Workspace.
  use({
    'Pocco81/TrueZen.nvim',
    config = [[ require ('config.true_zen') ]]
  });
  use({
    'folke/twilight.nvim',
    -- Uses treesitter to automatically expand the visible text.
    after = 'nvim-treesitter',
    config = [[ require ('config.twilight') ]]
  });

  -- * Status line.
  use({ 'vim-airline/vim-airline' });

  -- Coding.
  -- Should be loaded after all plugins that use trigger key ('tab').
  use({
    'abecodes/tabout.nvim',
    config = [[ require('config.tabout') ]],
    -- Should be after mappings to overwrite the trigger key ('tab').
    after = {'which-key.nvim', 'tinykeymap_vim'}
  });

  -- * Theme.
  use({ 'morhetz/gruvbox' });
  use({ 'sainnhe/gruvbox-material' });
  use({ 'vim-airline/vim-airline-themes' });
  -- - Helpers for creating a theme.
  use({ 'tjdevries/colorbuddy.nvim' });

  -- * Highlighting.
  -- - Colors.
  use({
    'norcalli/nvim-colorizer.lua',
    config = [[ require ('config.colorizer') ]]
  });
  -- - Hide cursorline during moving, highlight words under cursor.
  use({ 'yamatsum/nvim-cursorline' });
  -- - Brackets.
  use({
    'p00f/nvim-ts-rainbow',
    event = 'BufEnter',
  });

  -- - Indents.
    use({
      'lukas-reineke/indent-blankline.nvim',
      event = 'VimEnter',
      -- Uses treesitter to calculate indentation when possible.
      after = 'nvim-treesitter',
      config = [[ require('config.indent_blankline') ]],
    });
  -- * Icons. (!) Should be loaded last (after nerd-tree, airline, etc...).
  --   Nerd patched fonts required.
  use({ 'ryanoasis/vim-devicons' });

    -- - Documentation generation.
    use({
      'danymat/neogen',
      config = [[ require('config.neogen') ]],
      requires = 'nvim-treesitter/nvim-treesitter',
      -- Uncomment next line if you want to follow only stable versions.
      -- tag = "*",
    });

    -- Python indent (follows the PEP8 style)
    --use({ 'Vimjas/vim-python-pep8-indent', ft = { 'python' } })

    -- Python-related text object
    --use({ 'jeetsukumaran/vim-pythonsense', ft = { 'python' } })

    --use({'machakann/vim-swap', event = 'VimEnter'})

    -- Super fast buffer jump
    --use {
      --'phaazon/hop.nvim',
      --event = 'VimEnter',
      --config = function()
        --vim.defer_fn(function() require('config.nvim_hop') end, 2000)
      --end
    --}

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

    -- A list of colorscheme plugin you may want to try. Find what suits you.
    --use({'lifepillar/vim-gruvbox8', opt = true})
    --use({'navarasu/onedark.nvim', opt = true})
    --use({'sainnhe/edge', opt = true})
    --use({'sainnhe/sonokai', opt = true})
    --use({'sainnhe/gruvbox-material', opt = true})
    --use({'shaunsingh/nord.nvim', opt = true})
    --use({'NTBBloodbath/doom-one.nvim', opt = true})
    --use({'sainnhe/everforest', opt = true})
    --use({'EdenEast/nightfox.nvim', opt = true})
    --use({'rebelot/kanagawa.nvim', opt = true})

    -- Show git change (change, delete, add) signs in vim sign column
    --use({'mhinz/vim-signify', event = 'BufEnter'})
    -- Another similar plugin
    -- use 'airblade/vim-gitgutter'

    --use {'kyazdani42/nvim-web-devicons', event = 'VimEnter'}

    --use {
      --'nvim-lualine/lualine.nvim',
      --event = 'VimEnter',
      --config = [[require('config.statusline')]]
    --}

    --use({ 'akinsho/bufferline.nvim', event = 'VimEnter', config = [[require('config.bufferline')]] })

    -- Highlight URLs inside vim
    --use({'itchyny/vim-highlighturl', event = 'VimEnter'})

    -- notification plugin
    --use({
      --'rcarriga/nvim-notify',
      --event = 'BufEnter',
      --config = function()
        --vim.defer_fn(function() require('config.nvim-notify') end, 2000)
      --end
    --})

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

    -- Session management plugin
    --use({'tpope/vim-obsession', cmd = 'Obsession'})

    --if vim.g.is_linux then
      --use({'ojroques/vim-oscyank', cmd = {'OSCYank', 'OSCYankReg'}})
    --end

    -- The missing auto-completion for cmdline!
    --use({'gelguy/wilder.nvim', opt = true, setup = [[vim.cmd('packadd wilder.nvim')]]})

    -- show and trim trailing whitespaces
    --use {'jdhao/whitespace.nvim', event = 'VimEnter'}
  end,
  config = {
    max_jobs = 16,
    compile_path = util.join_paths(vim.fn.stdpath('config'), 'lua', 'packer_compiled.lua'),
    git = {
      default_url_format = plug_url_format,
    },
  },
})

local status, _ = pcall(require, 'packer_compiled')
if not status then
  vim.notify('Error requiring packer_compiled.lua: run PackerSync to fix!')
end
