-- Local
local v = vim.api

-- Returns { buf_id, buf_fullpath, buf_path }
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

-- Create new buffer
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
}

-- Open window
local buf = v.nvim_create_buf(false, true)
local win = v.nvim_open_win(buf, false, buf_options)
v.nvim_set_option_value("number", false, { win = win })
v.nvim_set_option_value("relativenumber", false, { win = win })

-- Set new highlight
v.nvim_set_hl(0, "BufListBoldText", { bold = true })

-- Set text to buffer
local update_buffer = function(current_file)
    local lines = {}
    local hl_line = 0
    for idx, bufinfo in ipairs(get_loaded_buffers()) do
        table.insert(lines, " " .. idx .. ". " .. bufinfo.buf_path)
        if bufinfo.buf_fullpath == current_file then
            hl_line = idx - 1
        end
    end
    v.nvim_buf_set_lines(buf, 0, -1, false, lines)
    v.nvim_buf_add_highlight(buf, -1, "BufListBoldText", hl_line, 1, -1)

    if #lines == 0 then
        v.nvim_win_set_config(win, { hide = true })
    else
        v.nvim_win_set_config(win, { hide = false })
    end
end

-- Update buffer list on navigation
v.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = v.nvim_create_augroup("loaded_buffers", { clear = true }),
    callback = function(opt) update_buffer(opt.file) end
})

-- Focus buffer
local focus_buffer = function(buf_idx)
    for idx, bufinfo in ipairs(get_loaded_buffers()) do
        if idx == buf_idx then
            vim.cmd("b " .. bufinfo.buf_id)
        end
    end
end

-- Bind number keys to focus buffer
for i = 1, 5, 1 do
    vim.keymap.set("n", "<leader>" .. i, function() focus_buffer(i) end)
end

-- Bind key to toggle window
vim.keymap.set("n", "<leader><leader>", function()
    local win_config = v.nvim_win_get_config(win)
    v.nvim_win_set_config(win, { hide = not win_config.hide })
end, { desc = "Toggle Buffer list" })
