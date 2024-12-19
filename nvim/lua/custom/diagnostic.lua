local signs = require("custom.signs")

vim.diagnostic.config({
    float = {
        source = "always", -- Or "if_many"
        scope = "cursor", -- {scope} ('line'|'buffer'|'cursor'|'c'|'l'|'b', default: line) Show diagnostics from the whole buffer (buffer", the current cursor line (line), or the current cursor position (cursor). Shorthand versions are also accepted (c for cursor, l for line, b for buffer).
    },
    severity_sort = true,
    signs = {
        linehl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
        },
        text = {
            [vim.diagnostic.severity.ERROR] = signs.error,
            [vim.diagnostic.severity.HINT] = signs.hint,
            [vim.diagnostic.severity.INFO] = signs.info,
            [vim.diagnostic.severity.WARN] = signs.warn,
        },
    },
    underline = true,
    update_in_insert = false,
    virtual_text = false,
})
