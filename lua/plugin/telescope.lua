return {
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		event = "VeryLazy",
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {},
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("rest")

			local set_keymap = vim.keymap.set
			local builtin = require("telescope.builtin")
			set_keymap("n", "<leader>pf", builtin.find_files, {})
			set_keymap("n", "<leader>gf", builtin.git_files, {})
			set_keymap("n", "<leader>pd", builtin.diagnostics, {})
			set_keymap("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end)
			set_keymap("n", "<leader>fh", builtin.help_tags, {})
			set_keymap("n", "<leader>jvp", function()
				local opts = require("telescope.themes").get_ivy({
					cwd = vim.fn.stdpath("config"),
				})
				builtin.find_files(opts)
			end)

			set_keymap("n", "<leader>od", function()
				vim.opt_local.splitright = true
				builtin.lsp_definitions({
					jump_type = "vsplit",
				})
			end)
			set_keymap("n", "<leader>wd", function()
				builtin.lsp_document_symbols({ file_encoding = "utf-8" })
			end)

			set_keymap("n", "<leader>re", function()
				require("telescope").extensions.rest.select_env()
			end)
		end,
	},
}
