return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'VeryLazy',
    enabled = false,
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.golines.with({
            extra_args = { "-m", "79" },
          }),
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.black,
        }
      })
    end
  },
}
