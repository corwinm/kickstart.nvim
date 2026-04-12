local gh = require('utils').gh

vim.schedule(function()
  vim.pack.add { gh 'rcarriga/nvim-notify' }
  require('notify').setup {
    background_colour = '#000000',
    top_down = false,
    merge_duplicates = true,
  }
end)
