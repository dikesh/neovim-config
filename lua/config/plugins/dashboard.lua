return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    config = function()
        require('dashboard').setup {
            theme = "doom",
            config = {
                header = {
                    "                                   ",
                    "                                   ",
                    "                                   ",
                    "  ,_-~~~-,    _-~~-_              ",
                    " /        ^-_/      \\_    _-~-.   ",
                    "|      /\\  ,          `-_/     \\  ",
                    "|   /~^\\ '/  /~\\  /~\\   / \\_    \\ ",
                    " \\_/    }/  /        \\  \\ ,_\\    }",
                    "        Y  /  /~  /~  |  Y   \\   |",
                    "       /   | {Q) {Q)  |  |    \\_/ ",
                    "       |   \\  _===_  /   |        ",
                    "       /  >--{     }--<  \\        ",
                    "     /~       \\_._/       ~\\      ",
                    "    /    *  *   Y    *      \\     ",
                    "    |      * .: | :.*  *    |     ",
                    "    \\    )--__==#==__--     /     ",
                    "     \\_      \\  \\  \\      ,/      ",
                    "       '~_    | |  }   ,~'        ",
                    "          \\   {___/   /           ",
                    "           \\   ~~~   /            ",
                    "           /\\._._._./\\            ",
                    "          {    ^^^    }           ",
                    "           ~-_______-~            ",
                    "            /       \\             ",
                    "                                   ",
                    "                                   ",
                    "                                   ",
                },
                center = {
                    {
                        desc = "Search File",
                        key = "f",
                        key_format = ' %s',
                        action = 'FzfLua files'
                    },
                    {
                        desc = "Live Grep",
                        key = "g",
                        key_format = ' %s',
                        action = "FzfLua live_grep",
                    },
                    {
                        desc = "Keymaps",
                        key = "k",
                        key_format = ' %s',
                        action = "FzfLua keymaps",
                    },
                    {
                        desc = "Help Tags",
                        key = "h",
                        key_format = ' %s',
                        action = "FzfLua helptags",
                    },
                    {
                        desc = "Lazy",
                        key = "l",
                        key_format = ' %s',
                        action = "Lazy",
                    },
                }
            },
        }

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
    end,
    keys = {
        { "<leader>sd", "<CMD>Dashboard<CR>", mode = { "n" }, desc = "[S]how [D]ashboard" },
    },
}
