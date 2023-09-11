return {
    'p00f/nvim-ts-rainbow',
    -- visuals
    'machakann/vim-highlightedyank',
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
        opts = {
            user_default_options = {
                tailwind = true,
            },
        },
    },

    -- Git
    'f-person/git-blame.nvim',
    'onsails/lspkind-nvim',
    -- syntaxt highlighting
    'matthewbdaly/vim-statamic-antlers',
    -- swap args
    'mizlan/iswap.nvim',
    -- increments
    'nguyenvukhang/nvim-toggler',
    -- surround
    'tpope/vim-surround',
    -- formatting
    'mhartington/formatter.nvim',
    -- editorconfig
    'editorconfig/editorconfig-vim',
}
