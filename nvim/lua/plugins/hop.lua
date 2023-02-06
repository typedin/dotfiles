return {
    'phaazon/hop.nvim',
    branch = 'v2', --optional but strongly recommended
    config = function()
        require('hop').setup()
    end,
    keys = {
        {
            '<LocalLeader>hl',
            ':HopLineStart<cr>',
        },
        {
            '<LocalLeader>hp',
            ':HopPattern<cr>',
        },
        {
            '<LocalLeader>hv',
            ':HopVertical<cr>',
        },
        {
            '<LocalLeader>hw',
            ':HopWord<cr>',
        },
    },
}
