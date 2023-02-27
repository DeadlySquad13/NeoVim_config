local simple_plugin_setup = require('ds_omega.utils').simple_plugin_setup

local cmp_is_available, cmp = simple_plugin_setup('cmp', 'Completion')

if not cmp_is_available then
  return
end

-- * Enabling support for autopairs.
-- * If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done({ map_char = { tex = '' } })
)

-- ? Is it used only for lisp?.
-- * Add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure",
--"clojurescript", "fennel", "janet" }
--cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"

-- Unfortunately, `= true` wasn't working.
local autocomplete_on_every_stroke = {
  --require('cmp.types').cmp.TriggerEvent.InsertEnter,
  require('cmp.types').cmp.TriggerEvent.TextChanged,
}

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  autocomplete = autocomplete_on_every_stroke,
  sources = {
    { name = 'buffer', option = { keyword_pattern = [=[[^[:blank:]].*]=] } },
  },
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  completion = {
    autocomplete = autocomplete_on_every_stroke,
  },
  sources = cmp.config.sources({
    { name = 'path', keyword_length = 2 },
  }, {
    -- Don't show autocomplete on things like `:w`.
    { name = 'cmdline', keyword_length = 2 },
  }),

  performance = {
    debounce = 300,
    throttle = 60,
    fetching_timeout = 200,
  }
})
