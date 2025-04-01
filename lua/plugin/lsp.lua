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
      local custom_lsp = require("custom.plugin.lsp")
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

      -- lsp.format_on_save({
      --   format_opts = {
      --     async = false,
      --     timeout_ms = 10000,
      --   },
      --   servers = {
      --     ['rust_analyzer'] = { 'rust' },
      --     ['null-ls'] = {
      --       'typescript',
      --       'javascript',
      --       'typescriptreact',
      --       'javascriptreact',
      --       'marksman',
      --       'python'
      --     },
      --   }
      -- })

      lsp.on_attach(custom_lsp.on_attach_fn)
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
      vim.diagnostic.config({
        virtual_text = {
          severity = {
            max = vim.diagnostic.severity.WARN
          },
        },
        virtual_lines = {
          severity = {
            min = vim.diagnostic.severity.ERROR
          },
        },
      })
    end
  },
}
