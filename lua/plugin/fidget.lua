return {
	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				filter = vim.log.levels.INFO,
				window = {
					normal_hl = "Comment",
					winblend = 0,
					border = "none",
					x_padding = 0,
				},
			},
		},
	},
}
