return {
  {
    "rcarriga/nvim-notify",
    enable = false,
    lazy = false,
    config = function()
      require("notify").setup({})
    end
  }
}
