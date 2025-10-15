return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        explorer = { enabled = true },
        lazygit = { enabled = true },
        notifier = { enabled = true },
        picker = {
            enabled = true,
            prompt = "❯ ",
            layouts = {
                default = {
                    layout = {
                        backdrop = false,
                        width = 0.7,
                        min_width = 80,
                        height = 0.85,
                        border = "none",
                        box = "vertical",
                        { win = "preview", title = "{preview}", height = 0.65, border = "rounded" },
                        {
                            box = "vertical",
                            border = "rounded",
                            title = "{title} {live} {flags}",
                            title_pos = "center",
                            { win = "input", height = 1,     border = "bottom" },
                            { win = "list",  border = "none" },
                        }
                    }
                }
            }
        },
        words = { notify_end = false },
    },
    keys = {
        { "<leader>lg", function() Snacks.lazygit() end,                desc = "Lazy Git" },
        { "[w",         function() Snacks.words.jump(-1, false) end,    desc = "Previous Reference" },
        { "]w",         function() Snacks.words.jump(1, false) end,     desc = "Next Reference" },
        { "<leader>e",  function() Snacks.explorer.open() end,          desc = "Open Explorer" },
        { "<M-C-p>",    function() Snacks.picker() end,                 desc = "Snacks Picker" },
        -- Picker
        { "<C-p>",      function() Snacks.picker.smart() end,           desc = "Find Files" },
        { "<leader>sf", function() Snacks.picker.files() end,           desc = "Find Files" },
        { "<leader>:",  function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>/",  function() Snacks.picker.git_grep() end,        desc = "Search with Grep" },
        { "<leader>s/", function() Snacks.picker.grep() end,            desc = "Search with Grep" },
        { "<leader>sh", function() Snacks.picker.help() end,            desc = "Seach Help Tags" },
        { "<leader>sr", function() Snacks.picker.resume() end,          desc = "Telescope Resume" },
        {
            "<leader>sw",
            function() Snacks.picker.grep_word() end,
            desc = "Visual selection or word",
            mode = { "n", "x" }
        },
        { "<leader>sl", function() Snacks.picker.lines() end,              desc = "Buffer Lines" },
        { "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, desc = "Show Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics() end,        desc = "Show Diagnostics" },
        { "<leader>su", function() Snacks.picker.undo() end,               desc = "Undo History" },
        { "<leader>km", function() Snacks.picker.keymaps() end,            desc = "Key Maps" },
        { "<leader>gr", function() Snacks.picker.lsp_references() end,     desc = "Goto References" },
        { "<leader>gd", function() Snacks.picker.lsp_definitions() end,    desc = "Goto Definitions" },
        {
            "<leader>sS",
            function()
                Snacks.picker.lsp_workspace_symbols({
                    filter = {
                        default = { "Class", "Function", "Constant", "Method" }
                    }
                })
            end,
            desc = "Search Symbols"
        },
        {
            "<leader>ss",
            function()
                Snacks.picker.lsp_symbols({
                    filter = {
                        default = { "Class", "Function", "Constant", "Method" }
                    }
                })
            end,
            desc = "Search Symbols"
        },
    }
}
