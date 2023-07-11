-- IDE
-- terminal
return {
    'voldikss/vim-floaterm',
    config = function()
        vim.g.floaterm_height = 0.3
        vim.g.floaterm_wintype = 'split'
        vim.cmd([[
            highlight link floaterm cursorline
            highlight link floatermborder cursorlinebg
            " set norelativenumber
            " set nonumber
        ]])
    end,
}
