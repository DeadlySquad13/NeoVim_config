---@type LazySpec
return {
  {
    enabled = not require('ds_omega.utils.os').is("Windows_NT"),
    "huantrinh1802/m_taskwarrior_d.nvim",
  },
}
