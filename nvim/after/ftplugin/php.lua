vim.cmd [[
    setlocal shiftwidth=4
]]

local api = vim.api
local lsp_formatting = api.nvim_create_augroup("LspFormatting", { clear = true })

api.nvim_create_autocmd("BufWritePost ", {
    command = "lua vim.lsp.buf.format()",
    group = lsp_formatting,
})
