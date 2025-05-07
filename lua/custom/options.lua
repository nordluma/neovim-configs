-- Set Linenumbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Clipboard
vim.api.Clipboard = "xclip"

-- Formatting
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.tw = 80

-- Backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Highlighting
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes:2"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Tabs (fallback)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- autocommand groups for different indententation sizes
local indent_config = {
	space2 = {
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"json",
		"html",
		"css",
		"vim",
		"yaml",
		"elixir",
		"lua",
		"ocaml",
	},

	space4 = {
		"python",
		"rust",
		"c",
		"cpp",
		"go",
	},

	tab = {
		"make",
		"gitconfig",
	},
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = indent_config.space2,
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = indent_config.space4,
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.expandtab = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = indent_config.tab,
	callback = function()
		vim.opt_local.shiftwidth = 8
		vim.opt_local.tabstop = 8
		vim.opt_local.softtabstop = 8
		vim.opt_local.expandtab = false
	end,
})

-- diagnostic virtual lines (toggle)

local diagnostic_signs = {
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "E",
			[vim.diagnostic.severity.WARN] = "W",
			[vim.diagnostic.severity.HINT] = "H",
			[vim.diagnostic.severity.INFO] = "I",
		},
	},
}

local diagnostic_virtual_lines_on = {
	diagnostic_signs,
	virtual_text = {
		severity = {
			max = vim.diagnostic.severity.WARN,
		},
	},
	virtual_lines = {
		severity = {
			min = vim.diagnostic.severity.ERROR,
		},
	},
}

local diagnostic_virtual_lines_off = {
	diagnostic_signs,
	virtual_text = true,
	virtual_lines = false,
}

-- enable virtual lines by default
vim.diagnostic.config(diagnostic_virtual_lines_on)

local virtual_lines_off = false
vim.keymap.set("n", "gK", function()
	virtual_lines_off = not virtual_lines_off
	if virtual_lines_off then
		vim.diagnostic.config(diagnostic_virtual_lines_off)
	else
		vim.diagnostic.config(diagnostic_virtual_lines_on)
	end
end, { desc = "Toggle diagnostic virtual lines" })
