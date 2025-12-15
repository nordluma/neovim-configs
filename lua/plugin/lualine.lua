local lazy = require("lazy.status")
local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		opts = {
			--theme = 'palenight',
			-- options = { theme = "tokyonight-night" },
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					{ "diff", source = diff_source },
					{ "diagnostics", sources = { "nvim_workspace_diagnostic" } },
				},
				lualine_c = { { "filename", file_status = true, path = 1 } },
				lualine_x = {
					{ lazy.updates, cond = lazy.has_updates, color = { fg = "#ff9e64" } },
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress", "selectioncount", "location" },
				lualine_z = {
					{ "lsp_status", ignore_lsp = { "typos_lsp", "emmet_language_server" } },
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = { { "filename", file_status = true, path = 0 } },
				lualine_c = {},
				lualine_x = {},
				lualine_y = { "location" },
				lualine_z = {},
			},
		},
	},
}
