
require('rose-pine').setup({
    variant = 'moon',
    disable_background = true,

    highlight_groups = {
		-- Blend colours against the "base" background
		CursorLine = { bg = 'foam', blend = 10 },
		StatusLine = { fg = 'love', bg = 'love', blend = 10 },
	}
})
vim.cmd('colorscheme rose-pine')
