-- Options
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.python3_host_prog = "~/.config/nvim/.venv/bin/python"

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

-- Keymaps
vim.keymap.set('n', '<leader><Tab>', '<CMD>bnext<CR>', { desc = "[B]uffer [N]ext" })
vim.keymap.set('n', '<leader><S-Tab>', '<CMD>bprevious<CR>', { desc = "[B]uffer [P]revious" })
vim.keymap.set('n', '<leader>x', '<CMD>bdelete<CR>', { desc = "[B]uffer [D]elete" })
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "[M]ove [D]own" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "[M]ove [U]p" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "[M]ove [B]lock [D]own" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "[M]ove [B]lock [U]p" })

-- Command to highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})

-- Load lazy.nvim
require("config.lazy")

-- Buffer list window
require("config.buflist")
