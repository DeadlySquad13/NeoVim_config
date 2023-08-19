local function escape(str)
  -- You need to escape these characters to work correctly
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

-- Modified mappings for `.` and `,` because they were mapping even when hdn
-- was selected leading to confusion.
local ru =                   [[ёйцукенгшщзхъфывапролджэ\\ячсмитьбю./]]
local en =                   [[`qwertyuiop[]asdfghjkl;'\\zxcvbnm,.//]]
local hands_down_neu =       [[`wfmpv/.q"'z(rsntg,aeihj)\xcldb-uoy./]]

local ru_shift =             [[ЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭ//ЯЧСМИТЬБЮ,/]]
local en_shift =             [[~QWERTYUIOP{}ASDFGHJKL:"||ZXCVBNM<>?/]]
local hands_down_neu_shift = [[~WFMPV*:Q[]Z{RSNTG;AEIHJ}|XCLDB+UOY,/]]

return {
    layouts = {
        ru = ru,
        en = en,
        hands_down_neu = hands_down_neu,

        ru_shift = ru_shift,
        en_shift = en_shift,
        hands_down_neu_shift = hands_down_neu_shift,
    },

    langmap = {
      to_en = vim.fn.join({
        -- | `to` should be first     | `from` should be second
        escape(ru_shift) .. ';' .. escape(en_shift),
        escape(ru) .. ';' .. escape(en),
        escape(hands_down_neu_shift) .. ';' .. escape(en_shift),
        escape(hands_down_neu) .. ';' .. escape(en),
      }, ','),

      to_hands_down_neu = vim.fn.join({
        -- | `to` should be first     | `from` should be second
        escape(ru_shift) .. ';' .. escape(hands_down_neu_shift),
        escape(ru) .. ';' .. escape(hands_down_neu),
      }, ','),
    }
}

