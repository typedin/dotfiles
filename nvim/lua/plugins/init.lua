return {
    -- navigation
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'nvim-telescope/telescope-fzf-writer.nvim',
            'nvim-telescope/telescope-hop.nvim',
            'nvim-telescope/telescope-packer.nvim',
            'nvim-telescope/telescope-rs.nvim',
            'nvim-telescope/telescope-smart-history.nvim',
            'nvim-telescope/telescope-symbols.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
    },
    'tpope/vim-projectionist',
    {
        'phaazon/hop.nvim',
        branch = 'v2', --optional but strongly recommended
    },
    'christoomey/vim-tmux-navigator',

    -- Treesitter
    { 
        'nvim-treesitter/nvim-treesitter',
        build = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
            'nvim-treesitter/nvim-treesitter-textobjects',
        }
    } ,
    'p00f/nvim-ts-rainbow',

    -- visuals
    { 'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async' },
    'lukas-reineke/indent-blankline.nvim',
    'machakann/vim-highlightedyank',
    'NvChad/nvim-colorizer.lua',
    { 'mvllow/modes.nvim', tag = 'v0.2.0' },
    {
        'luukvbaal/statuscol.nvim',
        config = function()
            require('statuscol').setup()
        end,
    },

    -- php
    'gbprod/phpactor.nvim',

    -- tdd
    'neomake/neomake',
    'kana/vim-vspec',
    'vim-test/vim-test',
    'preservim/vimux',

    -- Git
    'tpope/vim-fugitive',
    'lewis6991/gitsigns.nvim',
    'f-person/git-blame.nvim',
     'akinsho/git-conflict.nvim',  

    -- find and replace
    'wincent/scalpel',
    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig' ,
            'williamboman/mason.nvim' ,
            'williamboman/mason-lspconfig.nvim' ,
            -- Autocompletion
            'hrsh7th/nvim-cmp', 
            'rafamadriz/friendly-snippets' ,
            'hrsh7th/cmp-buffer' ,
            'hrsh7th/cmp-path' ,
            'hrsh7th/cmp-calc' ,
            'saadparwaiz1/cmp_luasnip' ,
            'hrsh7th/cmp-nvim-lsp' ,
            'hrsh7th/cmp-nvim-lua' ,
            -- Snippets
            'L3MON4D3/LuaSnip' ,
            'rafamadriz/friendly-snippets' ,
            -- Useful status update for LSP
            'j-hui/fidget.nvim',
        },
    },

    'onsails/lspkind-nvim',

    -- syntaxt highlighting
    'matthewbdaly/vim-statamic-antlers',

    -- IDE
    -- terminal
    { "voldikss/vim-floaterm", config = function ()
        vim.g.floaterm_height = 0.3
        vim.g.floaterm_wintype = "split"
        vim.keymap.set("n", "<F2>", ":FloatermToggle<CR>")
        vim.keymap.set("t", "<F2>", "<C-\\><C-n>:FloatermToggle<CR>")
        vim.cmd([[
        highlight link Floaterm CursorLine
        highlight link FloatermBorder CursorLineBg

        set norelativenumber
        set nonumber
        ]])
    end },
    -- swap args
    'mizlan/iswap.nvim',

    -- increments
    'monaqa/dial.nvim',
    'nguyenvukhang/nvim-toggler',

    -- surround
    'tpope/vim-surround',

    -- formatting
    'mhartington/formatter.nvim',

    -- editorconfig
    'editorconfig/editorconfig-vim',
}
