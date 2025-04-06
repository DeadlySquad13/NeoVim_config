return {   -- paste an image from the clipboard or drag-and-drop
  'HakonHarnes/img-clip.nvim',
  event = 'BufEnter',
  ft = { 'markdown', 'quarto', 'latex' },
  opts = {
    default = {
      dir_path = 'img',
    },
    filetypes = {
      markdown = {
        url_encode_path = true,
        template = '![$CURSOR]($FILE_PATH)',
        drag_and_drop = {
          download_images = false,
        },
      },
      quarto = {
        url_encode_path = true,
        template = '![$CURSOR]($FILE_PATH)',
        drag_and_drop = {
          download_images = false,
        },
      },
    },
  },
}
