return {
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
    init = function()
        -- TODO figure that out
        -- https://github.com/nvim-telescope/telescope.nvim#themes
        require('telescope').setup({
            defaults = {
                layout_config = {
                    vertical = { width = 50 },
                },
            },
            pickers = {
                find_files = {
                    theme = 'dropdown',
                },
            },
        })
        -- Me
        vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = '[G]it [F]iles' })

        -- TJ DeVries
        vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
        vim.keymap.set('n', '/', function()
            require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
                windblend = 10,
                previewer = false,
            }))
        end, { desc = '[/] Fuzzy find in current buffer' })

        vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[S]earch existing [B]uffers' })
        vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
    end,
}
