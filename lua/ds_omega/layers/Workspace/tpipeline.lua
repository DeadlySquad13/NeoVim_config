local config = require('ds_omega.config.Workspace.tpipeline')
local tbl_remove_key = require('ds_omega.utils').tbl_remove_key

local vim_settings = tbl_remove_key(config, 'vim_settings')

local setters = require('ds_omega.utils.setters')

setters.set_global_variables(config)
setters.set_settings(vim_settings)

