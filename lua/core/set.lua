vim.opt.guicursor = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.conceallevel = 1

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

-- Indent for json file
vim.api.nvim_create_augroup('setIndent', { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "setIndent",
    pattern = { "css", "javascript", "json", "typescript", "vue", },
    command = "setlocal shiftwidth=2 tabstop=2"
})
