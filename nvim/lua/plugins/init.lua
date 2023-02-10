return {
    'christoomey/vim-tmux-navigator',

    'p00f/nvim-ts-rainbow',

    -- visuals
    'machakann/vim-highlightedyank',
    'NvChad/nvim-colorizer.lua',

    -- tdd
    'neomake/neomake',
    'kana/vim-vspec',
    'vim-test/vim-test',
    'preservim/vimux',

    -- Git
    'f-person/git-blame.nvim',

    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'rafamadriz/friendly-snippets',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            -- Snippets
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
            -- Useful status update for LSP
            'j-hui/fidget.nvim',
            -- json schema
            'b0o/SchemaStore.nvim',
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
    'tpope/vim-surround',

    -- formatting
    'mhartington/formatter.nvim',

    -- editorconfig
    'editorconfig/editorconfig-vim',
}
