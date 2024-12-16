return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
        require('telescope').setup {
            defaults = {
                layout_strategy = "vertical",
                layout_config = {
                    vertical = { width = 0.65, preview_cutoff = 20 }
                },
            },
        }
        require('telescope').load_extension('fzf')
    end,
    keys = {
        { "<C-p>",      "<CMD>Telescope find_files<CR>",           desc = "Find Files" },
        { "<leader>sg", "<CMD>Telescope live_grep<CR>",            desc = "[S]earch with [G]rep" },
        { "<leader>sh", "<CMD>Telescope help_tags<CR>",            desc = "[S]each [H]elp Tags" },
        { "<leader>km", "<CMD>Telescope keymaps<CR>",              desc = "[K]ey [M]aps" },
        { "<leader>tr", "<CMD>Telescope resume<CR>",               desc = "[T]elescope [R]esume" },
        { "<leader>ss", "<CMD>Telescope lsp_document_symbols<CR>", desc = "[S]earch [S]ymbols" },
        { "<leader>gr", "<CMD>Telescope lsp_references<CR>",       desc = "[G]to [R]eferences" },
    },
}
