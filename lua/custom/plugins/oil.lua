return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        columns = { 'icon' },
        keymaps = {
          ['<C-h>'] = false,
          ['<M-h>'] = 'actions.select_split',
        },
        view_options = {
          show_hidden = true,
        },
      }

      -- Open parent directory in current window
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

      -- Open parent directory in floating window
      vim.keymap.set('n', '<leader>-', require('oil').toggle_float, { desc = 'Open parent directory - float' })

      -- Enable and disable auto-save when opening and leaving oil
      vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
        pattern = { 'oil://*' },
        callback = function()
          require('auto-save').off()
        end,
      })
      vim.api.nvim_create_autocmd({ 'BufLeave' }, {
        pattern = { 'oil://*' },
        callback = function()
          require('auto-save').on()
        end,
      })
    end,
  },
}
