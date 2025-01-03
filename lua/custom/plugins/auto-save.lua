return {
  'Pocco81/auto-save.nvim',
  opts = {},
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>n', ':ASToggle<CR>', { desc = 'Toggle AutoSave' })
  end,
}
