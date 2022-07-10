local NUMBER_OF_PARTS_TO_SHOW = 3;

--- Formats buffername (or directory name) until it has specified number parts
--    left (Part is a string between slashes: /part/part2 ).
-- @param buf_name - buffername (or directory name) to format.
-- @param number_of_parts_to_show
-- @return formatted buffername (or directory name).
local function format_buf_name(buf_name, number_of_parts_to_show)
  if buf_name == '' then
    return '[No Name]'
  end

  -- Don't get empty string into table (first part before first slash:
  --   ''/'mnt'/'e').
  local path_parts = vim.split(buf_name, '/', { trimempty=true });
  local number_of_parts = #path_parts;
  local shortened_buf_name = '';
  local ending_number_of_part = math.max(number_of_parts - number_of_parts_to_show + 1, 1);

  for number_of_part = number_of_parts, ending_number_of_part, -1 do
    local path_part = path_parts[number_of_part];
    if number_of_part == number_of_parts then
      shortened_buf_name = path_part;
    else
      shortened_buf_name = path_part .. '/' .. shortened_buf_name;
    end
  end
  -- We had all parts covered so let's place slash back.
  if ending_number_of_part == 1 then
    shortened_buf_name = '/' .. shortened_buf_name;
  end
  return shortened_buf_name;
end

return require('utils').fp(
  {
    {'buf_name'},
    {'number_of_parts_to_show', NUMBER_OF_PARTS_TO_SHOW },
  },
  format_buf_name
);
