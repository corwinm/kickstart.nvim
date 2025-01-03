return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  config = function()
    local harpoon = require 'harpoon'

    -- auto-save and harpoon list don't get along
    harpoon:extend {
      UI_CREATE = function()
        require('auto-save').off()
      end,
      SELECT = function()
        require('auto-save').on()
      end,
    }

    vim.keymap.set('n', '<leader>oa', function()
      harpoon:list():append()
    end, { desc = 'Harp[o]on [a]ppend' })
    vim.keymap.set('n', '<leader>ol', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harp[o]on [l]ist' })

    vim.keymap.set('n', '<C-1>', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', '<C-2>', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', '<C-3>', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', '<C-4>', function()
      harpoon:list():select(4)
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<leader>op', function()
      harpoon:list():prev()
    end, { desc = 'Harp[o]on [p]revious' })
    vim.keymap.set('n', '<leader>on', function()
      harpoon:list():next()
    end, { desc = 'Harp[o]on [n]ext' })
  end,
}
