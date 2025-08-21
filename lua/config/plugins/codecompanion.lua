return {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    opts = {
        display = {
            chat = {
                window = {
                    position = "right"
                }
            }
        },
        strategies = {
            chat = {
                adapter = "anthropic",
            },
            inline = {
                adapter = "anthropic",
            },
            cmd = {
                adapter = "anthropic",
            },
        },
        adapters = {
            anthropic = function()
                return require("codecompanion.adapters").extend("anthropic", {
                    env = {
                        api_key = "cmd: gpg --quiet --decrypt ~/.keys/anthropic.gpg 2>/dev/null",
                    },
                })
            end,
        },
        opts = {
            log_level = "DEBUG",
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        { "<leader>cc", "<CMD>CodeCompanionActions<CR>", mode = { "n" }, desc = "[C]ode [C]ompanion" },
    },

}
