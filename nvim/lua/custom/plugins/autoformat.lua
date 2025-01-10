return {
    {
        "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
    },
    { -- Autoformat
        "stevearc/conform.nvim",
        opts = {
            notify_on_error = false,
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
            formatters_by_ft = {
                makefile = { "cmake-format" },
                c = { "clang-format" },
                lua = { "stylua" },
                -- Conform can also run multiple formatters sequentially
                -- python = { "isort", "black" },
                --
                -- You can use a sub-list to tell conform to run *until* a formatter
                -- is found.
                jsx = { "prettierd", "prettier", "eslint" },
                tsx = { "prettierd", "prettier", "eslint" },
                javascript = { "prettierd", "prettier", "eslint" },
                php = { "pint", "php-cs-fixer" },
                blade = { "blade-formatter" },
            },
            formatters = {
                ["php-cs-fixer"] = {
                    command = "php-cs-fixer",
                    args = {
                        "fix",
                        "--rules=@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
                        "$FILENAME",
                    },
                    stdin = false,
                },
            },
        },
    },
}
