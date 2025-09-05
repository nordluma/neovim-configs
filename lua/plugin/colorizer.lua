return {
	"norcalli/nvim-colorizer.lua",
	event = "VeryLazy",
	config = function()
		require("colorizer").setup({
			"*",
			"!vim",
			css = { rgb_fn = true },
			html = { names = false },
		})
	end,
}
