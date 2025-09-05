return {
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- LSP progress
			{ "j-hui/fidget.nvim" },
		},
		config = function()
			local lsp_config = require("lspconfig")
			local lsp_defaults = lsp_config.util.default_config

			lsp_defaults.capabilities =
				vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

			local buffer_autoformat = function(bufnr)
				local group = "lsp_autoformat"
				vim.api.nvim_create_augroup(group, { clear = false })
				vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					group = group,
					callback = function()
						require("conform").format({ bufnr })
					end,
				})
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local lsp = vim.lsp
					local set_keymap = vim.keymap.set
					local opts = { buffer = event.buf, remap = false }

					local id = vim.tbl_get(event, "data", "client_id")
					local client = id and vim.lsp.get_client_by_id(id)
					if client == nil then
						return
					end

					-- make sure there is at least one client with formatting capabilities
					if client:supports_method("textDocument/formatting") then
						buffer_autoformat(event.buf)
					end

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
					set_keymap("n", "<leader>gh", function()
						lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled())
					end)
				end,
			})

			require("mason").setup({})
			require("mason-lspconfig").setup({
				-- handlers = {
				-- 	function(server_name)
				-- 		require("lspconfig")[server_name].setup({
				-- 		capabilities = lsp_defaults.capabilities
				-- 		})
				-- 	end,
				-- },
			})

			-- Ignore TailwindCss unknownAtRules
			-- lsp_config.setup({
			-- 	settings = {
			-- 		css = {
			-- 			validate = true,
			-- 			lint = {
			-- 				unknownAtRules = "ignore",
			-- 			},
			-- 		},
			-- 	},
			-- })

			vim.filetype.add({ extension = { templ = "templ" } })
		end,
	},
}
