return {
  -- 'nvim-treesitter/playground',
  "vrischmann/tree-sitter-templ",
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "query", "javascript", "typescript", "python", "markdown", "rust" },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "Select around a function" },
              ["if"] = { query = "@function.inner", desc = "Select inside a function" },
              ["ac"] = { query = "@class.outer", desc = "Select around a class" },
              ["ic"] = { query = "@class.inner", desc = "Select inside a class" },
              ["ao"] = { query = "@object.outer", desc = "Select around an object" },
              ["io"] = { query = "@object.inner", desc = "Select inside an object" },
            },
            selection_modes = {
              ["@parameter.outer"] = "v",               -- charwise
              ["@function.outer"] = "V",                -- linewise
              ["@class.outer"] = "V",                   -- linewise
              -- "<c-v>" blockwise
            },
            include_surrounding_whitespace = true,
          }
        }
      })

      local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      treesitter_parser_config.templ = {
        install_info = {
          url = "https://github.com/vrischmann/tree-sitter-templ.git",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "master",
        },
      }

      vim.treesitter.language.register("templ", "templ")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = false,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
}
