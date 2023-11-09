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
                        action = "Telescope find_files",
                    },
                    {
                        desc = "Live Grep",
                        key = "g",
                        key_format = ' %s',
                        action = "Telescope live_grep",
                    },
                    {
                        desc = "Keymaps",
                        key = "k",
                        key_format = ' %s',
                        action = "Telescope keymaps",
                    },
                    {
                        desc = "Help Tags",
                        key = "h",
                        key_format = ' %s',
                        action = "Telescope help_tags",
                    },
                }
            },
        }
    end,
    keys = {
        { "<leader>sd", "<CMD>Dashboard<CR>", mode = { "n" }, desc = "[S]how [D]ashboard" },
    },
}
