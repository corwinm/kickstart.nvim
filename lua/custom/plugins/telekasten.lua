return {
  'renerocksai/telekasten.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  disable = true,
  config = function()
    require('telekasten').setup {
      home = vim.fn.expand '~/notes',
      auto_set_filetype = false,
      template_new_note = vim.fn.expand '~/.config/nvim/lua/custom/plugins/telekasten/new-note.md',
    }
    vim.treesitter.language.register('markdown', 'telekasten')
    -- Launch panel if nothing is typed after <leader>z
    vim.keymap.set('n', '<leader>,,', '<cmd>Telekasten panel<CR>')

    -- Most used functions
    vim.keymap.set('n', '<leader>,f', '<cmd>Telekasten find_notes<CR>')
    vim.keymap.set('n', '<leader>,g', '<cmd>Telekasten search_notes<CR>')
    vim.keymap.set('n', '<leader>,d', '<cmd>Telekasten goto_today<CR>')
    vim.keymap.set('n', '<leader>,z', '<cmd>Telekasten follow_link<CR>')
    vim.keymap.set('n', '<leader>,n', '<cmd>Telekasten new_note<CR>')
    vim.keymap.set('n', '<leader>,c', '<cmd>Telekasten show_calendar<CR>')
    vim.keymap.set('n', '<leader>,b', '<cmd>Telekasten show_backlinks<CR>')
    vim.keymap.set('n', '<leader>,I', '<cmd>Telekasten insert_img_link<CR>')
    vim.keymap.set('n', '<leader>,t', ':Telekasten toggle_todo<CR>')
    vim.keymap.set('v', '<leader>,t', function()
      require('telekasten').toggle_todo { v = true }
    end)

    -- Call insert link automatically when we start typing a link
    vim.keymap.set('i', '[[', '<cmd>Telekasten insert_link<CR>')
  end,
}
