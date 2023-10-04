vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.title = true
vim.o.fileencoding = "utf-8"
vim.o.mouse = "a"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.hlsearch = false

vim.o.undofile = true
vim.o.clipboard = "unnamedplus"
vim.o.showtabline = false
vim.o.showmode = false
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.o.cmdheight = 2

--vim.cmd('set ts=4') -- Insert 2 spaces for a tab
vim.bo.tabstop = 4
--vim.cmd('set sw=4') -- Change the number of space characters inserted for indentation
vim.bo.shiftwidth = 4
vim.bo.smartindent = true
vim.bo.expandtab = true

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = true
vim.wo.cursorline = true
vim.wo.signcolumn = "yes"
