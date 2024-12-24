local kmset = vim.keymap.set

kmset('n', '<leader><Tab>', '<CMD>bnext<CR>', { desc = "[B]uffer [N]ext" })
kmset('n', '<leader><S-Tab>', '<CMD>bprevious<CR>', { desc = "[B]uffer [P]revious" })
kmset('n', '<leader>x', '<CMD>bdelete<CR>', { desc = "[B]uffer [D]elete" })
kmset('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
kmset("n", "<A-j>", ":m .+1<CR>==", { desc = "[M]ove [D]own" })
kmset("n", "<A-k>", ":m .-2<CR>==", { desc = "[M]ove [U]p" })
kmset("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "[M]ove [B]lock [D]own" })
kmset("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "[M]ove [B]lock [U]p" })
