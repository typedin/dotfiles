return {
    'stevearc/conform.nvim',
    config = function()
        require('conform').setup({
            formatters_by_ft = {
                blade = { 'prettier' },
                css = { { 'prettierd', 'prettier' } },
                javascript = { { 'prettierd', 'prettier' } },
                json = { { 'prettierd', 'prettier' } },
                lua = { 'stylua' },
                php = { { 'phpcb', 'php_cs_fixer', 'pint' } }, -- not sure about this pint one
                python = { 'isort', 'black' },
                rust = { 'rustfmt' },
                typescript = { { 'prettierd', 'prettier' } },
                typescriptreact = { { 'prettierd', 'prettier' } },
                sh = { 'shellcheck' },
                vue = { { 'prettierd', 'prettier' } },
                ['*'] = {
                    formatters = { 'trim_whitespace', 'trim_newlines' },
                    run_all_formatters = true,
                },
            },
            format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 500,
                lsp_fallback = true,
            },
        })
    end,
    'lukas-reineke/lsp-format.nvim',
}
