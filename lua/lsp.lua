local function lsp_enable(servers)
    for i, server in ipairs(servers) do
        if type(server) == "string" then
            vim.lsp.config(server, {})
        else
            local server, config = server[1], server[2]
            servers[i] = server
            vim.lsp.config(server, config)
        end
    end
    vim.lsp.enable(servers)
end

lsp_enable({
    'bashls',
    'clangd',
    {
        'gopls', {
            settings = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
                gofumpt = true,
            },
        }
    },
    'kotlin_lsp',
    'lua_ls',
    'pyrefly',
    {
        'rust_analyzer', {
            settings = {
                diagnostics = {
                    enable = true,
                },
            },
        }
    },
    'texlab',
    'ts_ls',
    'yamlls',
})

vim.diagnostic.config{
    update_in_insert = true
}

-- Autocomplete
vim.opt.autocomplete = false  -- for now...
vim.opt.complete:append('o')
vim.opt.completeopt = { 'menuone', 'noselect', 'popup' }

-- TODO REMOVE: lsp borders hack
-- https://github.com/neovim/neovim/issues/38248
(function()
    -- Add a rounded border to all LSP floating windows (hover, signature help)
    local orig_open_floating_preview = vim.lsp.util.open_floating_preview
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        return orig_open_floating_preview(contents, syntax, opts, ...)
    end

    local function set_popup_border(winid)
        if winid and winid >= 0 and vim.api.nvim_win_is_valid(winid) then
            pcall(vim.api.nvim_win_set_config, winid, { border = "rounded" })
        end
    end

    -- Case 1: item already has `info` — popup is created by C code before CompleteChanged
    -- Lua callbacks fire; grab preview_winid after yielding to the event loop.
    vim.api.nvim_create_autocmd("CompleteChanged", {
        group = vim.api.nvim_create_augroup("CompletionPopupBorder", { clear = true }),
        callback = function()
            vim.schedule(function()
                local info = vim.fn.complete_info({ "selected" })
                set_popup_border(info.preview_winid)
            end)
        end,
    })

    -- Case 2: async LSP completionItem/resolve — popup is created via nvim__complete_set
    -- after a network round-trip, long after CompleteChanged has already fired.
    if vim.api.nvim__complete_set then
        local orig = vim.api.nvim__complete_set
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.api.nvim__complete_set = function(index, opts)
            local windata = orig(index, opts)
            set_popup_border(windata and windata.winid)
            return windata
        end
    end
end)()
