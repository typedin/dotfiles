-- See `:help lua-guide-autocommands`
-- disable copilot by default
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("Copilot disable")
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        -- WARNING chatgpted this
        local ignore_file = vim.fn.getcwd() .. "/.ignoreautoformat"
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(args.buf), ":t")
        -- Read .ignoreautoformat and check if filename is in it
        local ignore_list = {}
        local f = io.open(ignore_file, "r")
        if f then
            for line in f:lines() do
                ignore_list[line] = true
            end
            f:close()
        end
        -- If the file is in .ignoreautoformat, don't format
        if ignore_list[filename] then
            vim.notify("\nFile is ignored from auto format autocommand.", vim.log.levels.INFO)
            return
        end
        -- end WARNING chatgpted this
        require("conform").format({ bufnr = args.buf, timeout_ms = 500, lsp_fallback = true })
    end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Make all splits the same width when moving back to neovim after losing focus
-- Variable to store the cursor position
local last_cursor_pos = nil

-- Autocommand group
vim.api.nvim_create_augroup("FocusGroup", { clear = true })

-- Save cursor position when Neovim loses focus
vim.api.nvim_create_autocmd("FocusLost", {
    group = "FocusGroup",
    callback = function()
        last_cursor_pos = vim.api.nvim_win_get_cursor(0)
    end,
})

-- Restore cursor position and adjust window splits when Neovim gains focus
vim.api.nvim_create_autocmd("FocusGained", {
    group = "FocusGroup",
    callback = function()
        if last_cursor_pos then
            vim.api.nvim_win_set_cursor(0, last_cursor_pos) -- Restore cursor position
        end
        vim.cmd("wincmd =") -- Equalize window widths
    end,
})

vim.api.nvim_create_autocmd("CursorHold", {
    ---@diagnostic disable-next-line: undefined-global
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

vim.api.nvim_create_autocmd("CursorHold", {
    ---@diagnostic disable-next-line: undefined-global
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

return {
    -- extracted so I can turn it on/off
    on_cursor_hold = function(event)
        -- defined in init.lua
        if not vim.g.highlight_on_cursor_hold then
            return
        end
        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
}
