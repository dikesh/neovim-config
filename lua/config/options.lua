-- Options
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "100"
vim.opt.signcolumn = "yes"
vim.opt.hlsearch = false
vim.opt.number = true
vim.opt.relativenumber = true

-- Toggle relativenumber
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup("toggle_rnu", { clear = true }),
    callback = function(opt) vim.opt.relativenumber = opt.event ~= "InsertEnter" end

})

-- Diagnostic config
vim.diagnostic.config({
    float = {
        border = 'rounded',
        source = true,
    },
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.HINT] = '⚑',
            [vim.diagnostic.severity.INFO] = '»',
        },
    },
    underline = true,
})
