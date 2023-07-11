return {
    {
        'L3MON4D3/LuaSnip',
        version = '1.*',
        --[[ version = '1', ]]
        build = 'make install_jsregexp',
        init = function()
            require('luasnip.loaders.from_vscode').lazy_load({ paths = { '~/.config/nvim/snippets/' } })
        end,
    },
    dependencies = {
        'hrsh7th/nvim-cmp', -- Required
        'hrsh7th/cmp-nvim-lsp', -- Required
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
    },
}
