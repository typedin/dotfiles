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
        'lua_ls',
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

local cmp = require('cmp')
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
        --[[ ['<C-f>'] = cmp_action.luasnip_jump_forward(), ]]
        --[[ ['<C-b>'] = cmp_action.luasnip_jump_backward(), ]]

        ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    },
})

vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = true,
})
