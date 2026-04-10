vim.pack.add { 'https://github.com/folke/snacks.nvim' }

---@type snacks.Config
local opts = {
  input = {},
  indent = {},
  terminal = {},
  words = {},
  lazygit = {
    -- your lazygit configuration comes here
    -- or leave it empty to use the default settings
  },
  git = {
    -- your git configuration comes here
    -- or leave it empty to use the default settings
  },
  gitbrowse = {
    -- your gitbrowse configuration comes here
    -- or leave it empty to use the default settings
  },
  gh = {
    -- your gh configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  picker = {
    sources = {
      gh_issue = {
        -- your gh_issue picker configuration comes here
        -- or leave it empty to use the default settings
      },
      gh_pr = {
        -- your gh_pr picker configuration comes here
        -- or leave it empty to use the default settings
      },
    },
  },
}

require('snacks').setup(opts)

vim.keymap.set('n', '<leader>lg', function() Snacks.lazygit.open() end, { desc = 'LazyGit' })
vim.keymap.set('n', '<leader>gb', function() Snacks.git.blame_line() end, { desc = 'Git Blame' })
vim.keymap.set('n', '<leader>go', function() Snacks.gitbrowse.open() end, { desc = 'Git Browse' })
vim.keymap.set('n', '<leader>gi', function() Snacks.picker.gh_issue() end, { desc = 'GitHub Issues (open)' })
vim.keymap.set('n', '<leader>gI', function() Snacks.picker.gh_issue { state = 'all' } end, { desc = 'GitHub Issues (all)' })
vim.keymap.set('n', '<leader>gp', function() Snacks.picker.gh_pr() end, { desc = 'GitHub Pull Requests (open)' })
vim.keymap.set('n', '<leader>gP', function() Snacks.picker.gh_pr { state = 'all' } end, { desc = 'GitHub Pull Requests (all)' })
vim.keymap.set({ 'n', 't' }, ']]', function() Snacks.words.jump(vim.v.count1) end, { desc = 'Next Reference' })
vim.keymap.set({ 'n', 't' }, '[[', function() Snacks.words.jump(-vim.v.count1) end, { desc = 'Prev Reference' })
