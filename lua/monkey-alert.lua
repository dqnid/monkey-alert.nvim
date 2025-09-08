local blame = require("./line-blame.lua")

local defaultList = "one;two"
vim.g.monkeyMailList = defaultList
vim.g.monkeyUserList = defaultList

local function setup(opts)
    vim.g.monkeyMailList = opts.monkeyMailList
    vim.g.monkeyUserList = opts.monkeyUserList
end

local function observe()

end

return {
    setup = setup,
    observe = observe,
}

-- NOTE:
-- vim.log.levels.DEBUG vim.log.levels.ERROR vim.log.levels.INFO vim.log.levels.TRACE vim.log.levels.WARN vim.log.levels.OFF
--
