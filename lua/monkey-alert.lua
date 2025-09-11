local blame = require("./line-blame")

local defaultList = "one,two"
local defaultBlameTextColor = "#bcb8b1"
local defaultBlameText = "- Monkey alert 🐒"
local defaultBlamePosition = "eol"

local function clearBlame()
    blame.clearBlame()
end

local function blameCurrentFile()
    clearBlame()
    blame.fileBlame(vim.api.nvim_buf_get_name(0), vim.g.monkey_mail_list, vim.g.monkey_blame_text,
        "Monkey", vim.g.monkey_blame_position)
end

local function blameCurrentLine()
    clearBlame()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    blame.lineBlame(vim.api.nvim_buf_get_name(0), tonumber(row) - 1, vim.g.monkey_mail_list,
        vim.g.monkey_blame_text,
        "Monkey", vim.g.monkey_blame_position)
end

local function enableOnLine()
    vim.api.nvim_create_autocmd("CursorMoved", {
        callback = function()
            clearBlame()
            blameCurrentLine()
        end,
    })
end

local function setup(opts)
    vim.api.nvim_set_hl(0, 'Monkey', { fg = opts.blame_text_color_hex or defaultBlameTextColor, bold = false })
    vim.g.monkey_mail_list = opts.monkey_mail_list or defaultList
    vim.g.monkey_blame_text = opts.blame_text or defaultBlameText
    vim.g.monkey_blame_position = opts.blame_position or defaultBlamePosition

    if opts.auto_attach then
        enableOnLine()
    end
end

return {
    setup = setup,
    blameLine = blameCurrentLine,
    blameFile = blameCurrentFile,
    blameClear = clearBlame,
    enable = enableOnLine
}
