require("utils").load_servers{ 
    require("lsp.rust"),
    require("lsp.pylsp"),
    require("lsp.ts"),
    require("lsp.clangd"),
    require("lsp.texlab"),
    require("lsp.bash"),
}
