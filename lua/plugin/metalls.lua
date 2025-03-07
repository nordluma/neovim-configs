return {
    {
        "scalameta/nvim-metals",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        ft = { "scala", "sbt", "java" },
        opts = function()
            local metals_config = require("metals").bare_config()
            metals_config.settings = {
                showImplicitArguments = true,
            }

            metals_config.init_options.statusBarProvider = "off"
            metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

            metals_config.on_attach = function(client, bufnr)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition)
                vim.keymap.set("n", "K", vim.lsp.buf.hover)
                vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
                vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action)
                vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references)
                vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename)
                vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help)
            end

            return metals_config
        end,
        config = function(self, metals_config)
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = self.ft,
                callback = function()
                    require("metals").initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end
    },
}
