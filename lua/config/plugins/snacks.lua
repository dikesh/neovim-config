return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        notifier = { enabled = true },
        terminal = { win = { border = "rounded" } },
    },
    keys = {
        { "<c-/>", function() Snacks.terminal("fish") end, desc = "Toggle Terminal" },
    }
}
