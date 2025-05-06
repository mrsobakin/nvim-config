local lsp_enable = function(servers)
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
    {'gopls', {
        settings = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    }},
    'lua_ls',
    'pyrefly',
    {'rust_analyzer', {
        settings = {
            diagnostics = {
                enable = true,
            },
        },
    }},
    'texlab',
    'ts_ls',
    'yamlls',
})
