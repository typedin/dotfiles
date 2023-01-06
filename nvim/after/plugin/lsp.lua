local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'bashls',
    'efm',
    'eslint',
    'html',
    'jsonls',
    'marksman',
    'phpactor',
    'prismals',
    'sumneko_lua',
    'tailwindcss',
    'tsserver',
    'vimls',
    'volar',
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
})

require('lspconfig').tailwindcss.setup({
    filetype = { 'antlers', 'html', 'vue', 'jsx', 'tsx', 'blade' },
})

require('lspconfig').antlersls.setup({})

-- completion
-- stylua: ignore start
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets/" } })
-- stylua: ignore end

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 3000, keyword_length = 2 },
        { name = 'luasnip', priority = 2000, keyword_length = 2 },
        { name = 'buffer', priority = 1000, keyword_length = 2 },
        { name = 'path', priority = 900, keyword_length = 2 },
        { name = 'calc', priority = 800 },
    }),
})
lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        Error = ' ',
        Warn = ' ',
        Hint = ' ',
        Info = ' ',
    },
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

-- leave this before diagnostic config
lsp.setup()

vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = true,
})
