return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require('refactoring').setup({
      prompt_func_return_type = {
        go = false,
        java = false,

        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      prompt_func_param_type = {
        go = false,
        java = false,

        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      printf_statements = {},
      print_var_statements = {},
      show_success_message = false, -- shows a message with information about the refactor on success
      -- i.e. [Refactor] Inlined 3 variable occurrences
    })

    vim.keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "[R]efactor [E]xtract" })
    vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ", { desc = "[R]refactor extract to [F]ile" })

    vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ", { desc = "[R]efactor extract [V]ar" })

    vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var", { desc = "[R]efactor [I]nline var" })

    vim.keymap.set("n", "<leader>rI", ":Refactor inline_func", { desc = "[R]efactor in[L]ine func" })

    vim.keymap.set("n", "<leader>rb", ":Refactor extract_block", { desc = "[R]efactor [b]lock" })
    vim.keymap.set("n", "<leader>rB", ":Refactor extract_block_to_file", { desc = "[R]efactor [B]lock to file" })
  end,
}
