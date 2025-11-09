return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    input = {},
    indent = {},
    terminal = {},
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
  },
  keys = {
    {
      '<leader>lg',
      function()
        Snacks.lazygit.open()
      end,
      desc = 'LazyGit',
    },
    {
      '<leader>gb',
      function()
        Snacks.git.blame_line()
      end,
      desc = 'Git Blame',
    },
    {
      '<leader>go',
      function()
        Snacks.gitbrowse.open()
      end,
      desc = 'Git Browse',
    },
    {
      '<leader>gi',
      function()
        Snacks.picker.gh_issue()
      end,
      desc = 'GitHub Issues (open)',
    },
    {
      '<leader>gI',
      function()
        Snacks.picker.gh_issue { state = 'all' }
      end,
      desc = 'GitHub Issues (all)',
    },
    {
      '<leader>gp',
      function()
        Snacks.picker.gh_pr()
      end,
      desc = 'GitHub Pull Requests (open)',
    },
    {
      '<leader>gP',
      function()
        Snacks.picker.gh_pr { state = 'all' }
      end,
      desc = 'GitHub Pull Requests (all)',
    },
  },
}
