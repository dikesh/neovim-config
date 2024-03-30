return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "bash",
                "comment",
                "c",
                "cpp",
                "css",
                "csv",
                "json",
                "lua",
                "python",
                "vim",
                "vimdoc",
                "query",
                "javascript",
                "html",
                "norg"
            },
            sync_install = false,
            auto_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
