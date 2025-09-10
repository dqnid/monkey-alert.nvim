local blame = require("./line-blame")

local defaultList = "one;two"
-- vim.g.monkeyUserList = defaultList
vim.g.monkeyMailList = defaultList

local function setup(opts)
    vim.g.monkeyMailList = opts.monkeyMailList
    -- vim.g.monkeyUserList = opts.monkeyUserList
end

local function blameCurrentFile()
    blame.lineBlame(vim.api.nvim_buf_get_name(0), "test,another,dani.heras@hotmail.com,final", "| Found a fkin monkey 🐒",
        "Normal", "eol")
end

return {
    setup = setup,
    blame = blameCurrentFile
}

-- NOTE:
-- vim.log.levels.DEBUG vim.log.levels.ERROR vim.log.levels.INFO vim.log.levels.TRACE vim.log.levels.WARN vim.log.levels.OFF
--
