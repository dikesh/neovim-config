return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = {
        {"<leader>n", "<CMD>:BufferLineCycleNext<CR>", mode = {"n"}, desc = "[N]ext Buffer" },
        {"<leader>0", "<CMD>:bd<CR>", mode = {"n"}, desc = "Delete Buffer" },
        {"<leader>1", "<CMD>:BufferLineGoToBuffer 1<CR>", mode = {"n"}, desc = "Go To Buffer [1]" },
        {"<leader>2", "<CMD>:BufferLineGoToBuffer 2<CR>", mode = {"n"}, desc = "Go To Buffer [2]" },
        {"<leader>3", "<CMD>:BufferLineGoToBuffer 3<CR>", mode = {"n"}, desc = "Go To Buffer [3]" },
        {"<leader>4", "<CMD>:BufferLineGoToBuffer 4<CR>", mode = {"n"}, desc = "Go To Buffer [4]" },
        {"<leader>5", "<CMD>:BufferLineGoToBuffer 5<CR>", mode = {"n"}, desc = "Go To Buffer [5]" },
        {"<leader>6", "<CMD>:BufferLineGoToBuffer 6<CR>", mode = {"n"}, desc = "Go To Buffer [6]" },
    },
    config = function ()
        require("bufferline").setup({
            options = {
                numbers = "ordinal",
                indicator = { style = "underline" },
                diagnostics = "nvim_lsp",
            }
        })
    end,
}
