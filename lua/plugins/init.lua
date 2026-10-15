return {
    { "ethanholz/nvim-lastplace", opts={} },
    { "j-hui/fidget.nvim", opts={} },
    { "kylechui/nvim-surround", opts={} },
    { "neovim/nvim-lspconfig" },
    { "nvim-mini/mini-git", main = "mini.git", opts = {} },
    { "numToStr/Comment.nvim" },
    {
        "leafOfTree/vim-svelte-plugin",
        ft = "svelte",
        init = function()
            vim.g.vim_svelte_plugin_use_typescript = 1
        end,
    },
}
