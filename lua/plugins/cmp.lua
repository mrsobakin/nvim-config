return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
    },
    init = function()
        local cmp = require('cmp')

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            preselect = cmp.PreselectMode.None,
            completion = { completeopt = "menu,menuone,noselect" },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm(),
                -- ['<Esc>'] = function(fallback)
                --     if cmp.get_active_entry() then
                --         cmp.abort()
                --     else
                --         fallback()
                --     end
                -- end,
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                -- { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })
    end,
}
