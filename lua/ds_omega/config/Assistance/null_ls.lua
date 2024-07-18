return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },

  opts = function()
    local prequire = require('ds_omega.utils').prequire

    local null_ls_is_available, null_ls = prequire('null-ls')

    if not null_ls_is_available then
      return
    end

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions
    --local completion = null_ls.builtins.completion;

    -- Unfortunately, null-ls uses log, not notify, for pretty notify we have to do
    --   it manually.
    --   @see [generators source
    --   file](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/generators.lua)
    return {
      -- Lua.
      -- formatting.stylua,

      -- General.
      -- see [misspell](https://github.com/client9/misspell).
      -- diagnostics.misspell,
      -- formatting.jq,
      formatting.fixjson,

      -- Markdown.
      formatting.markdown_toc,

      -- Typescript.
      formatting.prettierd,
      -- - Frontend.
      formatting.stylelint,
      diagnostics.stylelint,

      -- Python.
      formatting.black,
      formatting.isort,
      diagnostics.flake8,
      diagnostics.mypy,

      -- Nix.
      code_actions.statix,
      diagnostics.statix,
      formatting.alejandra,
    }
  end,

  config = function(_, opts)
    local prequire = require('ds_omega.utils').prequire

    local null_ls_is_available, null_ls = prequire('null-ls')

    if not null_ls_is_available then
      return
    end

    local sources = opts

    local function notify_that_source_is_not_executable(source)
      local program_name = source._opts.command

      local NullLs = require('ds_omega.utils').create_augroup('NullLs__'..program_name, { clear = true })

      require('ds_omega.utils').create_autocmd({ 'FileType' }, {
        group = NullLs,
        desc = 'Notify that program of source is not executable.',

        pattern = source.filetypes,

        callback = function()
          local message = 'Program "' .. program_name .. '" is not executable! Make sure it\'s installed and in your $PATH.'

          if LOG_INTO.notify then
            notify(message, {
                title = 'NullLs',
                timeout = 1000,
              }
            )
          end

          log('NullLs')(message)
        end,

        once = true,
      })
    end


    ---  Adds a message to the unavailable sources.
    ---@param sources 
    ---@return 
    local function process_set_sources(sources)
      local available_sources = {}

      for _, source in ipairs(sources) do
        local program_name = source._opts.command

        if vim.fn.executable(program_name) == 1 then
          table.insert(available_sources, source)
        else
          notify_that_source_is_not_executable(source)
        end
      end

      return available_sources
    end

    --@see [config options](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/CONFIG.md).
    null_ls.setup({
      sources = process_set_sources(sources),
    })
  end
}
