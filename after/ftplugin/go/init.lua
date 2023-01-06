local apply_bufferlocal_keymappings = require('config.which_key.utils').apply_bufferlocal_keymappings

---  Created this function to use go command in correct directory (directory of
-- the file) without cwd in vim.
---@param cmd (table<string>|string) command to execute.
local function execute_for_current_file(cmd)
  local t = vim.fn.jobstart(
    cmd,
    {
      cwd = vim.fn.expand('%:h'),
      on_stdout = function(_, data, _)
        if type(data) ~= 'table' then
          return
        end

        if not vim.tbl_isempty(data) then -- We have at least something in the data.
          table.remove(data) -- Removing empty line at the end which represents final newline.

          local message = table.concat(data, '\n')
          ---  Unfortunately, sometimes this callback is called twice.
          -- The second output is always empty.
          --   FIX: Because of this `if` false negatives can arise when the
          --   command was executed and returned nothing.
          if message == '' then
            return
          end

          notify(message)
        end
      end,
    }
  )
end

apply_bufferlocal_keymappings('n', {
  ['<Cr>'] = { function ()
    execute_for_current_file({ 'go', 'run', '.' })
  end, 'Run current project' },
})
