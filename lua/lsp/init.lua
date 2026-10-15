local function lsp_enable(servers, capabilities)
    for i, server in ipairs(servers) do
        if type(server) == "string" then
            vim.lsp.config(server, {
                capabilities = capabilities,
            })
        else
            local server_name, config = server[1], server[2]
            servers[i] = server_name

            config.capabilities = vim.tbl_deep_extend(
                "force",
                capabilities,
                config.capabilities or {}
            )

            vim.lsp.config(server_name, config)
        end
    end

    vim.lsp.enable(servers)
end

-- Disable snippets, because they're stupid and don't work properly
local no_snippets_capabilities = vim.lsp.protocol.make_client_capabilities()
no_snippets_capabilities.textDocument.completion.completionItem.snippetSupport = false

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
    'svelte',
    'texlab',
    'tinymist',
    'ts_ls',
    'yamlls',
}, no_snippets_capabilities)

vim.diagnostic.config{
    update_in_insert = false
}

require("lsp.completions")
require("lsp.border-hack")

-- SQL
vim.cmd("let g:omni_sql_default_compl_type = 'syntax'")
