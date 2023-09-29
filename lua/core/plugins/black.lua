return {
    'psf/black',
    -- Lazy load on file type
    ft = "python",
    config = function()
        vim.api.nvim_create_augroup("black_on_save", { clear = true })

        vim.api.nvim_create_autocmd('BufWritePre', {
            command = 'Black',
            group = 'black_on_save'
        })
    end
}
