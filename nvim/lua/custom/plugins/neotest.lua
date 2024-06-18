return {
  {
    'nvim-neotest/neotest',
    opt = {},
    requires = {
      'nvim-neotest/neotest-go',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'marilari88/neotest-vitest',
      'olimorris/neotest-phpunit',
      'nvim-neotest/neotest-go',
    },
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace 'neotest'
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)
      require('neotest').setup {
        adapters = {
          require 'neotest-go' {},
          require 'neotest-vitest' {},
          require 'neotest-phpunit' {},
        },
      }
      vim.keymap.set('n', 'tn', "<cmd>lua require('neotest').run.run()<CR>", { desc = '[T]est [N]earest' })
      vim.keymap.set('n', 'tf', "<cmd>lua require('neotest').run.run(vim.fn.expand '%')<CR>", { desc = '[T]est [F]ile' })
    end,
  },
}
