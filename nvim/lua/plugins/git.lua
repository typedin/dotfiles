return {
    'tpope/vim-fugitive',
    opts = {},
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
                signcolumn = true,
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '-' },
                    changedelete = { text = '~' },
                },
            })
        end,
    },
    {
        'akinsho/git-conflict.nvim',
        opts = {},
    },
}
