local config = require('config.Workspace.tpipeline')
local tbl_remove_key = require('utils').tbl_remove_key

local vim_settings = tbl_remove_key(config, 'vim_settings')

local setters = require('utils.setters')

setters.set_global_variables(config)
setters.set_settings(vim_settings)

