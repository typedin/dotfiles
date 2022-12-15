local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    -- Packer can manage itself
    use { "wbthomason/packer.nvim", config = require "typedin.config.packer" }
    use "lewis6991/impatient.nvim"

    -- LSP
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    }
    use {
        "neovim/nvim-lspconfig",
        "nvim-lua/lsp-status.nvim",
        --[[ "jose-elias-alvarez/null-ls.nvim", ]]
    }
    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig",
    }
    use {
        "kkoomen/vim-doge",
        run = ":call doge#install()",
    }
    use {
        "ThePrimeagen/refactoring.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
        },
    }

    -- TreeSitter
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = require "typedin.config.nvim-treesitter" }
    use "p00f/nvim-ts-rainbow"

    -- comment
    use "numToStr/Comment.nvim"
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- formatting
    use "cappyzawa/trim.nvim"
    --[[ use "jose-elias-alvarez/null-ls.nvim" ]]
    use "mhartington/formatter.nvim"

    -- editorconfig
    use "editorconfig/editorconfig-vim"

    -- fuzzy
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            {
                "nvim-lua/plenary.nvim",
                "nvim-lua/popup.nvim",
                "nvim-telescope/telescope-file-browser.nvim",
                "nvim-telescope/telescope-fzf-writer.nvim",
                "nvim-telescope/telescope-fzy-native.nvim",
                "nvim-telescope/telescope-hop.nvim",
                "nvim-telescope/telescope-packer.nvim",
                "nvim-telescope/telescope-rs.nvim",
                "nvim-telescope/telescope-smart-history.nvim",
                "nvim-telescope/telescope-symbols.nvim",
                "nvim-telescope/telescope-ui-select.nvim",
            },
        },
    }

    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = require "typedin.config.neotree",
    }

    use "andymass/vim-matchup"
    use "christoomey/vim-tmux-navigator"
    use "tpope/vim-surround"
    use {
        "cshuaimin/ssr.nvim",
        module = "ssr",
        -- Calling setup is optional.
        config = require "typedin.config.ssr",
    }
    --[[ use "wincent/scalpel" ]]

    -- navigation
    use "tpope/vim-projectionist"
    use {
        "phaazon/hop.nvim",
        branch = "v2", -- optional but strongly recommended
    }

    -- Quickfix enhancements. See :help vim-qf
    use { "kevinhwang91/nvim-bqf", ft = "qf" }

    -- terminal
    use { "akinsho/toggleterm.nvim", tag = "v2.*" }
    -- TODO
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
    }
    -- GIT
    use "tpope/vim-fugitive"
    use {
        "tanvirtin/vgit.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    }

    -- autopair
    use "windwp/nvim-autopairs"

    -- Better increment/decrement
    use "triglav/vim-visual-increment"
    use "monaqa/dial.nvim"
    use "nguyenvukhang/nvim-toggler"

    -- eye candy
    use "machakann/vim-highlightedyank"
    use { "NvChad/nvim-colorizer.lua", config = require "typedin.config.nvim-colorizer" }
    use {
        "mvllow/modes.nvim",
        tag = "v0.2.0",
        config = require "typedin.config.modes",
    }

    use { "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" }
    use "onsails/lspkind-nvim"
    use {
        "declancm/windex.nvim",
        config = require "typedin.config.windex",
    }
    use "rebelot/kanagawa.nvim"
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    }

    -- syntax highlighting
    use "matthewbdaly/vim-statamic-antlers"
    use "jwalton512/vim-blade"

    -- tdd
    use "neomake/neomake"
    use "kana/vim-vspec"
    use "vim-test/vim-test"

    -- debugging
    use "puremourning/vimspector"

    -- markdown
    use { "shime/vim-livedown", requires = {
        "preservim/vimux",
    } }

    -- php
    -- phpactor should not be used as lsp server
    -- I use intelephense
    use {
        "gbprod/phpactor.nvim",
        --[[ run = require "phpactor.handler.update", -- To install/update phpactor when installing this plugin ]]
        requires = {
            "nvim-lua/plenary.nvim", -- required to update phpactor
            "neovim/nvim-lspconfig", -- required to automaticly register lsp serveur
        },
        config = require "typedin.config.phpactor",
    }

    -- rust
    use "simrat39/rust-tools.nvim"

    -- completion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            "onsails/lspkind.nvim",
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
        },
    }

    use {
        "folke/lsp-trouble.nvim",
        cmd = "Trouble",
        config = require "typedin.config.lsp-trouble",
    }

    -- GIT:
    use "TimUntersberger/neogit"

    -- Github integration
    if vim.fn.executable "gh" == 1 then
        use "pwntester/octo.nvim"
    end
    use "ruifm/gitlinker.nvim"

    -- Sweet message committer
    use "rhysd/committia.vim"
    use "sindrets/diffview.nvim"

    -- Floating windows are awesome :)
    use { "rhysd/git-messenger.vim", keys = "<Plug>(git-messenger)" }

    -- productivity
    use "mizlan/iswap.nvim"

    use {
        "phaazon/mind.nvim",
        branch = "v2",
        requires = { "nvim-lua/plenary.nvim" },
    }
    -- logging
    use "tjdevries/vlog.nvim"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
