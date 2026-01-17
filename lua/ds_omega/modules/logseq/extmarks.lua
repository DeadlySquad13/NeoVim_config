local M = {}
M.log = log('Logseq__Extmarks')

--- @class BlockDataBody
--- @field children table[]
--- @field content string
--- @field format "org"|"md"
--- @field id integer
--- @field left LeftReference
--- @field marker "TODO"|"DOING"|"DONE"|"CANCELLED"
--- @field page PageReference
--- @field parent ParentReference
--- @field pathRefs PathReference[]
--- @field properties PropertiesTable Logseq builtin + custom properties.
--- @field propertiesOrder string[] Keys of PropertiesTable
--- @field propertiesTextValues PropertiesTextValues PropertiesTable but values cast to string
--- @field refs Reference[]
--- @field uuid string

--- @class LeftReference
--- @field id integer

--- @class PageReference
--- @field id integer

--- @class ParentReference
--- @field id integer

--- @class PathReference
--- @field id integer

--- Currently for simplicity just id
--- @class PropertiesTable
--- @field id string

--- @class PropertiesTextValues
--- @field id string

--- @class Reference
--- @field id integer


---@type table<string, BlockDataBody>
M.references_for_current_session = {}

---
---@param reference ReferenceLocation
M.get_reference_from_cache = function(reference)
  return M.references_for_current_session[reference.uuid]
end

---
---@param reference ReferenceLocation
---@param block_data BlockDataBody
-- TODO: Add ttl for each entry to clear them and update from db from time to time.
M.add_reference_to_cache = function(reference, block_data)
  M.references_for_current_session[reference.uuid] = block_data
end

---
---@async
---@param block_ref string,
---@return table|nil response
M.get_block_data = function(block_ref)
  local curl_is_available = prequire('plenary.curl')

  if not curl_is_available then
    return
  end

  local curl = require("plenary.curl")
  local json_body = vim.json.encode({
    method = "logseq.Editor.getBlock",
    args = { block_ref },
  })

  local co = coroutine.running()

  curl.post("http://127.0.0.1:12315/api", {
    body = json_body,
    headers = {
      ["Content-Type"] = "application/json; charset=utf-8",
      ["Accept"] = "application/json",
      ["Authorization"] = "Bearer D0F7360AE36881EB3FF8133BB04C9F8D",
    },
    on_error = function(err)
      vim.schedule(function()
        notify_throttled(err.message, vim.log.levels.ERROR)
        M.log(block_ref, err)
        coroutine.resume(co)
      end)
    end,
    callback = function(response)
      vim.schedule(function()
        coroutine.resume(co, response)
      end)
    end,
  })

  return coroutine.yield()
end

M.LogseqNamespace = vim.api.nvim_create_namespace('Logseq')


---@alias ReferenceLocation { uuid: string, line: number, column: number }

---
---@async
---@param bufnr number Buffer number
---@param reference (ReferenceLocation)
M.set_extmark = function(bufnr, reference)
  local function set_extmark(block_data)
    local virt_text_content = block_data.content

    -- INFO: May render multiline in the future. Note that N last lines may be
    -- proterties, for example:
    -- { "TODO Research [[Nas]]", ":PROPERTIES:", ":id: 68dc49df-104f-47ce-b7b6-6c4117a6198c", ":END:" }
    virt_text_content = vim.split(virt_text_content, "\n", { plain = true })[1]

    return vim.api.nvim_buf_set_extmark(
      bufnr,
      M.LogseqNamespace,
      reference.line,
      reference.column,
      {
        virt_text = { { virt_text_content, "Visual" } },
        virt_text_pos = "overlay",
      }
    )
  end

  ---@type BlockDataBody
  local block_data = M.get_reference_from_cache(reference)

  if block_data then
    set_extmark(block_data)
    return
  end

  local co = coroutine.create(function()
    local block_data_response = M.get_block_data(reference.uuid)

    if not block_data_response then
      M.log("Error: returned empty block_data_response. Something's wrong with fetch mechanism")
      return
    end

    if block_data_response.status == 200 then
      block_data = vim.json.decode(block_data_response.body)

      M.add_reference_to_cache(reference, block_data)
      set_extmark(block_data)
    else
      notify_throttled("Error:", block_data_response.status, block_data_response.body.error, block_data_response.body.message)
      M.log("Error:", block_data_response.status, block_data_response.body.error, block_data_response.body.message)
      return
    end
  end)

  coroutine.resume(co)
end

-- Strict UUID pattern: 8-4-4-4-12 hex digits with hyphens
M.UUID_PATTERN = "%(%((" ..
    "%x%x%x%x%x%x%x%x" .. "%-" ..
    "%x%x%x%x" .. "%-" ..
    "%x%x%x%x" .. "%-" ..
    "%x%x%x%x" .. "%-" ..
    "%x%x%x%x%x%x%x%x%x%x%x%x" ..
    ")%)%)"

--- Parse buffer for valid UUIDs in double parentheses
--- @return ReferenceLocation[]
M.find_uuid_references = function(bufnr)
  local results = {}

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for line_num, line in ipairs(lines) do
    local start_pos, _, uuid = line:find(M.UUID_PATTERN)
    if start_pos then
      table.insert(results, {
        uuid = uuid,
        line = line_num - 1,   -- 0-based line
        column = start_pos - 1 -- 0-based column
      })
    end
  end

  return results
end

--- @param bufnr number? Optional buffer number
M.set_extmark_references = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.api.nvim_buf_clear_namespace(bufnr, M.LogseqNamespace, 0, -1)

  local references = M.find_uuid_references(bufnr)

  for _, reference in ipairs(references) do
    M.set_extmark(bufnr, reference)
  end
end

return M
