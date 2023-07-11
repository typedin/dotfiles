return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Suppor
            { 'neovim/nvim-lspconfig', dependencies = { 'b0o/schemastore.nvim' } }, -- Required
            { -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'folke/neodev.nvim', opts = {} },
            'ThePrimeagen/refactoring.nvim',
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lua' },
            {
                'L3MON4D3/LuaSnip',
                version = '1.*',
                --[[ version = '1', ]]
                build = 'make install_jsregexp',
                dependencies = {
                    'saadparwaiz1/cmp_luasnip',
                    'rafamadriz/friendly-snippets',
                },
                config = function()
                    require('luasnip.loaders.from_vscode').lazy_load({ paths = { '~/.config/nvim/snippets/' } })
                end,
            },
        },
    },
}
