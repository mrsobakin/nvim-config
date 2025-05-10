return { 
    "nvim-lualine/lualine.nvim",
    config={
        options = {
            refresh = {
                tabline = 30,
            },
            component_separators = { left = '/', right = '/'},
            section_separators = { left = '', right = ''},
        },
        sections = {
            lualine_c = {
                {
                    'filename',
                    path=1
                },
            },
        },
        tabline = {
            lualine_a = {
                {
                    "buffers",
                    mode = 0,
                    max_length = function()
                        return vim.o.columns
                    end,
                    buffers_color = {
                        active = { fg='black', bg='LightGrey' },
                        inactive = { fg='LightGrey', bg='black' },
                    },
                    symbols = {
                        alternate_file = '',
                    },
                },
            },
        },
    },
}
