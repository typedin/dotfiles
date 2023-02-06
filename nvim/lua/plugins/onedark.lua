return {
    'navarasu/onedark.nvim',
    config = function()
        require('onedark').setup({
            style = 'deep',
            transparent = true,
            lualine = {
                transparent = true, -- lualine center bar transparency
            },
        })
    end,
}
