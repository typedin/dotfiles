vim.cmd([[
    let g:gitblame_date_format = '%d-%m-%y (%H:%M)' 
    let g:gitblame_message_template = ' <summary> • <date> • <author>'
]])

return {
    'akinsho/git-conflict.nvim',
    config = function()
        require('git-conflict').setup()
    end,
}
