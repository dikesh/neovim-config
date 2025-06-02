return {
    "ibhagwan/fzf-lua",
    -- To use with dashboard actions
    lazy = false,
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require('fzf-lua').register_ui_select()
        require("fzf-lua").setup {
            winopts = {
                preview = {
                    layout = "vertical",
                    vertical = "up:65%",
                }
            }
        }
    end,
    keys = {
        { "<C-p>",      "<CMD>FzfLua files<CR>",                desc = "Find Files" },
        { "<leader>sg", "<CMD>FzfLua live_grep<CR>",            desc = "[S]earch with [G]rep" },
        { "<leader>sh", "<CMD>FzfLua helptags<CR>",             desc = "[S]each [H]elp Tags" },
        { "<leader>km", "<CMD>FzfLua keymaps<CR>",              desc = "[K]ey [M]aps" },
        { "<leader>fr", "<CMD>FzfLua resume<CR>",               desc = "[T]elescope [R]esume" },
        { "<leader>ss", "<CMD>FzfLua lsp_document_symbols<CR>", desc = "[S]earch [S]ymbols" },
        { "<leader>gr", "<CMD>FzfLua lsp_references<CR>",       desc = "[G]to [R]eferences" },
        { "<leader>ca", "<CMD>FzfLua lsp_code_actions<CR>",     desc = "[C]ode [A]ctions" },
    },
}
