local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
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
        priority = 1000,
    },
    -- Layout
    {
        'folke/zen-mode.nvim',
        lazy = true,
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    {
        'nvim-treesitter/playground',
        lazy = true,
    },
    "vrischmann/tree-sitter-templ",
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" },
            -- {"nvim-treesitter"},
        },
    },

    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
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
    'jose-elias-alvarez/null-ls.nvim',

    -- Utilities
    'theprimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    'tpope/vim-dadbod',
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod' },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'plsql' } }
        },
        event = 'VeryLazy',
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
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
}

local opts = {}

require("lazy").setup(plugins, opts)
