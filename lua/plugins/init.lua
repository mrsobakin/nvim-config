return {
    { "ethanholz/nvim-lastplace", opts={} },
    { "j-hui/fidget.nvim", opts={} },
    { "kylechui/nvim-surround", opts={} },
    { "neovim/nvim-lspconfig" },
    { "nvim-mini/mini-git", version = "*", init = function() require("mini.git").setup() end },
    { "nvim-mini/mini.diff", version = "*", opts = {
        view = {
            style = "sign",
            signs = { add = '+', change = '~', delete = '-' },
        }
    } },
    { "numToStr/Comment.nvim" },
}
