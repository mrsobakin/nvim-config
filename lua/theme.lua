vim.cmd(":colorscheme vim")

vim.opt.winborder = "rounded"

vim.api.nvim_set_hl(0, "SignColumn", { bg = NONE, ctermbg = NONE })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = NONE, ctermbg = NONE })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "White", ctermfg = "White", bg = NONE, ctermbg = NONE })
vim.api.nvim_set_hl(0, "Pmenu", { bg = NONE, ctermbg = NONE })

-- MiniDiff signs
vim.api.nvim_set_hl(0, "MiniDiffSignAdd",    { fg = "LightGreen" })
vim.api.nvim_set_hl(0, "MiniDiffSignChange", { fg = "Yellow" })
vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { fg = "Red" })

-- Status Line
vim.api.nvim_set_hl(0, "StatusLine", { fg = "Grey", reverse=false })
vim.api.nvim_set_hl(0, "StatusLineNC", { reverse=false })
vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal",  { fg = "Black", bg = "#a9a9a9", bold = true })
vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert",  { fg = "Black", bg = "#ffa0a0", bold = true })
vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual",  { fg = "Black", bg = "#ffa500", bold = true })
vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { fg = "Black", bg = "#ffa0a0", bold = true })
vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { fg = "Black", bg = "#40ffff", bold = true })
vim.api.nvim_set_hl(0, "MiniStatuslineModeOther",   { fg = "Black", bg = "#40ffff", bold = true })

-- Tab Line
vim.api.nvim_set_hl(0, "TabLine",       { fg = "White", bg = "Black" })
vim.api.nvim_set_hl(0, "TabLineSel",    { fg = "Black", bg = "White" })
vim.api.nvim_set_hl(0, "TabLineMod",    { fg = "White", bg = "Black", bold = true })
vim.api.nvim_set_hl(0, "TabLineSelMod", { fg = "Black", bg = "White", bold = true })
vim.api.nvim_set_hl(0, "TabLineFill",   { reverse=false })

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.INFO ] = '¡ ',
            [vim.diagnostic.severity.HINT ] = ' ',
            [vim.diagnostic.severity.WARN ] = '󰀪 ',
            [vim.diagnostic.severity.ERROR] = ' ',
        }
    }
})
