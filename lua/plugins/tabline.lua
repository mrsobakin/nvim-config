local utils = require("utils")

return {
    "mrsobakin/mini.tabline",
    opts = function()
        local devicons = require("nvim-web-devicons")

        local function format(tab)
            local icon, icon_hl = devicons.get_icon(vim.fn.fnamemodify(tab.label, ':t'), nil, { default = true })
            if not icon_hl then icon_hl = 'DevIconDefault' end

            local hl
            if tab.is_active then
                if tab.is_modified then
                    hl = 'TabLineSelMod'
                    icon_hl = 'TabLineSel'
                else
                    hl = 'TabLineSel'
                    icon_hl = 'TabLineSel'
                end
            else
                if tab.is_modified then
                    hl = 'TabLineMod'
                    icon_hl = utils.blend_hl("TabLine", icon_hl)
                else
                    hl = 'TabLine'
                    icon_hl = utils.blend_hl(hl, icon_hl)
                end
            end

            if tab.is_modified then
                tab.label = "*" .. tab.label
            end

            return {
                { text = ' ', hl = hl },
                { text = icon, hl = icon_hl },
                { text = ' ', hl = hl },
                { text = tab.label, hl = nil },
                { text = ' ', hl = nil },
            }
        end

        return {
            format = format,
        }
    end,
}
