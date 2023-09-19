return {
    'gbprod/yanky.nvim',
    config = function()
        require('yanky').setup({
            ring = {
                history_length = 100,
                storage = 'shada',
                sync_with_numbered_registers = true,
                cancel_event = 'update',
                ignore_registers = { '_' },
            },
            system_clipboard = {
                sync_with_ring = true,
            },
            highlight = {
                on_put = true,
                on_yank = true,
                timer = 100,
            },
        })
    end,
    keys = {
        { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'yanky put after' },
        { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'yanky put before' },
        { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'yanky put after' },
        { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'yanky put before' },
    },
}
