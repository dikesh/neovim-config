return {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    lazy = false,  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    opts = {
        load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {
                config = {
                    folds = false,
                    icons = {
                        todo = {
                            pending = {
                                icon = "",
                            }
                        }
                    }
                },

            },
        }
    },
    keys = {
        { "<leader>nh", "<CMD>Neorg workspace home<CR>", desc = "[N]eorg Workspace [H]ome" },
        { "<leader>nw", "<CMD>Neorg workspace work<CR>", desc = "[N]eorg Workspace [W]ork" },
        { "<leader>nr", "<CMD>Neorg return<CR>",         desc = "[N]eorg [R]eturn" },
    }
}
