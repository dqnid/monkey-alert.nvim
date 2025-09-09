local lineBlame = function(input_file_path, comma_separated_mails)
    local handler = io.popen("git blame -e " .. input_file_path .. " | awk '{ print $2$6}'")

    if handler == nil then
        return nil
    end

    local result = handler:read("L")
    while result do
        for k, v in string.gmatch(result, "%(<(.+)>(%d+)%)") do
            print(k)
            print(v)
        end
        result = handler:read("L")
    end
    handler:close()
end

-- lineBlame("./README.md")

return {
    lineBlame = lineBlame,
}
