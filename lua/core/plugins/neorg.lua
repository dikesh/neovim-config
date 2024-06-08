return {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    lazy = false,  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
        require('neorg').setup {
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = { config = { folds = false } },
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            home = "~/notes/home", -- Format: <name_of_workspace> = <path_to_workspace_root>
                            work = "~/notes/work",
                            arch = "~/notes/arch",
                        },
                        index = "index.norg", -- The name of the main (root) .norg file
                    }
                },
            }
        }
    end,
    keys = {
        { "<leader>nh", "<CMD>Neorg workspace home<CR>", desc = "[N]eorg Workspace [H]ome" },
        { "<leader>nw", "<CMD>Neorg workspace work<CR>", desc = "[N]eorg Workspace [W]ork" },
        { "<leader>nr", "<CMD>Neorg return<CR>",         desc = "[N]eorg [R]eturn" },
    }
}
