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
    'onsails/lspkind-nvim',
    -- syntaxt highlighting
    'matthewbdaly/vim-statamic-antlers',
    -- swap args
    'mizlan/iswap.nvim',
    -- increments
    'nguyenvukhang/nvim-toggler',
    -- surround
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    -- editorconfig
    'editorconfig/editorconfig-vim',
}
