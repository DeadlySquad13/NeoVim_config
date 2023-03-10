local prequire = require("utils").prequire

local yop_is_available, yop = prequire("yop")

if not yop_is_available then
  return
end

local function indent(line, str)
  return string.rep(" ", vim.fn.indent(line)) .. str
end
local function substitute(pattern)
  return yop.create_operator(
          function(lines, info)
            --   It seems much easier to maintain variable and function
            -- extraction separately.
            if #lines > 1 then
              print('To much lines for variable declaration')

              return
            end

            local substitute_with = vim.fn.input('Substitute with: ')

            if substitute_with == '' then
              return
            end

            local function declare_variable()
              local variable_declaration = string.format(pattern, substitute_with, lines[1])

              local start_pos = info.position.first[1]
              local above_substituion = start_pos - 1

              local new_lines = { indent(start_pos, variable_declaration) }

              vim.api.nvim_buf_set_lines(0, above_substituion, above_substituion, true, new_lines)
            end

            vim.schedule(declare_variable)

            return { substitute_with }
          end,
          false
      )
end

vim.keymap.set({ "n", "v" }, "<LocalLeader>r", substitute("local %s = %s"), { expr = true })
