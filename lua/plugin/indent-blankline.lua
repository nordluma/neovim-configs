return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = "VeryLazy",
	opts = {
		enabled = true,
		whitespace = { highlight = { "Whitespace", "NonText" } },
		scope = {
			enabled = false,
		},
		indent = {
			char = "▏",
		},
	},
}
