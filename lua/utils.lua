local M = {}


function M.init_lazy() 
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath,
        })
    end

    vim.opt.rtp:prepend(lazypath)
end


function load_server(lspconfig, server) 
    server_name = server[1]
    table.remove(server, 1)
    lspconfig[server_name].setup(server)
end


function M.load_servers(servers)
    lspconfig = require("lspconfig")

    for _, server in ipairs(servers) do
        load_server(lspconfig, server)
    end
end


return M
