return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      }
      vim.keymap.set('n', '<localleader>gp', ':Gitsigns preview_hunk<CR>', {})
      vim.keymap.set('n', '<localleader>gt', ':Gitsigns toggle_current_line_blame<CR>', {})
    end,
  },
  {
    'tpope/vim-fugitive',
  },
  {
    'akinsho/git-conflict.nvim',
    opts = {},
  },
}
