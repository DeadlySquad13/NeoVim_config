-- Git command.
local function gcmd(command)
  return string.format('<Cmd>G %s<Cr>', command)
end

return {
  n = { 
    ['<Leader>g'] = {
      c = { gcmd 'commit', 'Commit' },
    },
  }
}
