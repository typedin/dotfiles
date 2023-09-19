return {
    {
        'L3MON4D3/LuaSnip', -- this is the engine
        version = '2.*',
        build = 'make install_jsregexp',
        init = function()
            require('luasnip.loaders.from_vscode').lazy_load({ paths = { '~/.config/nvim/snippets/' } })
            -- Navigate between snippet placeholder
            local luasnip = require('luasnip')
            vim.keymap.set({ 'i', 's' }, '<Tab>', function()
                luasnip.jump(1)
            end, { silent = true })
            vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
                luasnip.jump(-1)
            end, { silent = true })
        end,
        dependencies = {
            {
                'hrsh7th/nvim-cmp',--[[ Required ]]
                config = function()
                    local cmp = require('cmp')
                    local cmp_select = { behavior = cmp.SelectBehavior.Select }
                    cmp.setup({
                        preselect = cmp.PreselectMode.First,
                        snippet = {
                            expand = function(args)
                                require('luasnip').lsp_expand(args.body)
                            end,
                        },
                        window = {
                            completion = cmp.config.window.bordered({
                                winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
                            }),
                            documentation = cmp.config.window.bordered({
                                winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
                            }),
                        },
                        sources = {
                            { name = 'nvim_lsp' },
                            { name = 'nvim_lua' },
                            { name = 'luasnip' },
                            { name = 'buffer' },
                            { name = 'path' },
                            { name = 'calc' },
                        },
                        mapping = {
                            -- `Enter` key to confirm completion
                            ['<CR>'] = cmp.mapping.confirm({ select = true }),
                            ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
                            ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
                        },
                    })
                end,
            },
            'hrsh7th/cmp-nvim-lsp', -- Required
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
            'derektata/lorem.nvim',
        },
    },
}
