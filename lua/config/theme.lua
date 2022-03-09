local Color, colors, Group, groups, styles = require('colorbuddy').setup()

-- Colors.
local color_palette = {
  red = {
    crimson = '#9d0006',
    engine = '#cc241d',
    venetian = '#fb4934',
  },

  mustard = {
    bronze = '#79740e',
    citron = '#98971a',
    acid = '#b8bb26',
  },

  yellow = {
    philippine_gold = '#b57614',
    goldenrod = '#d79921',
    saffron = '#fabd2f',
  },

  blue = {
    sapphire = '#076678',
    jelly_bean = '#458588',
    morning = '#83a598',
  },

  purple = {
    twilight_lavender = '#8f3f71',
    turkish_rose = '#b16286',
    puce = '#d3869b',
  },

  aquamarine = {
    amazon = '#427b58',
    russian = '#689d6a',
    pistachio = '#8ec07c',
  },

  orange = {
    rust = '#af3a03',
    metallic = '#d65d0e',
    pumpkin = '#fe8019',
  },

  white = {
    white0 = '#f9f5d7',
    white1 = '#fbf1c7',
    white2 = '#f2e5bc',
    tan = '#e0d0a8',
  },

  gray = {
    gray0 = '#ebdbb2',
    gray1 = '#d5c4a1',
    gray2 = '#bdae93',
    gray3 = '#a89984',
    gray4 = '#928374',
  },

  black = {
    black0 = '#7c6f64',
    black1 = '#665c54',
    black2 = '#504945',
    black3 = '#3c3836',
    black5 = '#32302f',
    black6 = '#282828',
    black7 = '#1d2021',
  },
}

-- Semantic colors.
local semantic_palette = {
  informational1 = color_palette.gray.gray1,
  inconspicious0 = color_palette.white.white1
}

-- Scope colors.
Color.new('fold_foreground', semantic_palette.informational1)
Color.new('fold_background', semantic_palette.inconspicious0)

-- Scope groups.
Group.new('FoldColumn', colors.fold_foreground, colors.fold_background)
-- hi FoldColumn guibg=test guifg=Black

-- Define highlights in terms of `colors` and `groups`
-- Group.new('Function'        , colors.yellow      , colors.background , styles.bold)
--  Group.new('luaFunctionCall' , groups.Function    , groups.Function   , groups.Function)

-- Define highlights in relative terms of other colors
--  Group.new('Error'           , colors.red:light() , nil               , styles.bold)
