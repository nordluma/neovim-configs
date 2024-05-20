local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
    }
}

require("lazy").setup(plugins, opts)
