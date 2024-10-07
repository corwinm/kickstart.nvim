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
      headings = presets.headings.glow,
      checkboxes = presets.checkboxes.nerd,
    }
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}
