local utils = require 'utils'
local gh = utils.gh
local pack_command = utils.pack_command

vim.pack.add({ gh 'sindrets/diffview.nvim' }, { load = false })

pack_command({ src = gh 'NeogitOrg/neogit' }, 'Neogit', {
  command_opts = { nargs = '*' },
  setup = function()
    vim.cmd.packadd 'diffview.nvim'
  end,
})

vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<cr>', { desc = 'Open Neogit UI' })
