return {
    dir = "/home/sbkn/git/multilayout.nvim",
    config = {
        layouts = {
            ru = {
                names = { "Russian" },
                from  = [[ёйцукенгшщзхъфывапролджэячсмитьбю.Ё"№;:?ЙЦУКЕНГШЩЗХЪ/ФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,]],
                to    = [[`qwertyuiop[]asdfghjkl;'zxcvbnm,./~@#$^&QWERTYUIOP{}|ASDFGHJKL:"ZXCVBNM<>?]],
            }
        },
        aliases = {
            max_length = 2,
            extra = { "sort" },
        },
        use_libukb = true,
    },
    dev = {true}
}
