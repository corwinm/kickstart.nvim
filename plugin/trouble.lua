local gh = require('utils').gh
local registerKeymaps = require('utils').registerKeymaps

vim.pack.add {
  { src = gh 'folke/trouble.nvim', cmd = 'Trouble' },
}

vim.api.nvim_create_user_command('Trouble', function(opts)
  vim.cmd.packadd 'trouble.nvim'
  require('trouble').setup {}

  -- forward the original command args to Trouble after loading
  local args = opts.args ~= '' and (' ' .. opts.args) or ''
  vim.cmd('Trouble' .. args)
end, {
  nargs = '*',
  complete = function() return { 'diagnostics', 'symbols', 'lsp', 'loclist', 'qflist' } end,
})

registerKeymaps {
  {
    '<leader>xx',
    '<cmd>Trouble diagnostics toggle<cr>',
    desc = 'Diagnostics (Trouble)',
  },
  {
    '<leader>xX',
    '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
    desc = 'Buffer Diagnostics (Trouble)',
  },
  {
    '<leader>cs',
    '<cmd>Trouble symbols toggle focus=false<cr>',
    desc = 'Symbols (Trouble)',
  },
  {
    '<leader>cl',
    '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
    desc = 'LSP Definitions / references / ... (Trouble)',
  },
  {
    '<leader>xL',
    '<cmd>Trouble loclist toggle<cr>',
    desc = 'Location List (Trouble)',
  },
  {
    '<leader>xQ',
    '<cmd>Trouble qflist toggle<cr>',
    desc = 'Quickfix List (Trouble)',
  },
}
