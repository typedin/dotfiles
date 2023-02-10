return {
    'luukvbaal/statuscol.nvim',
    config = function()
        require('statuscol').setup({ foldfunc = 'builtin', setopt = true })
    end,
}
