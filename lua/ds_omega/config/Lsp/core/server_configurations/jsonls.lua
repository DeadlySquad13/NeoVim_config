local prequire = require('ds_omega.utils').prequire

local schemastore_is_available = prequire('schemastore')

if not schemastore_is_available then
  return {}
end

local schemastore = require('schemastore')

return {
    settings = {
        json = {
            schemas = schemastore.json.schemas(),
            validate = { enable = true },
        },
    },
}
