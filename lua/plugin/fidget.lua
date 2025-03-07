return {
    {
        'j-hui/fidget.nvim',
        config = function()
            require('fidget').setup({
                notification = {
                    filter = vim.log.levels.INFO,
                    window = {
                        normal_hl = "",
                        winblend = 0,
                        border = 'none',
                        x_padding = 0,
                    }
                }
            })
        end
    }
}

