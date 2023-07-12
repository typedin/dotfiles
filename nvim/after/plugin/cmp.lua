local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
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
        ['['] = cmp.mapping.select_prev_item(cmp_select),
        [']'] = cmp.mapping.select_next_item(cmp_select),
    },
})

-- Navigate between snippet placeholder
vim.keymap.set({ 'i', 's' }, '<Tab>', function()
    luasnip.jump(1)
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
    luasnip.jump(-1)
end, { silent = true })
