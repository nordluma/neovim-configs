return {
  {
			-- Snippets
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
			{ "saadparwaiz1/cmp_luasnip" },
    },
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        sources = {
          {name = "nvim_lsp"},
          {name = "nvim_lua"},
          {name = "buffer"},
          {name = "path"},
          {name = "luasnip"}
        },
        preselect = "item",
        completion = {
          completeopt = "menu,menuone,noinsert"
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({select = false})
        }),
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
            vim.snippet.expand(args.body)
          end
        },
        formatting = {
          fields = {"menu", "abbr", "kind"},
          format = function(entry, item)
            local menu_icon = {
              nvim_lsp = 'λ',
              luasnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
              nvim_lua = 'Π',
            }

            item.menu = menu_icon[entry.source.name]
            return item
          end
        }
      })
    end
  }
}
