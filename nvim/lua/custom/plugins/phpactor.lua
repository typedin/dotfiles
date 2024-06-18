return {
  'gbprod/phpactor.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function(_, opts)
    local phpactor = require 'phpactor'
    phpactor.setup(opts)

    vim.keymap.set('n', '<leader>pa', phpactor.rpc)
  end,
  opts = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    --[[
          the bins for the extensions are installed per projects
          eg: code/something
          composer require --dev phpstan/phpstan
    --]]
    return {
      install = {
        check_on_startup = 'always',
      },
      lspconfig = {
        enabled = true,
        options = {
          on_attach = on_attach,
          capabilities = capabilities,
          handlers = handlers,
        },
      },
    }
  end,
}
