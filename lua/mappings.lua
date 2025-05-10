vim.keymap.set("n", "ZA", ":%y+<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "i" }, "<F1>", "<Esc>")

vim.keymap.set({ "n", "i" }, "<C-h>", "<Left>")
vim.keymap.set({ "n", "i" }, "<C-j>", "<Down>")
vim.keymap.set({ "n", "i" }, "<C-k>", "<Up>")
vim.keymap.set({ "n", "i" }, "<C-l>", "<Right>")

vim.keymap.set("n", "<A-j>", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<A-k>", ":bn<CR>", { silent = true })

vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", ";", ":", { noremap = true })
vim.cmd.cabbrev({ "W", "<c-r>=((getcmdtype()==':' && getcmdpos()==1) ? 'w' : 'W')<CR>" })


vim.keymap.set("n", "<Esc>", ":noh<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "n", "nzz", { silent = true })
vim.keymap.set("n", "N", "Nzz", { silent = true })
vim.keymap.set("n", "*", function()
    vim.opt.hlsearch = true
    word = vim.fn.expand('<cword>')
    vim.fn.setreg("/", word)
end, { silent = true })

--- Lsp

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<Space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<Space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<Space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<Space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<Space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<Space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<Space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<Space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<Space>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


