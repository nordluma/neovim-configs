local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim\n", "ErrorMsg" },
            { out,                           "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.x',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    -- Themes
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000
    },
    -- Layout
    'folke/zen-mode.nvim',

    -- Treesitter
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'nvim-treesitter/playground',
    "vrischmann/tree-sitter-templ",
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = false,
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" },
        },
    },
    -- Autocompletion
    -- LSP
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
    },
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
    { 'jose-elias-alvarez/null-ls.nvim', event = 'VeryLazy' },

    -- Utilities
    'theprimeagen/harpoon',
    'mbbill/undotree',
    { 'tpope/vim-fugitive', event = 'VeryLazy' },
    { 'tpope/vim-dadbod',   event = 'VeryLazy' },
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod' },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'plsql' } }
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConn',
            'DBUIFindBuffer'
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end
    },
    'windwp/nvim-autopairs',
    'windwp/nvim-ts-autotag',
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "rest-nvim/rest.nvim",
        lazy = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            opts = function(_, opts)
                opts.ensure_installed = opts.ensure_installed or {}
                table.insert(opts.ensure_installed, "http")
            end,
        }
    }
}

local opts = {
    defaults = {
        lazy = true,
    },
    install = {
        missing = true,
        colorscheme = { "tokyonight" }
    },
    change_detection = {
        enabled = true,
        notify = true,
    },
    checker = {
        enabled = true,
        notify = false,
    },
}

require("lazy").setup(plugins, opts)
