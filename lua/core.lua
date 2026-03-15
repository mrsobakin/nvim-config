-- Sign column
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Indents
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Don't continue comments on o/O/<Enter>
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "r", "o" })
    end,
})

-- Misc
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.matchpairs = vim.opt.matchpairs + "<:>"
