local M = {}

M.on_attach_fn = function(client, bufnr)
	local set_keymap = vim.keymap.set
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	local lsp = vim.lsp
	local opts = { buffer = bufnr, remap = false }
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({
			group = augroup,
			buffer = bufnr,
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})

		set_keymap("n", "gd", function()
			lsp.buf.definition()
		end, opts)
		set_keymap("n", "K", function()
			lsp.buf.hover()
		end, opts)
		set_keymap("n", "<leader>vws", function()
			lsp.buf.workspace_symbol()
		end, opts)
		set_keymap("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		set_keymap("n", "<leader>vca", function()
			lsp.buf.code_action()
		end, opts)
		set_keymap("n", "<leader>vrr", function()
			lsp.buf.references()
		end, opts)
		set_keymap("n", "<leader>vrn", function()
			lsp.buf.rename()
		end, opts)
		set_keymap("n", "<C-h>", function()
			lsp.buf.signature_help()
		end, opts)
	end
end

return M
