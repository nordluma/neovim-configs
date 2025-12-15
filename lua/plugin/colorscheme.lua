return {
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = {
					"tokyonight",
					"kanagawa-paper",
					"kanagawa-wave",
					"kanagawa-dragon",
					"evangelion",
					"nvimgelion",
				},
				livePreview = true,
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		opts = {
			style = "night",
			light_style = "storm",
			transparent = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
			},
			sidebars = { "qf", "help" },
			day_brightness = 0.3,
			hide_inactive_statusline = false,
			dim_inactive = false,
			lualine_bold = false,
		},
	},
	{
		"thesimonho/kanagawa-paper.nvim",
		priority = 1000,
		opts = { transparent = true },
	},
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		opts = { transparent = true, colors = { theme = { all = { ui = { bg_gutter = "none" } } } } },
	},
	{
		"nyngwang/nvimgelion",
		priority = 1000,
		config = function()
			vim.cmd([[ hi Normal guibg=NONE ]])
		end,
	},
	{
		"xero/evangelion.nvim",
		priority = 1000,
		opts = { transparent = true },
	},
	-- {
	-- 	dir = "~/dev/lua/evangelion.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("evangelion").setup({
	-- 			transparent = true,
	-- 		})
	-- 	end,
	-- },
}
