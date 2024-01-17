vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Themes
    use('folke/tokyonight.nvim')

    -- Layout
    use('folke/zen-mode.nvim')

    -- Treesitter
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use("vrischmann/tree-sitter-templ")
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
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
        }
    }
    use('jose-elias-alvarez/null-ls.nvim')

    -- Utilities
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use('tpope/vim-dadbod')
    use {
        'kristijanhusak/vim-dadbod-ui',
        requires = {
            { 'tpope/vim-dadbod' },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'plsql' } }
        },
        -- HOW TO MOVE TO OWN MODULE?????
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConn',
            'DBUIFindBuffer'
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end
    }
    use('windwp/nvim-autopairs')
    use('windwp/nvim-ts-autotag')
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
end)
