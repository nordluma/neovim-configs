return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        lazy = false,
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },


            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
            -- LSP progress
            { 'j-hui/fidget.nvim' },
        },
        config = function()
            local lsp = require('lsp-zero')
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            local lspconfig = require("lspconfig")

            lspconfig.htmx.setup {}
            lspconfig.ruff.setup {}
            lspconfig.gleam.setup {}
            lspconfig.ts_ls.setup {}

            lsp.preset("recommended")

            lsp.ensure_installed({
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
                local function goto_definition_in_vsplit()
                    -- build position params for the LSP request
                    local params = vim.lsp.util.make_position_params()
                    vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, _, _)
                        if err then
                            vim.notify("LSP error: " .. err.message, vim.log.levels.ERROR)
                            return
                        end
                        if not result or vim.tbl_isempty(result) then
                            vim.notify("Definition not found!", vim.log.levels.ERROR)
                            return
                        end
                        if vim.islist(result) then
                            -- if we get only one result -> open it directly in a new split
                            if #result == 1 then
                                vim.cmd("vsplit")
                                local def = result[1]
                                vim.cmd("wincmd w")
                                vim.lsp.util.jump_to_location(def, nil, false)
                            else
                                -- multiple definitions returned -> open a telescope picker
                                local pickers = require("telescope.pickers")
                                local finders = require("telescope.finders")
                                local actions = require("telescope.actions")
                                local action_state = require("telescope.actions.state.state")
                                local sorter = require("telescope.config").values.generic_sorter

                                pickers.new({}, {
                                    prompt_title = "LSP Definitions",
                                    finder = finders.new_table {
                                        results = result,
                                        entry_maker = function(entry)
                                            local uri = entry.uri or entry.targetUri
                                            local filename = vim.uri_to_fname(uri)
                                            local range = entry.range or entry.targetSelectionRange
                                            local row = range.start.line + 1
                                            local col = range.start.character + 1
                                            return {
                                                value = entry,
                                                display = string.format("%s:%d:%d", filename, row, col),
                                                ordinal = filename,
                                            }
                                        end
                                    },
                                    sorter = sorter({}),
                                    attach_mappings = function(prompt_bufnr, _)
                                        actions.select_default:replace(function()
                                            actions.close(prompt_bufnr)
                                            local selection = action_state.get_selected_entry()
                                            if selection then
                                                vim.cmd("vsplit")
                                                vim.cmd("wincmd w")
                                                vim.lsp.util.jump_to_location(selection.value, nil, false)
                                            end
                                        end)
                                        return true
                                    end
                                }):find()
                            end
                        else
                            -- single definition returned (not a list)
                            vim.cmd("vsplit")
                            vim.cmd("wincmd w")
                            vim.lsp.util.jump_to_location(result, nil, false)
                        end
                    end)
                end

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
                vim.keymap.set("n", "<leader>od", goto_definition_in_vsplit, { noremap = true, silent = true })
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

            vim.filetype.add({ extension = { templ = "templ" } })
            vim.diagnostic.config({ virtual_text = true })
        end
    },
}

