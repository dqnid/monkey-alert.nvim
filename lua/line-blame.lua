local ns = vim.api.nvim_create_namespace('line-blame');
local lineBlame = function(input_file_path)
    local handler = io.popen("git blame -e " .. input_file_path .. " | awk '{ print $2$6}'")

    if handler == nil then
        return nil
    end

    local result = handler:read("L")
    while result do
        for k, v in string.gmatch(result, "%(<(.+)>(%d+)%)") do
            -- print(input_file_path, k, v)
            local extid = vim.api.nvim_buf_set_extmark(0, ns, tonumber(v), 0, { end_row = tonumber(v), end_col = 30 ,virt_text = {[ "test", "WildMenu"]}})
        end
        result = handler:read("L")
    end
    handler:close()
end

-- lineBlame("./README.md")

return {
    lineBlame = lineBlame,
}
