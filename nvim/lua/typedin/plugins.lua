local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    -- navigation
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    }
    use "tpope/vim-projectionist"
    use {
        "phaazon/hop.nvim",
        branch = "v2", -- optional but strongly recommended
    }
    --
    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } }
    --
    -- Visuals
    use "rebelot/kanagawa.nvim"
    --
    -- eye candy
    use "machakann/vim-highlightedyank"
    use { "NvChad/nvim-colorizer.lua" }
    use {
        "mvllow/modes.nvim",
        tag = "v0.2.0",
    }
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "SmiteshP/nvim-navic", "kyazdani42/nvim-web-devicons", opt = true },
    }

    -- php
    use {
        "gbprod/phpactor.nvim",
    }
    -- Git
    use "tpope/vim-fugitive"

    -- LSP
    use { "VonHeikemen/lsp-zero.nvim",
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
    use "tpope/vim-surround"
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
