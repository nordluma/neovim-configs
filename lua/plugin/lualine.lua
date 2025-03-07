return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local lazy_status = require("lazy.status")
      require("lualine").setup {
        options = {
          theme = 'palenight',
          disabled_filetypes = {}
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            'branch',
            'diff',
            {
              'diagnostics',
              sources = { "nvim_diagnostic" },
              symbols = { error = 'E ', warn = 'W ', hint = 'H ', info = 'I ' }
            }
          },
          lualine_c = { {
            'filename',
            file_status = true,
            path = 0
          } },
          lualine_x = {
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = { fg = "#ff9e64" },
            },
            { 'encoding' },
            { 'fileformat' },
            { 'filetype' },
          },
          lualine_y = { 'progress' },
          lualine_z = {
            'location',
            { 'datetime', style = "%H.%M" }
          }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { {
            'filename',
            file_status = true,
            path = 0
          } },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { 'fugitive' }
      }
    end
  },
}
