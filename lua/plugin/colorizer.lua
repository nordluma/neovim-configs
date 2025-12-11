return {
	"norcalli/nvim-colorizer.lua",
	event = "VeryLazy",
	opts = {
		"*",
		"!vim",
		css = { rgb_fn = true },
		html = { names = false },
	},
}
