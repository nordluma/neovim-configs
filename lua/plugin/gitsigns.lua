return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "➤" },
			topdelete = { text = "➤" },
			changedelete = { text = "▎" },
		},
		signs_staged = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signs_staged_enable = true,
		numhl = true,
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")
			local set_keymap = function(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			set_keymap("n", "<leader>hb", function()
				gitsigns.blame_line({ full = true })
			end)

			set_keymap("n", "<leader>tb", gitsigns.toggle_current_line_blame)
		end,
	},
}
