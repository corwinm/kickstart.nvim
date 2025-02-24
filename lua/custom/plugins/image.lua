return {
  '3rd/image.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'luarocks.nvim',
  },
  opts = {
    backend = 'kitty',
    processor = 'magick_cli',
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = true,
        filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
        resolve_image_path = function(document_path, image_path, fallback)
          -- Format image path for Obsidian notes
          local notes_dir = vim.fn.expand(vim.env.NOTES_ASSETS_DIR)
          local new_image_path = notes_dir .. '/' .. image_path
          if vim.fn.filereadable(new_image_path) then
            return new_image_path
          end
          return fallback(document_path, image_path)
        end,
      },
    },
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = nil,
    max_height_window_percentage = 50,
    kitty_method = 'normal',
  },
  keys = {
    {
      '<leader>ic',
      function()
        require('image').clear()
      end,
      desc = 'Clear Image',
    },
  },
}
