local signs = require("custom.signs")

vim.diagnostic.config({
    virtual_text = false,
    float = {
        source = "always", -- Or "if_many"
    },
    signs = {
        text = {
            [vim.diagnostic.severity.HINT] = signs.hint,
            [vim.diagnostic.severity.ERROR] = signs.error,
            [vim.diagnostic.severity.WARN] = signs.warn,
            [vim.diagnostic.severity.INFO] = signs.info,
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
