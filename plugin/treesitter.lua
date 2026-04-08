vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'nvim-treesitter' and kind == 'update' then
            if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
            vim.cmd('TSUpdate')
        end
    end
})

vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

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
