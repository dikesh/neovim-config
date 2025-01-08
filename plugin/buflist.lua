-- Local
local v = vim.api

---@return {buf_id: integer, buf_fullpath: string, buf_path: string}[]
local get_loaded_buffers = function()
    -- Current directory
    local pwd = vim.fn.getcwd()
    local bufnames = {}

    for _, bufinfo in pairs(vim.fn.getbufinfo({ buflisted = 1, bufloaded = 1 })) do
        local _, i2 = bufinfo.name:find(pwd, nil, true)
        if i2 then
            table.insert(bufnames,
                {
                    buf_id = bufinfo.bufnr,
                    buf_fullpath = bufinfo.name,
                    buf_path = bufinfo.name:sub(i2 + 2)
                }
            )
        end
    end

    return bufnames
end

-- Set new highlight group
local hl_group_name = "BufListBoldText"
v.nvim_set_hl(0, hl_group_name, { bold = true })

-- Buffer options
local buf_options = {
    anchor = "NE",
    border = "rounded",
    col = vim.o.columns - 1,
    focusable = false,
    height = 6,
    relative = "win",
    row = 1,
    title = " Buffers ",
    title_pos = "center",
    width = 50,
    zindex = 30,
    hide = false,
}

---@class M
local M = {
    buf = 0,
    win = 0,
    hide = false,
}

-- Initialize module
M.Init = function()
    local buf = v.nvim_create_buf(false, true)
    local win = v.nvim_open_win(buf, false, buf_options)
    v.nvim_set_option_value("number", false, { win = win })
    v.nvim_set_option_value("relativenumber", false, { win = win })

    M.buf = buf
    M.win = win
end

---@param current_file string
-- Update buffer lines and window visibility
M.update_buffer = function(current_file)
    -- Array of lines and line to be highlighted
    local lines = {}
    local hl_line = 0
    local line_count = 0

    for idx, bufinfo in ipairs(get_loaded_buffers()) do
        table.insert(lines, " " .. idx .. ". " .. bufinfo.buf_path)
        if bufinfo.buf_fullpath == current_file then
            hl_line = idx - 1
        end
        line_count = line_count + 1
    end

    v.nvim_buf_set_lines(M.buf, 0, -1, false, lines)
    v.nvim_buf_add_highlight(M.buf, -1, hl_group_name, hl_line, 1, -1)

    if line_count < 2 then
        v.nvim_win_set_config(M.win, { hide = true })
    else
        v.nvim_win_set_config(M.win, { hide = M.hide })
    end
end

-- Toggle Window
M.toggle_win = function()
    M.hide = not M.hide
    v.nvim_win_set_config(M.win, { hide = M.hide })
end

-- Update buffer list on navigation
v.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = v.nvim_create_augroup("loaded_buffers", { clear = true }),
    callback = function(opt) M.update_buffer(opt.file) end
})

-- Bind key to toggle window
vim.keymap.set("n", "<leader><leader>", M.toggle_win, { desc = "Toggle Buffer list" })

M.Init()
return M
