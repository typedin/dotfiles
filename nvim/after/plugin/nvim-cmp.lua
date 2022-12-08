-- stylua: ignore start
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets/" } })
-- stylua: ignore end

local cmp = require "cmp"

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

cmp.setup {
    -- REQUIRED - you must specify a snippet engine
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            end
        end, { "i", "s" }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    preselect = true,
    sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 3000, keyword_length = 2 },
        { name = "luasnip", priority = 2000, keyword_length = 2 },
        { name = "buffer", priority = 1000, keyword_length = 2 },
        { name = "path", priority = 900, keyword_length = 2 },
        { name = "calc", priority = 800 },
    },
    formatting = {
        fields = { "menu", "abbr", "kind" },
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = "λ",
                vsnip = "⋗",
                buffer = "Ω",
                path = "🖫",
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
}
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
        { name = "cmdline" },
        { name = "path" },
    },
})
-- @see: https://github.com/onsails/lspkind.nvim
local lspkind = require "lspkind"
cmp.setup {
    formatting = {
        format = lspkind.cmp_format {
            mode = "symbol_text", -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        },
    },
}
