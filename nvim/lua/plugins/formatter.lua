return {
    'stevearc/conform.nvim',
    event = {
        'BufReadPre',
        'BufNewFile',
    },
    config = function()
        local conform = require('conform')
        conform.setup({
            formatters_by_ft = {
                blade = { 'blade-formatter' },
                css = { { 'prettierd', 'prettier' } },
                javascript = { { 'prettierd', 'prettier' } },
                json = { { 'prettierd', 'prettier' } },
                lua = { 'stylua' },
                php = { { 'phpcb', 'php_cs_fixer', 'pint' } }, -- not sure about this pint one
                python = { 'isort', 'black' },
                rust = { 'rustup' },
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
                async = false,
                timeout_ms = 500,
                lsp_fallback = true,
            },
            vim.keymap.set({ "n", "v" }, "<LocalLeader>mp", function()
                conform.format({
                    async = false,
                    timeout_ms = 500,
                    lsp_fallback = true,
                })
            end, { desc = "Format file or range (in visual mode)" })
        })
    end,
    'lukas-reineke/lsp-format.nvim',
}
