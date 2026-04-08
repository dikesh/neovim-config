vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup {
    explorer = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    scratch = { enabled = true },
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
}

local kmset = vim.keymap.set

kmset('n', "<leader>lg", function() Snacks.lazygit() end, { desc = "Lazy Git" })
kmset('n', "[w", function() Snacks.words.jump(-1, false) end, { desc = "Previous Reference" })
kmset('n', "]w", function() Snacks.words.jump(1, false) end, { desc = "Next Reference" })
kmset('n', "<leader>e", function() Snacks.explorer.open() end, { desc = "Open Explorer" })
kmset('n', "<M-C-p>", function() Snacks.picker() end, { desc = "Snacks Picker" })
-- Picker
kmset('n', "<C-p>", function() Snacks.picker.smart() end, { desc = "Find Files" })
kmset('n', "<leader>sf", function() Snacks.picker.files() end, { desc = "Find Files" })
kmset({ 'n', 'v' }, "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
kmset('n', "<leader>/", function() Snacks.picker.git_grep() end, { desc = "Search with Grep" })
kmset('n', "<leader>sg", function() Snacks.picker.grep() end, { desc = "Search with Grep" })
kmset('n', "<leader>sh", function() Snacks.picker.help() end, { desc = "Seach Help Tags" })
kmset('n', "<leader>sr", function() Snacks.picker.resume() end, { desc = "Telescope Resume" })
kmset({ 'n', 'x' }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })
kmset('n', "<leader>sl", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
kmset('n', "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, { desc = "Show Diagnostics" })
kmset('n', "<leader>sD", function() Snacks.picker.diagnostics() end, { desc = "Show Diagnostics" })
kmset('n', "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo History" })
kmset('n', "<leader>sc", function() Snacks.picker.cliphist() end, { desc = "Clipboard History" })
kmset('n', "<leader>km", function() Snacks.picker.keymaps() end, { desc = "Key Maps" })
kmset('n', "<leader>gr", function() Snacks.picker.lsp_references() end, { desc = "Goto References" })
kmset('n', "<leader>gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definitions" })
kmset('n', "<leader>sS",
    function() Snacks.picker.lsp_workspace_symbols({ filter = { default = { "Class", "Function", "Constant", "Method" } } }) end,
    { desc = "Search Symbols" })
kmset('n', "<leader>ss",
    function() Snacks.picker.lsp_symbols({ filter = { default = { "Class", "Function", "Constant", "Method" } } }) end,
    { desc = "Search Symbols" })
