return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        notifier = { enabled = true },
        lazygit = { enabled = true },
        terminal = { win = { border = "rounded" } },
    },
    keys = {
        { "<c-/>",      function() Snacks.terminal("fish") end, desc = "Toggle Terminal" },
        { "<leader>lg", function() Snacks.lazygit() end,        desc = "[L]azy [G]it" },
    }
}
