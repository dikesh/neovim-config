return {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        {"<leader>sf", "<CMD>Telescope find_files<CR>", mode = {"n"}, desc = "[S]each [F]iles" },
        {"<leader>sb", "<CMD>Telescope buffers<CR>", mode = {"n"}, desc = "[S]earch Buffers" },
        {"<leader>sg", "<CMD>Telescope live_grep<CR>", mode = {"n"}, desc="[S]earch with [G]rep" },
        {"<leader>sh", "<CMD>Telescope help_tags<CR>", mode = {"n"}, desc="[S]each [H]elp Tags" },
        {"<leader>km", "<CMD>Telescope keymaps<CR>", mode = {"n"}, desc="[K]ey [M]aps" },
    },
}
