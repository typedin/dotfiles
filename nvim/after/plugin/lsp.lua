local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.setup()

lsp.ensure_installed({
    "bashls",
    "eslint",
    "html",
    "intelephense",
    "marksman",
    "phpactor",
    "sumneko_lua",
    "tsserver",
    "volar",
    "efm",
    "eslint",
    "html",
    "jsonls",
    "marksman",
    "prismals",
    "sumneko_lua",
    "tailwindcss",
    "tsserver",
    "vimls",
    "volar",
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<Tab>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<S-Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    if client.name == "eslint" then
        vim.cmd.LspStop('eslint')
        return
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<LocalLeader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<LocalLeader>R", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<LocalLeader>dl", "<cmd>Telescope diagnostics<cr>", opts) -- diagnostic list

    vim.keymap.set("i", "<localleader>h", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<localleader>gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})
