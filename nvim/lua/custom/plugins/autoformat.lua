return {
    { -- Autoformat
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                notify_on_error = false,
                -- format_on_save = {
                --     timeout_ms = 500,
                --     lsp_fallback = true,
                -- },
                formatters_by_ft = {
                    makefile = { "cmake-format" },
                    c = { "clang-format" },
                    lua = { "stylua" },
                    -- Conform can also run multiple formatters sequentially
                    -- python = { "isort", "black" },
                    --
                    -- You can use a sub-list to tell conform to run *until* a formatter
                    -- is found.
                    html = { "prettier" },
                    jsx = { "prettier", "eslint" },
                    tsx = { "prettier", "eslint" },
                    javascript = { "prettier", "eslint" },
                    php = { "pint", "php-cs-fixer" },
                    blade = { "blade-formatter", "prettier" },
                },
                formatters = {
                    prettier = {
                        command = "prettier",
                        args = { "--plugin", "prettier-plugin-tailwindcss", "--stdin-filepath", "$FILENAME" },
                        cwd = require("conform.util").root_file({ ".prettierrc", ".prettierrc.json", ".prettierrc.js", "package.json" }),
                    },
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
            })
        end,
        -- opts = {
        --     notify_on_error = false,
        --     format_on_save = {
        --         timeout_ms = 500,
        --         lsp_fallback = true,
        --     },
        --     formatters_by_ft = {
        --         makefile = { "cmake-format" },
        --         c = { "clang-format" },
        --         lua = { "stylua" },
        --         -- Conform can also run multiple formatters sequentially
        --         -- python = { "isort", "black" },
        --         --
        --         -- You can use a sub-list to tell conform to run *until* a formatter
        --         -- is found.
        --         html = { "prettier" },
        --         jsx = { "prettier", "eslint" },
        --         tsx = { "prettier", "eslint" },
        --         javascript = { "prettier", "eslint" },
        --         php = { "pint", "php-cs-fixer" },
        --         blade = { "blade-formatter" },
        --     },
        --     formatters = {
        --         prettier = {
        --             command = "prettier",
        --             args = { "--plugin", "prettier-plugin-tailwindcss", "--stdin-filepath", "$FILENAME" },
        --             cwd = vim.fn.expand("<cfile>:p:h"), -- Use current file directory as the root for Prettier
        --         },
        --         ["php-cs-fixer"] = {
        --             command = "php-cs-fixer",
        --             args = {
        --                 "fix",
        --                 "--rules=@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
        --                 "$FILENAME",
        --             },
        --             stdin = false,
        --         },
        --     },
        -- },
    },
}
