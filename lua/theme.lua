vim.cmd(":colorscheme vim")

vim.opt.winborder = "rounded"

vim.api.nvim_set_hl(0, "StatusLine", { bg = NONE, ctermbg = NONE })
vim.api.nvim_set_hl(0, "SignColumn", { bg = NONE, ctermbg = NONE })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = NONE, ctermbg = NONE })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "White", ctermfg = "White", bg = NONE, ctermbg = NONE })
vim.api.nvim_set_hl(0, "Pmenu", { bg = NONE, ctermbg = NONE })

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.INFO ] = '¡ ',
            [vim.diagnostic.severity.HINT ] = ' ',
            [vim.diagnostic.severity.WARN ] = '⚠ ',
            [vim.diagnostic.severity.ERROR] = ' ',
        }
    }
})
