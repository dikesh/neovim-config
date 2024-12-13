return {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    cond = function()
        local pwd  = vim.fn.getcwd()
        local s, e = pwd:find('notes', nil, true)
        return s ~= nil and e ~= nil
    end,
    lazy = false,
    version = "*",
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
