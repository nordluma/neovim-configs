return {
  {
    'windwp/nvim-autopairs',
    lazy = false,
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt" },
      })
    end
  }
}
