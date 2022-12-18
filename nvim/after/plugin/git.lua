require('gitsigns').setup({
    signcolumn = true,
})

vim.cmd([[
   let g:gitblame_date_format = '%d-%m-%y (%H:%M)' 
    let g:gitblame_message_template = ' <summary> • <date> • <author>'
]])
