return {
  'norcalli/nvim-colorizer.lua',

  opts = {
    global = {
      RGB      = true;         -- #RGB hex codes
      RRGGBB   = true;         -- #RRGGBB hex codes
      names    = true;         -- "Name" codes like Blue
      RRGGBBAA = false;        -- #RRGGBBAA hex codes
      rgb_fn   = false;        -- CSS rgb() and rgba() functions
      hsl_fn   = true;        -- CSS hsl() and hsla() functions
      css      = true;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn   = true;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Available modes: foreground, background
      mode     = 'background'; -- Set the display mode.
    },
    filetype = {
    -- Attach to certain Filetypes, add special configuration for `html`
    -- Use `background` for everything else.
    -- require 'colorizer'.setup {
    --   'css';
    --   'javascript';
    --   html = {
    --     mode = 'foreground';
    --   }
    -- }

    -- Use the `default_options` as the second parameter, which uses
    -- `foreground` for every mode. This is the inverse of the previous
    -- setup configuration.
    -- require 'colorizer'.setup({
    --   'css';
    --   'javascript';
    --   html = { mode = 'background' };
    -- }, { mode = 'foreground' })

    -- Use the `default_options` as the second parameter, which uses
    -- `foreground` for every mode. This is the inverse of the previous
    -- setup configuration.
    -- require 'colorizer'.setup {
    --   '*'; -- Highlight all files, but customize some others.
    --   css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
    --   html = { names = false; } -- Disable parsing "names" like Blue or Gray
    -- }

    -- Exclude some filetypes from highlighting by using `!`
    -- require 'colorizer'.setup {
    --   '*'; -- Highlight all files, but customize some others.
    --   '!vim'; -- Exclude vim from highlighting.
    --   -- Exclusion Only makes sense if '*' is specified!
    -- }
    }
  },

  config = function(_, opts)
    local colorizer_is_available, colorizer = prequire('colorizer')

    if not colorizer_is_available then
      return
    end

    colorizer.setup(opts.filetype, opts.global)
  end

}
