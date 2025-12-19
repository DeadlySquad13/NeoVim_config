---@type LazySpec
return {
    dir = require('ds_omega.constants.env').NVIM_MODULES .. "/rename/mini_files_rename",

    dependencies = { 'echasnovski/mini.files' },

    -- INFO: "No lua module found" so requires explicit config with setup instead of `config = true`.
    -- Maybe we're lacking some meta fields in module.
    config = function ()
        local mini_files_rename_is_available = prequire('ds_omega.modules.rename.mini_files_rename')

        if not mini_files_rename_is_available then
          return
        end

        local mini_files_rename = require('ds_omega.modules.rename.mini_files_rename')
        mini_files_rename.setup()
    end
}
