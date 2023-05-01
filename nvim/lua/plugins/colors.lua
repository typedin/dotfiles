return {
    'gbprod/nord.nvim',
    config = function()
        require('nord').setup({
            transparent = true,
            terminal_colors = true,
            borders = true,
        })
        vim.cmd([[ colorscheme nord ]])
    end,
}
