local genghis = require('genghis')

return {
    n = {
        ["<Leader>"] = {
            -- "yp", genghis.copyFilepath
            -- "yn", genghis.copyFilename
            -- "cx", genghis.chmodx
            f = {
                r = { genghis.renameFile, 'Rename file' },
                m = { genghis.moveAndRenameFile, 'Move file' },
                n = { genghis.createNewFile, 'Create new file' },
                y = { genghis.duplicateFile, 'Copy file' },
                d = {
                    function()
                      genghis.trashFile({
                          -- default: "$HOME/.Trash".
                          -- trashLocation = "your/path",
                      })
                    end,
                    'Delete (trash) file'
                },
            },
            -- "x", genghis.moveSelectionToNewFile
        }
    }
}
