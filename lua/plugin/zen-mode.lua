return {
  {
    'folke/zen-mode.nvim',
    lazy = false,
    config = function()
      vim.keymap.set("n", "<leader>zz", function()
        require("zen-mode").setup {
          window = {
            width = 110,
            options = {}
          },
        }

        require("zen-mode").toggle()
        vim.wo.wrap = false
        vim.wo.number = true
        vim.wo.rnu = true
      end)
    end
  },
}
