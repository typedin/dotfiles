local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')

  -- navigation
  use({
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = {
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
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
  })
  use({
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
  })
  use('tpope/vim-projectionist')
  use({
    'phaazon/hop.nvim',
    branch = 'v2', --optional but strongly recommended
  })
  use('christoomey/vim-tmux-navigator')

  -- Treesitter
  use({ 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } })

  -- Visuals
  use('rebelot/kanagawa.nvim')
  use('andymass/vim-matchup')
  use('machakann/vim-highlightedyank')
  use('NvChad/nvim-colorizer.lua')
  use({ 'mvllow/modes.nvim', tag = 'v0.2.0' })
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'SmiteshP/nvim-navic', 'kyazdani42/nvim-web-devicons', opt = true },
  })

  -- php
  use('gbprod/phpactor.nvim')
  --
  -- tdd
  use('neomake/neomake')
  use('kana/vim-vspec')
  use('vim-test/vim-test')
  use('preservim/vimux')

  -- Git
  use('tpope/vim-fugitive')

  -- LSP
  use({
    'VonHeikemen/lsp-zero.nvim',
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
    },
  })
  use('p00f/nvim-ts-rainbow')

  -- comments
  use({
    'numToStr/Comment.nvim',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  })
  -- autopairs
  use('windwp/nvim-autopairs')

  -- increments
  use('monaqa/dial.nvim')
  use('nguyenvukhang/nvim-toggler')

  -- surround
  use('tpope/vim-surround')

  -- formatting
  use('mhartington/formatter.nvim')

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
