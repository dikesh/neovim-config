vim.keymap.set("n", "<leader>]", "<CMD>bnext<CR>", { desc = "[B]uffer [N]ext" })
vim.keymap.set("n", "<leader>[", "<CMD>bprevious<CR>", { desc = "[B]uffer [P]revious" })
vim.keymap.set("n", "<leader>bd", "<CMD>bd<CR>", { desc = "[B]uffer [D]elete" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "[M]ove [D]own" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "[M]ove [U]p" })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "[M]ove [D]own" })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "[M]ove [U]p" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "[M]ove [B]lock [D]own" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "[M]ove [B]lock [U]p" })
