local lsp = require('lsp-zero').preset({})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').volar.setup({
    capabilities = capabilities,
    filetype = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

require('lspconfig').volar.setup({
    capabilities = capabilities,
    filetype = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

require('lspconfig').tailwindcss.setup({
    capabilities = capabilities,
    filetype = { 'antlers', 'html', 'vue', 'jsx', 'tsx', 'blade' },
})

require('lspconfig').jsonls.setup({
    capabilities = capabilities,
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
        },
        yaml = {
            schemas = require('schemastore').yaml.schemas(),
            validate = { enable = true },
        },
    },
})

require('lspconfig').antlersls.setup({
    capabilities = capabilities,
    filetype = { 'antlers' },
})

require('lspconfig').intelephense.setup({
    capabilities = capabilities,
})

require('lspconfig').phpactor.setup({
    capabilities = capabilities,
})
lsp.set_sign_icons({
    error = require('typedin.signs').error,
    hint = require('typedin.signs').hint,
    info = require('typedin.signs').info,
    warn = require('typedin.signs').warn,
})

lsp.on_attach(function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end
    nmap('<LocalLeader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    nmap('<LocalLeader>R', vim.lsp.buf.rename, '[R]ename')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<localleader>dn', vim.diagnostic.goto_next, 'diagnostic [G]oto [N]ext')
    nmap('<localleader>dp', vim.diagnostic.goto_prev, 'diagnostic [G]oto [P]revious')
    nmap('K', vim.lsp.buf.hover, 'help do[K]ument ')
    nmap('<LocalLeader>dl', require('telescope.builtin').diagnostics, '[D]iagnostics [L]ist') -- diagnostic list
    nmap('<localleader>h', vim.lsp.buf.signature_help, 'Signature [H]elp')
end)
lsp.nvim_lua_ls()
lsp.setup()

-- You need to setup `cmp` after lsp-zero
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'calc' },
    },

    mapping = {
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    },
})

vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = true,
})
