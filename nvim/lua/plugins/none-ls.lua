return {
    {
        'mhartington/formatter.nvim',
    },
    {
        "lukas-reineke/lsp-format.nvim",
    },
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.blade_formatter,
                    null_ls.builtins.diagnostics.eslint_d,
                    null_ls.builtins.completion.spell,
                }
            })

            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            null_ls.setup({
                -- you can reuse a shared lspconfig on_attach callback here
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                                vim.lsp.buf.formatting_sync()
                            end,
                        })
                    end
                end,
            })
        end,
    },
    {
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
}
