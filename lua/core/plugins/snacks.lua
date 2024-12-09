return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        lazygit = { enabled = true },
        notifier = { enabled = true },
    },
    keys = {
        { "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit" },
    },
}
