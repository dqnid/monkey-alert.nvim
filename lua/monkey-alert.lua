local blame = require("./line-blame")

local defaultList = "one,two"
local defaultBlameTextColor = "#bcb8b1"
local defaultBlameText = "- Monkey alert 🐒"
local defaultBlamePosition = "eol"

local function setup(opts)
    vim.api.nvim_set_hl(0, 'Monkey', { fg = opts.blameTextColorHex or defaultBlameTextColor, bold = false })
    vim.g.monkeyMailList = opts.monkeyMailList or defaultList
    vim.g.monkeyBlameText = opts.blameText or defaultBlameText
    vim.g.monkeyBlamePosition = opts.blamePosition or defaultBlamePosition
end

local function blameCurrentFile()
    blame.fileBlame(vim.api.nvim_buf_get_name(0), vim.g.monkeyMailList, vim.g.monkeyBlameText,
        "Monkey", vim.g.monkeyBlamePosition)
end

local function blameCurrentLine()
    blame.lineBlame(vim.api.nvim_buf_get_name(0), vim.g.monkeyMailList, vim.g.monkeyBlameText,
        "Monkey", vim.g.monkeyBlamePosition)
end

return {
    setup = setup,
    blameLine = blameCurrentLine,
    blameFile = blameCurrentFile
}
