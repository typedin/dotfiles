local signs = require 'typedin.signs'
return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    vim.fn.sign_define('DiagnosticSignError', { text = signs.error, texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = signs.warn, texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = signs.info, texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = signs.hint, texthl = 'DiagnosticSignHint' })
  end,
  keys = {
    {
      '<Leader>e',
      ':Neotree toggle left<cr>',
      desc = 'Neotree',
    },
    {
      '<Leader>b',
      ':Neotree source=buffers toggle position=float<cr>',
      desc = 'Neotree opened buffers in a floating window',
    },
  },
  opts = {
    window = {
      mappings = {
        ['<cr>'] = 'open',
      },
      position = 'left',
      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true, -- only works on Windows for hidden files/directories
          hide_by_name = {
            'node_modules',
            'vendor',
          },
          hide_by_pattern = { -- uses glob style patterns
            '*.meta',
            '*.cache',
          },
          never_show = { -- remains hidden even if visible is toggled to true
            '*.un~',
            '*.*.un~',
          },
        },
        '.DS_Store',
        'thumbs.db',
      },
    },
  },
}
