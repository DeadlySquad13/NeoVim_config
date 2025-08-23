return require('ds_omega.ds_omega_utils.ds_omega_layer_specs').init(
    {
        { import = 'Assistance' },
        { import = 'Architecturing' },
        { import = 'Commands' },
        { import = 'Completion' },
        { import = 'Editing' },
        { import = 'EditorManagement' },
        { import = 'Git' },
        { import = 'Highlighting' },
        { import = 'Integrations' },
        { import = 'Notebooks' },
        { import = 'Lsp', },
        { import = 'Snippets' },
        { import = 'SearchAndReplace' },
        { import = 'Testing' },
        { import = 'Navigation' },
        { import = 'Navigation-files' },
        { import = 'NeovimDevelopment' },
        { import = 'ProjectManagement' },
        { import = 'TaskManagement' },
        { import = 'TextObjects' },
        { import = 'Ui' },
        { import = 'WindowManagement' },
        { import = 'Workspace' },
        { import = 'Workspace__QuickfixList' },
        { import = 'Markdown' },
        { import = 'Orgmode' },
        { import = 'Writing' },

        -- # Meta layers.
        -- 'DataCenter' holds plugins and settings that help with realization of
        -- a 'DataCenter' strategy. Similar to 'Integrations' layer but focuses on
        -- goal of gathering information from multiple sources in one place.
        { import = 'DataCenter' },
        -- { import = 'FirenvimPython' },
    }
)
