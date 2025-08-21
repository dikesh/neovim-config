return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "c",
                "comment",
                "cpp",
                "css",
                "csv",
                "go",
                "hcl",
                "html",
                "hurl",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "nu",
                "python",
                "query",
                "regex",
                "terraform",
                "typescript",
                "vim",
                "vimdoc",
                "vue",
                "yaml",
            },
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            },
        })
    end
}
