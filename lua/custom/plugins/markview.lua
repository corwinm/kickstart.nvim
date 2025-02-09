return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  opts = {
    modes = { 'i', 'n', 'no' },
    hybrid_modes = { 'i' },
  },
  config = function()
    local presets = require 'markview.presets'
    require('markview').setup {
      markdown = {
        headings = presets.headings.glow,
      },
    }
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}
