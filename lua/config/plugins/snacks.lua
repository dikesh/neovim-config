return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        explorer = { enabled = true },
        lazygit = { enabled = true },
        notifier = { enabled = true },
        words = { notify_end = false },
    },
    keys = {
        { "<leader>lg", function() Snacks.lazygit() end,             desc = "[L]azy [G]it" },
        { "[w",         function() Snacks.words.jump(-1, false) end, desc = "Previous Reference" },
        { "]w",         function() Snacks.words.jump(1, false) end,  desc = "Next Reference" },
        { "<leader>e",  function() Snacks.explorer.open() end,       desc = "Open Explorer" },
    }
}
