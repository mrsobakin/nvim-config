local utils = require("utils")

local function concat_nonnil(tbl, separator)
    return table.concat(
        vim.tbl_filter(
            function(x) return x ~= nil end,
            tbl
        ),
        separator
    )
end

local function get_sections()
    local MiniStatusline = require('mini.statusline')

    local M = {}

    function M.git()
        local git = vim.b.minigit_summary
        if not git then return nil end

        return ' ' .. (git.head_name or "[UNKNOWN]")
    end

    function M.diff(parent_hl)
        local diff = vim.b.minidiff_summary
        if not diff then return nil end

        local parts = {}

        if (diff.add or 0) > 0 then
            table.insert(parts, "%#MiniDiffSignAdd#+" .. diff.add)
        end
        if (diff.change or 0) > 0 then
            table.insert(parts, "%#MiniDiffSignChange#~" .. diff.change)
        end
        if (diff.delete or 0) > 0 then
            table.insert(parts, "%#MiniDiffSignDelete#-" .. diff.delete)
        end

        if #parts == 0 then return nil end

        return table.concat(parts, " ") .. "%#" .. parent_hl .. "#"
    end

    function M.diagnostics(parent_hl)
        local diag = vim.trim(MiniStatusline.section_diagnostics({icon = ""}))

        if #diag == 0 then return nil end

        diag = diag:gsub("[HIWE]", {
            ["H"] = "%#DiagnosticHint#"  .. "󰋽 ",
            ["I"] = "%#DiagnosticInfo#"  .. " ",
            ["W"] = "%#DiagnosticWarn#"  .. "󰀪 ",
            ["E"] = "%#DiagnosticError#" .. " ",
        })

        return diag .. "%#" .. parent_hl .. "#"
    end

    function M.filetype(parent_hl)
        local devicons = require("nvim-web-devicons")

        local icon, icon_hl = devicons.get_icon(vim.fn.expand('%:t'), nil, { default = true })
        if icon == nil then
            icon, icon_hl = devicons.get_icon_by_filetype(vim.bo.filetype)
        end

        if icon_hl == nil then icon_hl = 'DevIconDefault' end

        icon_hl = utils.blend_hl(parent_hl, icon_hl)

        local filetype = vim.bo.filetype
        if #filetype == 0 then filetype = "Unknown" end

        return string.format('%%#%s#%s%%#%s# %s', icon_hl, icon, parent_hl, filetype)
    end

    function M.encoding()
        local text = vim.bo.fileencoding or vim.bo.encoding
        if #text then return nil end
        return text
    end

    function M.format()
        local format = vim.bo.fileformat

        return ({
            unix = '',
            dos = '',
            mac = '',
        })[format] or format
    end

    function M.filesize()
        local size = math.max(vim.fn.line2byte(vim.fn.line('$') + 1) - 1, 0)
        if size < 1024 then
            return string.format('%dB', size)
        elseif size < 1048576 then
            return string.format('%.2fKiB', size / 1024)
        else
            return string.format('%.2fMiB', size / 1048576)
        end
    end

    return M
end

return {
    "nvim-mini/mini.statusline",
    opts = function()
        local MiniStatusline = require('mini.statusline')
        local sections = get_sections()

        local content = function()
            local groups = {}

            -- Mode section
            local mode, mode_hl = MiniStatusline.section_mode({})
            table.insert(groups, { hl = mode_hl, strings = { mode } })

            -- Smart section
            table.insert(groups, { hl = "StatusLine", strings = {
                concat_nonnil({
                    sections.git(),
                    sections.diff("StatusLine"),
                    sections.diagnostics("StatusLine"),
                }, " / ")
            }})

            -- Delimiter
            table.insert(groups, "%<")

            -- Filename
            table.insert(groups, { hl = nil, strings = { MiniStatusline.section_filename({}) } })

            -- Delimiter
            table.insert(groups, "%=")

            -- File info
            table.insert(groups, { hl = nil, strings = {
                concat_nonnil({
                    sections.filetype("StatusLine"),
                    sections.encoding(),
                    sections.format(),
                    sections.filesize(),
                }, " / ")
            }})

            -- Line:col
            table.insert(groups, { hl = mode_hl, strings = { '%l:%v' } })

            return MiniStatusline.combine_groups(groups)
        end

        return {
            content = {
                active = content,
                inactive = content,
            }
        }
    end
}
