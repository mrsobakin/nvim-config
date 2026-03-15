vim.cmd("colorscheme vim")

vim.opt.winborder = "rounded"

vim.api.nvim_set_hl(0, "SignColumn", {})
vim.api.nvim_set_hl(0, "NormalFloat", {})
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "White", ctermfg = "White"})
vim.api.nvim_set_hl(0, "Pmenu", {})

-- MiniDiff
vim.api.nvim_set_hl(0, "MiniDiffSignAdd",        { fg = "LightGreen" })
vim.api.nvim_set_hl(0, "MiniDiffSignChange",     { fg = "Yellow" })
vim.api.nvim_set_hl(0, "MiniDiffSignDelete",     { fg = "Red" })

vim.api.nvim_set_hl(0, "MiniDiffOverAdd",        { bg = "#001700" })  -- Added lines
vim.api.nvim_set_hl(0, "MiniDiffOverContextBuf", { bg = "#001700" })  -- Lines with added words
vim.api.nvim_set_hl(0, "MiniDiffOverChangeBuf",  { bg = "#005000" })  -- Added words

vim.api.nvim_set_hl(0, "MiniDiffOverDelete",     { bg = "#220000" })  -- Removed lines
vim.api.nvim_set_hl(0, "MiniDiffOverContext",    { bg = "#220000" })  -- Lines with removed words
vim.api.nvim_set_hl(0, "MiniDiffOverChange",     { bg = "#500000" })  -- Removed words

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
            [vim.diagnostic.severity.INFO ] = '󰋽 ',
            [vim.diagnostic.severity.HINT ] = ' ',
            [vim.diagnostic.severity.WARN ] = '󰀪 ',
            [vim.diagnostic.severity.ERROR] = ' ',
        }
    }
})
