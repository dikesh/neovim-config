return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    init = function()
        local parser_installed = {
            "bash",
            "c",
            "comment",
            "cpp",
            "css",
            "csv",
            "go",
            "hcl",
            "html",
            "javascript",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "nu",
            "python",
            "query",
            "regex",
            "scss",
            "terraform",
            "typescript",
            "vala",
            "vim",
            "vimdoc",
            "vue",
            "yaml",
        }

        local ts = require("nvim-treesitter")

        vim.defer_fn(function() ts.install(parser_installed) end, 1000)
        ts.update()

        -- auto-start highlights & indentation
        vim.api.nvim_create_autocmd("FileType", {
            desc = "User: enable treesitter highlighting",
            callback = function(ctx)
                -- highlights
                local hasStarted = pcall(vim.treesitter.start) -- errors for filetypes with no parser

                -- indent
                local noIndent = {}
                if hasStarted and not vim.list_contains(noIndent, ctx.match) then
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
    end
}
