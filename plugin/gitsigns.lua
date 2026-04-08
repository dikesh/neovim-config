vim.api.nvim_create_autocmd('BufReadPre', {
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

        require('gitsigns').setup {
            preview_config = {
                border = 'rounded',
            },
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gitsigns.nav_hunk('next', { preview = true })
                    end
                end)

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gitsigns.nav_hunk('prev', { preview = true })
                    end
                end)

                -- Actions
                map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "[H]unk [S]tage" })
                map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "[H]unk [R]eset" })
                map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "[H]unk [P]review" })
                map('n', '<leader>bl', function()
                    gitsigns.blame_line()
                end, { desc = "[B]lame [L]ine" })
            end
        }
    end,
})
