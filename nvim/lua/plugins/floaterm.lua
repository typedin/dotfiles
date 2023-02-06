-- IDE
-- terminal
return {
    'voldikss/vim-floaterm',
    keys = {
        {
            mode = 'n',
            '<F2>',
            ':FloatermToggle<CR>',
        },
        {
            mode = 't',
            '<F2>',
            '<C-\\><C-n>:FloatermToggle<CR>',
        },
    },
    config = function()
        vim.g.floaterm_height = 0.3
        vim.g.floaterm_wintype = 'split'
        vim.cmd([[
            highlight link floaterm cursorline
            highlight link floatermborder cursorlinebg
            set norelativenumber
            set nonumber
        ]])
    end,
}
