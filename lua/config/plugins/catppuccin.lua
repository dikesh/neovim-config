return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "macchiato",
            transparent_background = true,
            float = { transparent = true, solid = false },
            custom_highlights = function(colors)
                return {
                    SnacksPickerDir = { fg = colors.lavender },
                }
            end
        })
        vim.cmd([[colorscheme catppuccin]])
    end,
}
