vim.opt.guicursor = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"

vim.g.python3_host_prog = "/home/dikesh/.virtualenvs/nvim/bin/python"
vim.g.mapleader = " "
vim.g.timeout = true
vim.g.timeoutlen = 5000

-- Indent for json file
vim.api.nvim_create_augroup('setIndent', { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "setIndent",
    pattern = "json",
    command = "setlocal shiftwidth=2 tabstop=2"
})

-- Show dashboard on all buffer deletion
vim.api.nvim_create_augroup("dashboard_on_empty", { clear = true })
vim.api.nvim_create_autocmd("BufDelete", {
    group = "dashboard_on_empty",
    callback = function(args)
        -- Skip when no match
        if args.match == '' then return end
        -- Renaminig buffers excluding `No Name` buffer
        local rem_buffers = 0
        for _, bufinfo in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
            if bufinfo.name ~= args.match and bufinfo.name ~= "" then
                rem_buffers = rem_buffers + 1
            end
        end
        if rem_buffers == 0 then
            vim.cmd('Dashboard')
        end
    end,
})
