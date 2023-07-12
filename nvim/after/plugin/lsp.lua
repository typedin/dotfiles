local _border = 'rounded'
require('lspconfig.ui.windows').default_options = {
    border = _border,
}
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = _border,
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = _border,
})
vim.diagnostic.config({
    float = { border = _border },
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(_, bufnr)
        -- Create your keybindings here...
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
    end,
})

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        -- Replace these with whatever servers you want to install
        'intelephense',
        'lua_ls',
        'phpactor',
        'rust_analyzer',
        'tsserver',
    },
})

local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason-lspconfig').setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            capabilities = lsp_capabilities,
        })
    end,
})
