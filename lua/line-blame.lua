local ns = vim.api.nvim_create_namespace('line_blame');

local lineBlame = function(input_file_path, input_comma_separated_mail_list, blame_text, blame_highlight, blame_position)
end

-- lineBlame
--  does everything the plugin needs xd
-- @param blame_highlight: 'Normal'
-- @param blame_position: 'eol' | 'overlay' | 'right_align'
local fileBlame = function(input_file_path, input_comma_separated_mail_list, blame_text, blame_highlight, blame_position)
    local handler = io.popen("git blame -e " .. input_file_path .. " | awk '{ print $2$6}'")

    if handler == nil then
        return nil
    end

    local result = handler:read("L")
    while result do
        for current_line_mail, line_number in string.gmatch(result, "%(<(.+)>(%d+)%)") do
            for target_mail in string.gmatch(input_comma_separated_mail_list, "[^,]+") do
                if target_mail == current_line_mail then
                    vim.api.nvim_buf_set_extmark(0, ns, tonumber(line_number) - 1, 0, {
                        id = tonumber(line_number),
                        virt_text = { { blame_text, blame_highlight } },
                        virt_text_pos = blame_position,
                        priority = 700,
                        hl_mode = 'combine',
                    })
                end
            end
        end
        result = handler:read("L")
    end
    handler:close()
end

return {
    lineBlame = lineBlame,
    fileBlame = fileBlame,
}
