local map = function(modes, lhs, rhs, desc_or_opts)
    local modes_table = {}
    for i = 1, #modes do
        modes_table[i] = modes:sub(i, i)
    end

    local opts = desc_or_opts
    if type(desc_or_opts) ~= "table" then
        opts = {
            desc = desc_or_opts,
            noremap = true,
            silent = true,
        }
    end

    vim.keymap.set(modes_table, lhs, rhs, opts)
end

local cabbrev = function(alias, original)
    vim.cmd.cabbrev({ alias, "<c-r>=((getcmdtype()==':' && getcmdpos()==1) ? '" .. original .. "' : '" .. alias .. "')<CR>" })
end

-- Misc
map("n", "ZA", ":%y+<CR>", "Copy everything into system buffer")
map("n", "<F5>", ":term make run<CR>")

-- Mistypes
map("vni", "<F1>", "<Esc>")
map("vn", "<Space>", "<Nop>")
map("vn", ";", ":")
cabbrev("W", "w")

-- Navigation in insert mode
map("ni", "<C-h>", "<Left>")
map("ni", "<C-j>", "<Down>")
map("ni", "<C-k>", "<Up>")
map("ni", "<C-l>", "<Right>")

-- Buffer navigation
map("vn", "<A-k>", ":bn<CR>", "Next buffer")
map("vn", "<A-j>", ":bp<CR>", "Previous buffer")

-- Searching
map("n", "<Esc>", ":noh<CR>")
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "*", function()
    vim.opt.hlsearch = true
    word = vim.fn.expand('<cword>')
    vim.fn.setreg("/", word)
end)

-- LSP / Global
map("n", "<Space>e", vim.diagnostic.open_float, "Floating diagnostics")
map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
map("n", "<Space>q", vim.diagnostic.setloclist)

-- LSP / Buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }

        -- Jumps
        map("n", "gD", vim.lsp.buf.declaration, opts)
        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "gi", vim.lsp.buf.implementation, opts)
        map("n", "gr", vim.lsp.buf.references, opts)

        -- Definitions
        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        map("n", "<Space>D", vim.lsp.buf.type_definition, opts)

        -- Actions
        map("n", "<Space>rn", vim.lsp.buf.rename, opts)
        map("n", "<Space>a", vim.lsp.buf.code_action, opts)
    end,
})
