vim.cmd(":colorscheme vim")

vim.api.nvim_set_hl(0, "StatusLine", { ctermbg=NONE, bg=NONE })
vim.api.nvim_set_hl(0, "SignColumn", { ctermbg=NONE, bg=NONE })
vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg=NONE, bg=NONE })
vim.api.nvim_set_hl(0, "FloatBorder", { ctermbg=NONE, bg=NONE })
vim.api.nvim_set_hl(0, "Pmenu", { guibg=ctermbg })
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=none]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]


--    ╭─────╮   ┌─────┐
--    │     │   │     │
--    ╰─────╯   └─────┘
local border = {
    {"┌", "FloatBorder"},
    {"─", "FloatBorder"},
    {"┐", "FloatBorder"},
    {"│", "FloatBorder"},
    {"┘", "FloatBorder"},
    {"─", "FloatBorder"},
    {"└", "FloatBorder"},
    {"│", "FloatBorder"},
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

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
