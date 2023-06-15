-- Shell options
vim.opt.shell = "pwsh.exe"
vim.opt.shellcmdflag = "-NoLogo -NoProfile -NonInteractive -ExecutionPolicy RemoteSigned -Command"
vim.opt.shellxquote = ""
vim.opt.shellquote = ""
vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF-8 %s"
vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF-8 %s"

-- Set Linenumbers
vim.opt.nu = true
vim.opt.relativenumber = true

--Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

--Formating
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.tw = 80

--Backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("UserProfile") .. "/.vim/undodir"
vim.opt.undofile = true

--Highlighting
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes:2"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "


