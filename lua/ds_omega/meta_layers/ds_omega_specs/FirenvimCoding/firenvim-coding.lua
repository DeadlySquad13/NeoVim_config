return require('ds_omega.ds_omega_utils.ds_omega_layer_specs').init(
    {
        { import = 'Assistance' },
        { import = 'Architecturing' },
        { import = 'Commands' },
        { import = 'Completion' },
        { import = 'Editing' },
        { import = 'EditorManagement' },
        { import = 'Highlighting' },
        { import = 'Integrations.firenvim' },
        { import = 'Lsp', },
        { import = 'Snippets' },
        { import = 'SearchAndReplace' },
        { import = 'Navigation' },
        { import = 'NeovimDevelopment.debuglog' },
        { import = 'TextObjects' },
        { import = 'Ui' }, -- TODO: Need to filter.
        { import = 'Workspace__QuickfixList' },
        { import = 'Markdown' },
        { import = 'Orgmode' },
        { import = 'Writing' },
    }
)
