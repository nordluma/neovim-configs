return {
  "norcalli/nvim-colorizer.lua",
  event = "VeryLazy",
  config = function()
    require("colorizer").setup({
      "*",
      css = { rgb_fn = true },
      html = { names = false }
    })
  end
}
