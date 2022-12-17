local navic = require "nvim-navic"

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local function inTable(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then
            return key
        end
    end
    return false
end

local tbl = {
    "emmet_ls",
}

local on_attach = function(client, bufnr)
    if not inTable(tbl, client["name"]) then
        navic.attach(client, bufnr)
    end
    client.server_capabilities.document_formatting = false
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set("n", "<LocalLeader>ca", vim.lsp.buf.code_action, { buffer = 0 })
    vim.keymap.set("n", "<LocalLeader>R", vim.lsp.buf.rename, { buffer = 0 })
    vim.keymap.set("n", "<LocalLeader>dl", "<cmd>Telescope diagnostics<cr>", { buffer = 0 }) -- diagnostic list
end

require("lspconfig").bashls.setup {
    filetypes = { "sh" },
    capabilities = capabilities,
    on_attach = on_attach,
}

require("lspconfig").antlersls.setup {}

require("lspconfig").gopls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require("lspconfig").marksman.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require("lspconfig").html.setup {
    filetypes = { "html", "blade", "svg" },
    capabilities = capabilities,
    on_attach = on_attach,
}

require("lspconfig").jsonls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require("lspconfig").emmet_ls.setup {
    filetypes = { "html", "vue", "blade", "css", "antlers" },
    capabilities = capabilities,
    on_attach = on_attach,
}

--[[ local null_ls = require "null-ls" ]]
--[[]]
--[[ null_ls.setup { ]]
--[[     sources = { ]]
--[[         null_ls.builtins.formatting.stylelint, ]]
--[[     }, ]]
--[[ } ]]

require("lspconfig").intelephense.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require("lspconfig").sumneko_lua.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require("lspconfig").tailwindcss.setup {
    filetypes = { "vue", "html", "blade", "jsx", "tsx", "antlers" },
}

require("lspconfig").tsserver.setup {
    debug = true,
    capabilities = capabilities,
    on_attach = on_attach,
    initializationOptions = {
        plugins = {
            {
                name = "tsconfig-paths",
                location = "~/node_modules/tsconfig-paths",
            },
        },
    },
}

require("lspconfig").volar.setup {
    -- volar by default supports Vue 3 projects. Vue 2 projects need additional configuration.
    -- https://github.com/johnsoncodehk/volar/blob/master/extensions/vscode-vue-language-features/README.md?plain=1#L28-L63
    filetypes = { "vue" },
    capabilities = capabilities,
    on_attach = on_attach,
}
