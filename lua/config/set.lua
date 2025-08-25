vim.opt.guicursor = "a:blinkon0"

vim.opt.number = true
vim.opt.relativenumber = true

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.o.smartindent = true -- syntax aware indentations for newline inserts
vim.o.list = true -- Shows > and - for tabs and trailing spaces

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.inccommand = "split"
-- Horizontal cursor line
vim.opt.cursorline = true
-- Vertical cursor line
vim.opt.cursorcolumn = true

vim.g.mapleader = " "

vim.filetype.plugin = "on"
