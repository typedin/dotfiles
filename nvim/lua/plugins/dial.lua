return {
    'monaqa/dial.nvim',
    keys = {
        -- n is the default
        { '<C-a>', mode = 'n', ':DialIncrement<cr>' },
        { '<C-x>', mode = 'n', ':DialDecrement<cr>' },
        { '<C-a>', mode = 'v', ':DialIncrement<cr>' },
        { '<C-x>', mode = 'v', ':DialDecrement<cr>' },
        { 'g<C-a>', mode = 'v', ':DialIncrement<cr>' },
        { 'g<C-x>', mode = 'v', ':DialDecrement<cr>' },
    },
}
