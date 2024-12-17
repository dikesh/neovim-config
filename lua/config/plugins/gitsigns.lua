return {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
        require('gitsigns').setup()
    end,
    keys = {
        { "<leader>hp", "<CMD>Gitsigns preview_hunk<CR>",    desc = "[H]unk [P]review" },
        { "<leader>hn", "<CMD>Gitsigns next_hunk<CR>",       desc = "[H]unk [N]ext" },
        { "<leader>hs", "<CMD>Gitsigns stage_hunk<CR>",      desc = "[H]unk [S]tage" },
        { "<leader>hu", "<CMD>Gitsigns undo_stage_hunk<CR>", desc = "[H]unk [U]ndo Last Staged" },
        { "<leader>hr", "<CMD>Gitsigns reset_hunk<CR>",      desc = "[H]unk [R]eset" },
        { "<leader>bl", "<CMD>Gitsigns blame_line<CR>",      desc = "[B]lame [L]ine" },
    }
}
