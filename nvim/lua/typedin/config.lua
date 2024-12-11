local signs = require("typedin.signs")

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

vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
        local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor",
        }
        vim.diagnostic.open_float(nil, opts)
    end,
})
