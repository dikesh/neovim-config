local set = vim.opt_local

set.shiftwidth = 4
set.tabstop = 4
set.softtabstop = 4

vim.pack.add({ 'https://github.com/folke/lazydev.nvim' })

require('lazydev').setup {
    library = {
        "snacks.nvim",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
}
