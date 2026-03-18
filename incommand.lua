local function apply_keys_preview(opts, preview_ns, preview_buf)
    vim.cmd("hi clear Whitespace")

    local line1 = opts.line1
    local line2 = opts.line2
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, line1 - 1, line2, false)

    local fargs = opts.fargs
    local regexp = fargs[1]
    local keys = fargs[2]
    if keys == nil then
        regexp = ""
        keys = fargs[1]
    end

    local preview_buf_line = 0

    for i, line in ipairs(lines) do
        local start_idx = vim.fn.match(line, regexp)
        if start_idx ~= -1 then
            -- apply the keys
            local res = apply_keys(line, { col = start_idx, row = 1 }, keys)
            vim.list_extend(new_lines, res)

            -- Highlight the match
            vim.hl.range(
                buf,
                preview_ns,
                "Substitute",
                { line1 + i - 2, start_idx - 1 },
                { line1 + i - 2, start_idx }
            )

            -- Add lines and set highlights in the preview buffer
            -- if inccommand=split
            if preview_buf then
                local prefix = string.format("|%d| ", line1 + i - 1)

                vim.api.nvim_buf_set_lines(
                    preview_buf,
                    preview_buf_line,
                    preview_buf_line,
                    false,
                    { prefix .. line }
                )
                vim.hl.range(
                    preview_buf,
                    preview_ns,
                    "Substitute",
                    { preview_buf_line, #prefix + start_idx - 1 },
                    { preview_buf_line, #prefix + start_idx }
                )
                preview_buf_line = preview_buf_line + 1
            end
        end
    end

    -- Return the value of the preview type
    return 2
end

---@param line string
---@param regexp string
---@return { start: integer, finish: integer }[]
local function find_matches(line, regexp)
    local matches = {}
    local init = 0

    while true do
        local m = vim.fn.matchstrpos(line, regexp, init)
        local start_pos = m[2]
        local end_pos = m[3]

        if start_pos == -1 then
            break
        end

        table.insert(matches, { start = start_pos, finish = end_pos })
        init = math.max(end_pos, start_pos + 1)
    end

    return matches
end

---@param line string
---@param matches { start: integer, finish: integer }[]
---@param keys string
---@return string[]
local function apply_normal_at_matches(line, matches, keys)
    local cur_win = vim.api.nvim_get_current_win()

    local tmp_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(tmp_buf, 0, -1, false, { line })

    local tmp_win = vim.api.nvim_open_win(tmp_buf, false, {
        relative = "editor",
        width = math.max(vim.fn.strdisplaywidth(line), 1),
        height = 1,
        row = 0,
        col = 0,
        style = "minimal",
        focusable = false,
        noautocmd = true,
    })

    local ok, result = pcall(function ()
        vim.api.nvim_set_current_win(tmp_win)

        for i = #matches, 1, -1 do
            local m = matches[i]
            vim.api.nvim_win_set_cursor(tmp_win, { 1, m.start })
            vim.cmd.normal({ args = { keys }, bang = true })
        end

        return vim.api.nvim_buf_get_lines(tmp_buf, 0, -1, false)
    end)

    if vim.api.nvim_win_is_valid(cur_win) then
        vim.api.nvim_set_current_win(cur_win)
    end

    if vim.api.nvim_win_is_valid(tmp_win) then
        vim.api.nvim_win_close(tmp_win, true)
    end

    if vim.api.nvim_buf_is_valid(tmp_buf) then
        vim.api.nvim_buf_delete(tmp_buf, { force = true })
    end

    if not ok then
        error(result)
    end

    return result
end

local function norm_func(opts)
    local fargs = opts.fargs
    local regexp = fargs[1]
    local keys = fargs[2]

    if keys == nil then
        regexp = ""
        keys = fargs[1]
    end

    local line1 = opts.line1
    local line2 = opts.line2
    local target_buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(target_buf, line1 - 1, line2, false)

    local new_lines = {}

    for _, line in ipairs(lines) do
        local matches = find_matches(line, regexp)

        if #matches == 0 then
            table.insert(new_lines, line)
        else
            local res = apply_normal_at_matches(line, matches, keys)
            vim.list_extend(new_lines, res)
        end
    end

    vim.api.nvim_buf_set_lines(target_buf, line1 - 1, line2, false, new_lines)
end

-- test test
-- test foo
-- test bar

vim.api.nvim_create_user_command("Normal", norm_func, {
    range = "%",
    nargs = "+",
    addr = "lines",
    --[[ preview = apply_keys_preview --]]
})
