local format_buf_name = require('config.utils').format_buf_name;

--render_props: {
  --buf: number,
  --win: number,
--}
local function render(render_props)
  local win_id = render_props.win;
  local buf_id = render_props.buf;

  local buf_name = vim.api.nvim_buf_get_name(buf_id);

  local win_number = vim.api.nvim_win_get_number(win_id);
  return {
    { win_number, group = 'SpecialKey' },
    { '. ', group = 'Delimiter' },
    { format_buf_name({ buf_name = buf_name }) },
  }
end

return {
  debounce_threshold = {
    falling = 50,
    rising = 10
  },
  hide = {
    cursorline = false,
    focused_win = false,
    only_win = false
  },
  highlight = {
    groups = {
      InclineNormal = {
        default = true,
        group = 'NormalFloat'
      },
      InclineNormalNC = {
        default = true,
        group = 'NormalFloat'
      }
    }
  },
  ignore = {
    buftypes = "special",
    filetypes = {},
    floating_wins = true,
    unlisted_buffers = true,
    wintypes = "special"
  },
  render = render,
  window = {
    margin = {
      horizontal = 1,
      vertical = 1
    },
    options = {
      signcolumn = "no",
      wrap = false
    },
    padding = 1,
    padding_char = " ",
    placement = {
      horizontal = "right",
      vertical = "top"
    },
    width = "fit",
    winhighlight = {
      active = {
        EndOfBuffer = "None",
        Normal = "InclineNormal",
        Search = "None"
      },
      inactive = {
        EndOfBuffer = "None",
        Normal = "InclineNormalNC",
        Search = "None"
      }
    },
    zindex = 50
  }
}
