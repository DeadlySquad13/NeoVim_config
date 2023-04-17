return {
  'DeadlySquad13/other.nvim',
  branch = 'create-file',

  opts = function()
    local mappings = {}

    local function add_mappings(new_mappings)
      if require('ds_omega.utils.os').is('Windows_NT') then
        for _, mapping in ipairs(new_mappings) do
          mapping.pattern = string.gsub(mapping.pattern, '/', '\\')
        end
      end

      vim.list_extend(mappings, new_mappings)
    end

    -- React.
    add_mappings({
      {
        pattern = "(.*).tsx$",
        target = "%1.pcss",
      },
      {
        pattern = "(.*).pcss$",
        target = "%1.tsx",
      }
    })

    -- Go.
    add_mappings({
      {
        pattern = '(.*).go$',
        target = '%1_test.go',
      },
      {
        pattern = '(.*)_test.go$',
        target = '%1.go',
      },
    })

    -- # Lua.
    -- Between config and layer.
    add_mappings({
      {
        pattern = 'config/(.*)/(.*).lua$',
        target = 'ds_omega/layers/%1/%2.lua',
        context = 'layer',
      },
      {
        pattern = 'ds_omega/layers/(.*)/(.*).lua$',
        target = 'config/%1/%2.lua',
        context = 'config',
      },
      -- From config with nested folder (Like Navigation/auto-save/settings.lua).
      {
        pattern = 'config/(.*)/(.*)/(.*).lua$',
        target = 'ds_omega/layers/%1/%2.lua',
        context = 'layer',
      },
    })

    -- Between init, settings and keymappings.
    local init = {
      target = 'init.lua',
      context = 'init',
    }

    local settings = {
      target = 'settings.lua',
      context = 'settings',
    }

    local keymappings = {
      target = 'keymappings.lua',
      context = 'keymappings',
    }

    add_mappings({
      {
        pattern = 'init.lua$',
        target = {
          settings,
          keymappings,
        },
      },

      {
        pattern = 'settings.lua$',
        target = {
          init,
          keymappings,
        },
      },

      {
        pattern = 'keymappings.lua$',
        target = {
          init,
          settings,
        },
      },
    })

    return {
      create_file_if_missing = false,
      mappings = mappings,
    }
  end,

  config = function(_, opts)
    require('other-nvim').setup(opts)
  end,
}
