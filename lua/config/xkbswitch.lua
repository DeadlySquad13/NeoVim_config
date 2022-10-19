vim.g.XkbSwitchEnabled = 1
if require('utils').os.is('Windows_NT') then
  vim.g.XkbSwitchLib = [[С:\ProgramData\XkbSwitch\bin\libxkbswitch64.dll]]
end
