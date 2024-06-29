return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "bash",
                "c",
                "comment",
                "cpp",
                "css",
                "csv",
                "html",
                "javascript",
                "json",
                "lua",
                "norg",
                "python",
                "query",
                "regex",
                "typescript",
                "vim",
                "vimdoc",
                "vue",
            },
            sync_install = false,
            auto_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
