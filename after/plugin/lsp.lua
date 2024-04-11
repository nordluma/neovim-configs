local lsp = require('lsp-zero')
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local lspconfig = require("lspconfig")

require('fidget').setup {}
lspconfig.htmx.setup {}
lspconfig.ruff_lsp.setup {}

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'rust_analyzer',
    'eslint',
    'html'
})

lsp.set_preferences({
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['rust_analyzer'] = { 'rust' },
        ['null-ls'] = {
            'typescript',
            'javascript',
            'typescriptreact',
            'javascriptreact',
            'marksman',
            'python'
        },
    }
})

lsp.on_attach(function(client, bufnr)
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
    end

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

-- Ignore TailwindCss unknownAtRules
lsp.setup({
    settings = {
        css = {
            validate = true,
            lint = {
                unknownAtRules = "ignore",
            }
        },
    },
})

vim.filetype.add({
    extension = {
        templ = "templ",
    },
})

vim.diagnostic.config({
    virtual_text = true
})
