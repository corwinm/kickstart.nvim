return {
  'mistricky/codesnap.nvim',
  build = 'make',
  keys = {
    { '<leader>cc', '<cmd>CodeSnap<cr>', mode = 'x', desc = 'Save selected code snapshot into clipboard' },
    { '<leader>cp', '<cmd>CodeSnapSave<cr>', mode = 'x', desc = 'Save selected code snapshot in ~/Pictures' },
    { '<leader>ci', '<cmd>CodeSnapASCII<cr>', mode = 'x', desc = 'Save selected code ASCII snapshot into clipboard' },
  },
  opts = {
    save_path = '~/Pictures',
    has_breadcrumbs = false,
    bg_theme = 'dusk',
    watermark = '',
  },
}
