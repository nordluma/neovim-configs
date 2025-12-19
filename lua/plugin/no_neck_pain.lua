return {
	{
		"shortcuts/no-neck-pain.nvim",
		cmd = "NoNeckPain",
		keys = {
			{ "<leader>zz", "<CMD>NoNeckPain<CR>", desc = "Toggle NoNeckPain" },
		},
		opts = {
			-- width = 110,
			buffers = {
				scratchPad = {
					enabled = true,
					location = "~/notes/scratch-pad/",
				},
				bo = {
					filetype = "md",
				},
				wo = {
					fillchars = "eob: ",
				},
			},
		},
	},
}
