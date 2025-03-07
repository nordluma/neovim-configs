return {
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    lazy = false,
    config = function()
      require("telescope").setup({
        extensions = {
          fzf = {}
        }
      })
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("rest")

      local set_keymap = vim.keymap.set
      local builtin = require('telescope.builtin')
      set_keymap('n', '<leader>pf', builtin.find_files, {})
      set_keymap('n', '<leader>gf', builtin.git_files, {})
      set_keymap('n', '<leader>pd', builtin.diagnostics, {})
      set_keymap('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end)
      set_keymap('n', '<leader>re', function()
        require("telescope").extensions.rest.select_env()
      end)
    end
  }
}
