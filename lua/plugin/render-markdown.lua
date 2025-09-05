return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-wev-devicons",
	},
	lazy = false,
	---@module "render-markdown"
	---@type render.md.UserConfig
	opts = {
		completions = { lsp = { enabled = true } },
	},
}
