return {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        vim.diagnostic.config({
            virtual_text = false,
            underline = true,
            signs = true,
        })
    end,
    opts = {
        icons = false,
        fold_open = 'v', -- icon used for open folds
        fold_closed = '>', -- icon used for closed folds
        indent_lines = false, -- add an indent guide below the fold icons
        signs = {
            -- icons / text used for a diagnostic
            error = require('typedin.signs').error,
            hint = require('typedin.signs').hint,
            information = require('typedin.signs').info,
            warn = require('typedin.signs').warn,
        },
        use_diagnostic_signs = false,
    },
}
