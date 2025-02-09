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
        cleanup_delay_ms = 2000,
        lsp_file_methods = {
          enabled = true,
          timeout = 1000,
          autosave_changes = true,
        },
      }

      -- Open parent directory in current window with preview
      vim.keymap.set('n', '-', '<CMD>Oil --preview<CR>', { desc = 'Open parent directory' })

      -- Open parent directory in floating window
      vim.keymap.set('n', '<leader>-', require('oil').toggle_float, { desc = 'Open parent directory - float' })

      -- Enable and disable auto-save when opening and leaving oil or scratch buffers
      vim.api.nvim_create_autocmd({ 'BufEnter' }, {
        callback = function()
          if vim.bo.buftype == 'nofile' or vim.fn.expand('%:p'):match 'oil://' then
            require('auto-save').off()
          end
        end,
      })
      vim.api.nvim_create_autocmd({ 'BufLeave' }, {
        callback = function()
          if vim.bo.buftype == 'nofile' or vim.fn.expand('%:p'):match 'oil://' then
            require('auto-save').on()
          end
        end,
      })
    end,
  },
}
