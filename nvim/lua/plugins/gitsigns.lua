return {
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
}
