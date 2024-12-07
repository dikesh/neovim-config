vim.opt.guicursor = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.cb = "unnamedplus"

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"

vim.g.python3_host_prog = "~/.config/nvim/.venv/bin/python"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.timeout = true
vim.g.timeoutlen = 5000

-- Set Indent
vim.api.nvim_create_augroup('setIndent', { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "setIndent",
    pattern = { "css", "scss", "javascript", "json", "typescript", "vue", "yuck", },
    command = "setlocal shiftwidth=2 tabstop=2"
})

-- Set Conceal Level
vim.api.nvim_create_augroup('setConcealLevel', { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "setConcealLevel",
    pattern = { "norg", },
    command = "setlocal conceallevel=1"
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup('highlight-on-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})
