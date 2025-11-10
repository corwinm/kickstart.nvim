return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for default `toggle()` implementation.
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
    }

    -- Required for `opts.auto_reload`.
    vim.o.autoread = true

    vim.keymap.set('n', '<leader>ot', function()
      require('opencode').toggle()
    end, { desc = 'Toggle embedded' })
    vim.keymap.set({ 'n', 'v' }, '<leader>oa', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'Ask about this' })
    vim.keymap.set('n', '<leader>o+', function()
      require('opencode').prompt('@buffer', { append = true })
    end, { desc = 'Add buffer to prompt' })
    vim.keymap.set('v', '<leader>o+', function()
      require('opencode').prompt('@this', { append = true })
    end, { desc = 'Add selection to prompt' })
    vim.keymap.set('n', '<leader>oe', function()
      require('opencode').prompt('Explain @this and its context', { submit = true })
    end, { desc = 'Explain this code' })
    vim.keymap.set('n', '<leader>on', function()
      require('opencode').command 'session.new'
    end, { desc = 'New session' })
    vim.keymap.set('n', '<S-C-u>', function()
      require('opencode').command 'session.half.page.up'
    end, { desc = 'Messages half page up' })
    vim.keymap.set('n', '<S-C-d>', function()
      require('opencode').command 'session.half.page.down'
    end, { desc = 'Messages half page down' })
    vim.keymap.set({ 'n', 'v' }, '<leader>oc', function()
      require('opencode').select()
    end, { desc = 'Select prompt' })
    vim.keymap.set('n', '<leader>os', function()
      require('opencode').command 'prompt.submit'
    end, { desc = 'Submit prompt' })
    vim.keymap.set('n', '<leader>oi', function()
      require('opencode').command 'session.interrupt'
    end, { desc = 'Interrupt session' })
  end,
}
