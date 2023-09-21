return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {
            filters = { dotfiles = true },
            renderer = {
                indent_markers = { enable = true, }
            },
            update_focused_file = { enable = true },
        }
    end,
    keys = {
        { "<C-b>", "<CMD>:NvimTreeToggle<CR>", mode = { "n" }, desc = "[T]oggle [T]ree" },
    },
}
