if require('utils').os.is('Windows_NT') then
  -- Set it if executable `python3` is not available.
  vim.g._jukit_python_os_cmd = 'python'
end

