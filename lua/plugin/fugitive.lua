return {
  {
    'tpope/vim-fugitive',
    --event = 'VeryLazy',
    keys = {
      { "<leader>gs", mode = "n", desc = "Toggle Fugitive" }
    },
    cmd = "Git",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end
  },
}
