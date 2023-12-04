return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- Update config
        local config = require('lualine').get_config()
        config.sections.lualine_c = { { 'filename', path = 1 } }
        require("lualine").setup(config)
    end
}
