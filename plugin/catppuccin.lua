vim.pack.add({ "https://github.com/catppuccin/nvim" })

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
