vim.g.XkbSwitchEnabled = 1
if require('ds_omega.utils').os.is('Windows_NT') then
  vim.g.XkbSwitchLib = [[С:\ProgramData\XkbSwitch\bin\libxkbswitch64.dll]]
end
