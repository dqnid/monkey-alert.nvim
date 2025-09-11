local ns = vim.api.nvim_create_namespace('line_blame');

local clearBlame = function()
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

local setNvimMark = function(line_number, blame_text, blame_highlight, blame_position)
    vim.api.nvim_buf_set_extmark(0, ns, line_number, 0, {
        id = line_number + 1, -- cant be 0
        virt_text = { { blame_text, blame_highlight } },
        virt_text_pos = blame_position,
        priority = 1004,
        hl_mode = 'combine',
    })
end

local lineBlame = function(input_file_path, line_number, input_comma_separated_mail_list, blame_text, blame_highlight,
                           blame_position)
    local handler = io.popen("git blame -L " .. line_number .. "," .. line_number .. " -e " ..
        input_file_path .. " | awk '{print $2}'")
    if handler == nil then
        return nil
    end

    local result = handler:read("L")

    if result == nil then
        return nil
    end

    local mail = string.match(result, "%(<(.+)>")

    if not mail then
        return nil
    end

    for target_mail in string.gmatch(input_comma_separated_mail_list, "[^,]+") do
        if target_mail == mail then
            setNvimMark(tonumber(line_number), blame_text, blame_highlight, blame_position)
        end
    end
end

-- lineBlame
--  does everything the plugin needs xd
-- @param blame_highlight: 'Normal'
-- @param blame_position: 'eol' | 'overlay' | 'right_align'
local fileBlame = function(input_file_path, input_comma_separated_mail_list, blame_text, blame_highlight, blame_position)
    local handler = io.popen("git blame -e " .. input_file_path .. " | awk '{print $2$6}'")

    if handler == nil then
        return nil
    end

    local result = handler:read("L")
    while result do
        for current_line_mail, line_number in string.gmatch(result, "%(<(.+)>(%d+)%)") do
            for target_mail in string.gmatch(input_comma_separated_mail_list, "[^,]+") do
                if target_mail == current_line_mail then
                    setNvimMark(tonumber(line_number) - 1, blame_text, blame_highlight, blame_position)
                end
            end
        end
        result = handler:read("L")
    end
    handler:close()
end

return {
    clearBlame = clearBlame,
    lineBlame = lineBlame,
    fileBlame = fileBlame,
}
