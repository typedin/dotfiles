return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp', -- Required
        {
            'williamboman/mason.nvim',
            build = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        'williamboman/mason-lspconfig.nvim', -- Required
        { 'hrsh7th/nvim-cmp', dependencies = {
            { 'roobert/tailwindcss-colorizer-cmp.nvim', config = true },
        } },
    },
}
