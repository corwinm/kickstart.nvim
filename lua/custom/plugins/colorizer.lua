return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  opt = {},
  config = function()
    require('colorizer').setup()
  end,
}
