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

vim.cmd([[
   let g:gitblame_date_format = '%d-%m-%y (%H:%M)' 
    let g:gitblame_message_template = ' <summary> • <date> • <author>'
]])

require('git-conflict').setup()

-- those are the default keumpas
vim.keymap.set('n', 'co', '<Plug>(git-conflict-ours)')
vim.keymap.set('n', 'ct', '<Plug>(git-conflict-theirs)')
vim.keymap.set('n', 'cb', '<Plug>(git-conflict-both)')
vim.keymap.set('n', 'c0', '<Plug>(git-conflict-none)')
vim.keymap.set('n', ']x', '<Plug>(git-conflict-prev-conflict)')
vim.keymap.set('n', '[x', '<Plug>(git-conflict-next-conflict)')
