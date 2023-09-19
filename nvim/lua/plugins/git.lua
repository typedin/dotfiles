vim.cmd([[
    let g:gitblame_date_format = '%d-%m-%y (%H:%M)'
    let g:gitblame_message_template = ' <summary> • <date> • <author>'
]])
return {

    'tpope/vim-fugitive',
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
        config = function()
            require('git-conflict').setup()
        end,
    },
}
